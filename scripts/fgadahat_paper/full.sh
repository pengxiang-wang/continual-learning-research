# all scripts to run experiments for FG-AdaHAT paper

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# -------------- main study: Permuted MNIST, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_pmnist_20tasks_til.sh"

# -------------- main study: Split CIFAR-100, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_scifar100_20tasks_til.sh"

# -------------- main study: Combined-20, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_combined20_20tasks_til.sh"

# -------------- ablation study: Permuted MNIST, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/ablation_study_pmnist_20tasks_til.sh"

# -------------- hyperparameter study: Permuted MNIST, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/hyperparameter_study_pmnist_20tasks_til.sh"
