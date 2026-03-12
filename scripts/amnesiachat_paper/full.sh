# all scripts to run experiments for AmnesiaHAT paper

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# -------------- main study: Permuted MNIST, 5 tasks, DIL --------------
bash "$SCRIPT_DIR/main_study_pmnist_5tasks_dil.sh"

# -------------- main study: Permuted MNIST, 5 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_pmnist_5tasks_til.sh"

# -------------- main study: Rotated MNIST, 5 tasks, DIL --------------
bash "$SCRIPT_DIR/main_study_rmnist_5tasks_dil.sh"

# -------------- main study: Rotated MNIST, 5 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_rmnist_5tasks_til.sh"

# -------------- main study: Split CIFAR-10, 5 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_scifar10_5tasks_til.sh"

# -------------- main study: Permuted MNIST, 20 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_pmnist_20tasks_til.sh"

# -------------- main study: Combined-5, 5 tasks, TIL --------------
bash "$SCRIPT_DIR/main_study_combined_simple_5tasks_til.sh"

# -------------- ablation study: Permuted MNIST, 5 tasks, TIL --------------
bash "$SCRIPT_DIR/ablation_study_pmnist_5tasks_til.sh"

# -------------- hyperparameter study: Permuted MNIST, 5 tasks, TIL --------------
bash "$SCRIPT_DIR/hyperparameter_study.sh"
