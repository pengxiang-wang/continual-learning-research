import os
import re
import subprocess
import sys
from pathlib import Path


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


def main() -> int:
    # repo_root should be continual-learning-research
    repo_root = Path(__file__).resolve().parents[2]
    output_root = repo_root / "output_amnesiachat_paper" / "main_study"

    if not output_root.exists():
        print(f"Missing output root: {output_root}")
        return 1

    # Ensure clarena module is importable
    clarena_repo = repo_root.parent / "continual-learning-arena"
    env = os.environ.copy()
    env["PYTHONPATH"] = (
        str(clarena_repo) + os.pathsep + env.get("PYTHONPATH", "")
    )
    env["HYDRA_FULL_ERROR"] = "1"
    env["PYTHONUNBUFFERED"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"
    env["RICH_DISABLE"] = "1"

    # hydra config name should not include the .yaml extension
    config_name = "index/amnesiachat_paper/cul_full_eval_euclidean"

    runs = []
    for dataset_dir in sorted(output_root.iterdir()):
        if not dataset_dir.is_dir():
            continue
        for method_dir in sorted(dataset_dir.iterdir()):
            if not method_dir.is_dir():
                continue
            seed_dir = method_dir / "seed_1"
            if not seed_dir.exists():
                continue
            for run_dir in sorted(seed_dir.iterdir()):
                if not run_dir.is_dir():
                    continue
                if not (run_dir / "results" / "acc.csv").exists():
                    continue
                runs.append((dataset_dir.name, method_dir.name, run_dir))

    if not runs:
        print("No runs found.")
        return 0

    print(f"Found {len(runs)} runs. Recomputing DD (linear_cka) and overwriting dd.csv...")

    for dataset_name, method_name, run_dir in runs:
        try:
            cl_dataset, cl_paradigm, num_tasks = dataset_info(dataset_name)
        except Exception as e:
            print(f"[SKIP] {dataset_name}/{method_name}: {e}")
            continue

        main_model = run_dir / "saved_models" / "cl_model.pth"
        refretrain_model = run_dir / "refretrain" / "saved_models" / "cl_model.pth"
        reforiginal_model = run_dir / "reforiginal" / "saved_models" / "cl_model.pth"

        if not main_model.exists():
            print(f"[SKIP] {run_dir}: missing main model")
            continue
        if not refretrain_model.exists():
            print(f"[SKIP] {run_dir}: missing refretrain model")
            continue
        if not reforiginal_model.exists():
            print(f"[SKIP] {run_dir}: missing reforiginal model")
            continue

        dd_path = run_dir / "results" / "dd.csv"
        before_mtime = dd_path.stat().st_mtime if dd_path.exists() else None

        cmd = [
            sys.executable,
            "-u",
            "-c",
            "from clarena.cli import clarena; clarena()",
            "--config-name",
            config_name,
            f"pipeline=CUL_FULL_EVAL",
            f"dd_eval_tasks={num_tasks}",
            f"ag_eval_tasks={num_tasks}",
            f"global_seed=1",
            f"cl_paradigm={cl_paradigm}",
            f"cl_dataset={cl_dataset}",
            "trainer=cpu_eval.yaml",
            f"main_model_path={main_model.as_posix()}",
            f"refretrain_model_path={refretrain_model.as_posix()}",
            f"reforiginal_model_path={reforiginal_model.as_posix()}",
            f"output_dir={run_dir.as_posix()}",
            "metrics=cul_full_eval_default.yaml",
            "metrics.0.distribution_distance_type=linear_cka",
        ]

        print(f"[RUN] {dataset_name}/{method_name}/{run_dir.name}")
        result = subprocess.run(
            cmd,
            cwd=str(repo_root),
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
        )
        log_path = run_dir / "results" / "dd_eval_stdout.log"
        try:
            log_path.write_text(result.stdout, encoding="utf-8")
        except Exception:
            # best-effort logging only
            pass
        if result.returncode != 0:
            print(f"[FAIL] {dataset_name}/{method_name}/{run_dir.name}")
            print(result.stdout)
        else:
            if dd_path.exists():
                ts = dd_path.stat().st_mtime
                print(
                    f"[OK] {dataset_name}/{method_name}/{run_dir.name} | "
                    f"dd.csv mtime={ts:.0f}"
                )
                # warn if dd.csv not updated recently (likely no write)
                if before_mtime is not None and ts == before_mtime:
                    print(
                        "     WARNING: dd.csv mtime unchanged; eval may not have written."
                    )
                if log_path.exists():
                    print(f"     stdout log: {log_path}")
            else:
                print(
                    f"[OK] {dataset_name}/{method_name}/{run_dir.name} | dd.csv MISSING"
                )
                if log_path.exists():
                    print(f"     stdout log: {log_path}")

    print("Done.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
