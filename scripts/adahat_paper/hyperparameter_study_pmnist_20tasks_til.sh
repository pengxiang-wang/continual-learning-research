# -------------- hyperparameter study: Permuted MNIST, 20 tasks, TIL --------------
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

for global_seed in {1..5}
do
for alpha in 1e-7 2e-7 3e-7 4e-7 5e-7 6e-7 7e-7 8e-7 9e-7 1e-6 2e-6 3e-6 4e-6 5e-6 6e-6 7e-6 8e-6 9e-6 1e-5
do
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/adahat_pmnist_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/hyperparameter_study/pmnist_20tasks_til/alpha_${alpha}/seed_${global_seed}/${timestamp} global_seed=${global_seed} cl_algorithm.adjustment_intensity=${alpha}
done
done
