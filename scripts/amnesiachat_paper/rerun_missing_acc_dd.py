import argparse
import os
import re
import subprocess
import sys
from datetime import datetime
from pathlib import Path


def parse_dataset_dir(name: str) -> tuple[str, str]:
    """Return (base_name, cl_paradigm) from dataset dir like 'pmnist_5tasks_til'."""
    if name.endswith("_til"):
        return name[: -len("_til")], "TIL"
    if name.endswith("_dil"):
        return name[: -len("_dil")], "DIL"
    raise ValueError(f"Unknown dataset dir name: {name}")


def dataset_info(dataset_dir_name: str) -> tuple[str, str, int]:
    """Return (cl_dataset_cfg, cl_paradigm, num_tasks) from dataset dir name."""
    name = dataset_dir_name

    if name.startswith("pmnist_"):
        cl_dataset = "permuted_mnist.yaml"
    elif name.startswith("rmnist_"):
        cl_dataset = "rotated_mnist.yaml"
    elif name.startswith("smnist_"):
        cl_dataset = "split_mnist.yaml"
    elif name.startswith("scifar10_"):
        cl_dataset = "split_cifar10.yaml"
    elif name.startswith("scifar100_"):
        # 5-task split has a dedicated config
        cl_dataset = "split_cifar100_5tasks.yaml"
    else:
        raise ValueError(f"Unknown dataset dir name: {name}")

    if name.endswith("_til"):
        cl_paradigm = "TIL"
    elif name.endswith("_dil"):
        cl_paradigm = "DIL"
    else:
        raise ValueError(f"Unknown paradigm in dataset dir name: {name}")

    m = re.search(r"_(\d+)tasks_", name)
    if not m:
        raise ValueError(f"Cannot parse num_tasks from dataset dir name: {name}")
    num_tasks = int(m.group(1))

    return cl_dataset, cl_paradigm, num_tasks


def parse_seed(seed_dir_name: str) -> int:
    m = re.match(r"seed_(\d+)$", seed_dir_name)
    if not m:
        raise ValueError(f"Invalid seed dir name: {seed_dir_name}")
    return int(m.group(1))


def find_missing_seed_dirs(
    output_root: Path,
    *,
    only_5tasks: bool,
    only_seed_paths: set[Path] | None,
) -> list[tuple[Path, bool, bool]]:
    missing = []
    for study_dir in (output_root / "main_study", output_root / "ablation_study"):
        if not study_dir.exists():
            continue
        for dataset_dir in sorted(study_dir.iterdir()):
            if not dataset_dir.is_dir():
                continue
            if only_5tasks and "5tasks" not in dataset_dir.name:
                continue
            for method_dir in sorted(dataset_dir.iterdir()):
                if not method_dir.is_dir():
                    continue
                for seed_dir in sorted(method_dir.iterdir()):
                    if not seed_dir.is_dir() or not seed_dir.name.startswith("seed_"):
                        continue
                    if only_seed_paths is not None and seed_dir not in only_seed_paths:
                        continue
                    has_acc = any(seed_dir.rglob("acc_matrix.png"))
                    has_dd = any(seed_dir.rglob("dd.png"))
                    if not (has_acc and has_dd):
                        missing.append((seed_dir, has_acc, has_dd))
    return missing


