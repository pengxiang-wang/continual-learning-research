# -------------- hyperparameter study: Permuted MNIST, 20 tasks, TIL --------------
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

for global_seed in {1..10}
do
for alpha in 1e-7 1.2e-7 1.5e-7 2e-7 3e-7

do
for base_linear in 1 5 10 20

do
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_icu_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/hyperparameter_study/pmnist_20tasks_til/alpha_${alpha}_baseL_${base_linear}/seed_${global_seed}/${timestamp} global_seed=${global_seed} cl_algorithm.adjustment_intensity=${alpha} cl_algorithm.base_linear=${base_linear}
done
done
done
