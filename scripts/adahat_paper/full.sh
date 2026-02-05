# all scripts to run experiments for AdaHAT paper

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# -------------- main study: Permuted MNIST, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_pmnist_20tasks_til.sh"

# -------------- main study: Split CIFAR-100, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_scifar100_20tasks_til.sh"

# -------------- longer task sequences: Permuted MNIST, 50 tasks, TIL --------------
bash "$SCRIPT_DIR/longer_tasks_pmnist_50tasks_til.sh"

# -------------- ablation study: Permuted MNIST, 50 tasks, TIL --------------
bash "$SCRIPT_DIR/ablation_study_pmnist_50tasks_til.sh"

# -------------- hyperparameter study: Permuted MNIST, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/hyperparameter_study_pmnist_20tasks_til.sh"