def build_cmd(
    *,
    repo_root: Path,
    output_dir: Path,
    index_key: str,
    cl_paradigm: str,
    global_seed: int,
    extra_args: list[str],
) -> list[str]:
    cmd = [
        sys.executable,
        "-u",
        "-c",
        "from clarena.cli import clarena; clarena()",
        "pipeline=CUL_FULL_EXPR",
        f"index=amnesiachat_paper/{index_key}",
        f"cl_paradigm={cl_paradigm}",
        f"output_dir={output_dir.as_posix()}",
        f"global_seed={global_seed}",
    ]
    cmd.extend(extra_args)
    return cmd


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Rerun missing acc_matrix.png or dd.png seeds for amnesiachat paper."
    )
    parser.add_argument("--dry-run", action="store_true", help="Print commands only.")
    parser.add_argument(
        "--all-tasks",
        action="store_true",
        help="Include 20-task datasets as well (default: only 5tasks).",
    )
    parser.add_argument(
        "--only-seeds-file",
        type=str,
        default="",
        help="Path to a text file listing seed directories to rerun (one per line).",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[2]
    output_root = repo_root / "output_amnesiachat_paper"

    if not output_root.exists():
        print(f"Missing output root: {output_root}")
        return 1

    only_seed_paths: set[Path] | None = None
    if args.only_seeds_file:
        only_seed_paths = set()
        seed_file = Path(args.only_seeds_file)
        if not seed_file.is_file():
            print(f"Seed list file not found: {seed_file}")
            return 1
        for line in seed_file.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            only_seed_paths.add(Path(line))

    missing = find_missing_seed_dirs(
        output_root, only_5tasks=not args.all_tasks, only_seed_paths=only_seed_paths
    )
    if not missing:
        print("No missing acc_matrix.png or dd.png found.")
        return 0

    clarena_repo = repo_root.parent / "continual-learning-arena"
    env = os.environ.copy()
    env["PYTHONPATH"] = str(clarena_repo) + os.pathsep + env.get("PYTHONPATH", "")
    env["HYDRA_FULL_ERROR"] = "1"
    env["PYTHONUNBUFFERED"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"

    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")

    method_map = {
        "amnesiachat": "amnesiachat",
        "clpu_derpp": "clpu_derpp",
        "der": "der",
        "derpp": "derpp",
        "ewc": "ewc",
        "finetuning": "finetuning",
        "independent": "independent",
        "lwf": "lwf",
    }

    total = len(missing)
    print(f"Found {total} missing seeds. Rerunning into timestamp: {timestamp}")

    for i, (seed_dir, has_acc, has_dd) in enumerate(missing, start=1):
        # seed_dir: .../output_amnesiachat_paper/{study}/{dataset}/{method}/seed_x
        method_dir = seed_dir.parent
        dataset_dir = method_dir.parent
        study_dir = dataset_dir.parent

        try:
            base_name, cl_paradigm = parse_dataset_dir(dataset_dir.name)
            global_seed = parse_seed(seed_dir.name)
        except Exception as e:
            print(f"[SKIP] {seed_dir}: {e}")
            continue

        method = method_dir.name
        extra_args: list[str] = []

        if study_dir.name == "ablation_study":
            # Only amnesiachat variants in ablation study.
            index_key = f"amnesiachat_{base_name}"
            if method == "amnesiachat":
                extra_args = [
                    "cul_algorithm.if_backup_compensation=true",
                    "cul_algorithm.if_replay_repairing=true",
                ]
            elif method == "amnesiachat_no_backup_compensation":
                extra_args = [
                    "cul_algorithm.if_backup_compensation=false",
                    "cul_algorithm.if_replay_repairing=true",
                ]
            elif method == "amnesiachat_no_replay_repairing":
                extra_args = [
                    "cul_algorithm.if_backup_compensation=true",
                    "cul_algorithm.if_replay_repairing=false",
                ]
            elif method == "amnesiachat_no_backup_compensation_no_replay_repairing":
                extra_args = [
                    "cul_algorithm.if_backup_compensation=false",
                    "cul_algorithm.if_replay_repairing=false",
                ]
            else:
                print(f"[SKIP] {seed_dir}: unknown ablation method '{method}'")
                continue
        else:
            # main_study
            if method not in method_map:
                print(f"[SKIP] {seed_dir}: unknown method '{method}'")
                continue
            index_key = f"{method_map[method]}_{base_name}"

        output_dir = (
            output_root
            / study_dir.name
            / dataset_dir.name
            / method
            / f"seed_{global_seed}"
            / timestamp
        )

        cmd = build_cmd(
            repo_root=repo_root,
            output_dir=output_dir,
            index_key=index_key,
            cl_paradigm=cl_paradigm,
            global_seed=global_seed,
            extra_args=extra_args,
        )

        status = "acc_matrix" if not has_acc else ""
        if not has_dd:
            status = f"{status}+dd" if status else "dd"
        print(
            f"[{i}/{total}] [RUN] {study_dir.name}/{dataset_dir.name}/{method}/seed_{global_seed} | missing={status}"
        )
        print("      " + " ".join(cmd))

        if args.dry_run:
            continue

        output_dir.mkdir(parents=True, exist_ok=True)
        log_path = output_dir / "rerun_stdout.log"
        try:
            log_file = log_path.open("w", encoding="utf-8")
        except Exception:
            log_file = None

        process = subprocess.Popen(
            cmd,
            cwd=str(repo_root),
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            bufsize=1,
        )

        # Stream output to console (so you can see progress) and also save to log.
        assert process.stdout is not None
        for line in process.stdout:
            print(line, end="")
            if log_file is not None:
                try:
                    log_file.write(line)
                except Exception:
                    pass
        if log_file is not None:
            log_file.close()

        returncode = process.wait()
        if returncode != 0:
            print(f"[{i}/{total}] [FAIL] {seed_dir}")
        else:
            print(f"[{i}/{total}] [OK] {seed_dir}")

        # Ensure dd.png exists; if missing, run CUL_FULL_EVAL for this run.
        dd_png = output_dir / "results" / "dd.png"
        if dd_png.exists():
            continue

        print(f"[{i}/{total}] [POST] dd.png missing; running CUL_FULL_EVAL...")
        try:
            cl_dataset, cl_paradigm, num_tasks = dataset_info(dataset_dir.name)
        except Exception as e:
            print(f"[{i}/{total}] [POST][SKIP] {output_dir}: {e}")
            continue

        main_model = output_dir / "saved_models" / "cl_model.pth"
        refretrain_model = output_dir / "refretrain" / "saved_models" / "cl_model.pth"
        reforiginal_model = output_dir / "reforiginal" / "saved_models" / "cl_model.pth"

        if not main_model.exists() or not refretrain_model.exists() or not reforiginal_model.exists():
            print(
                f"[{i}/{total}] [POST][SKIP] missing models for dd eval: "
                f"main={main_model.exists()} refretrain={refretrain_model.exists()} "
                f"reforiginal={reforiginal_model.exists()}"
            )
            continue

        eval_cmd = [
            sys.executable,
            "-u",
            "-c",
            "from clarena.cli import clarena; clarena()",
            "--config-name",
            "index/amnesiachat_paper/cul_full_eval_euclidean",
            "pipeline=CUL_FULL_EVAL",
            f"dd_eval_tasks={num_tasks}",
            f"ag_eval_tasks={num_tasks}",
            f"global_seed={global_seed}",
            f"cl_paradigm={cl_paradigm}",
            f"cl_dataset={cl_dataset}",
            "trainer=cpu_eval.yaml",
            f"main_model_path={main_model.as_posix()}",
            f"refretrain_model_path={refretrain_model.as_posix()}",
            f"reforiginal_model_path={reforiginal_model.as_posix()}",
            f"output_dir={output_dir.as_posix()}",
            "metrics=cul_full_eval_default.yaml",
        ]

        eval_log_path = output_dir / "results" / "dd_eval_stdout.log"
        try:
            eval_log_file = eval_log_path.open("w", encoding="utf-8")
        except Exception:
            eval_log_file = None

        eval_proc = subprocess.Popen(
            eval_cmd,
            cwd=str(repo_root),
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            bufsize=1,
        )
        assert eval_proc.stdout is not None
        for line in eval_proc.stdout:
            print(line, end="")
            if eval_log_file is not None:
                try:
                    eval_log_file.write(line)
                except Exception:
                    pass
        if eval_log_file is not None:
            eval_log_file.close()

        eval_rc = eval_proc.wait()
        if eval_rc != 0:
            print(f"[{i}/{total}] [POST][FAIL] dd eval failed for {output_dir}")
        else:
            if dd_png.exists():
                print(f"[{i}/{total}] [POST][OK] dd.png generated.")
            else:
                print(f"[{i}/{total}] [POST][WARN] dd.png still missing.")

    print("Done.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
