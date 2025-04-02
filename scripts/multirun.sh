experiment_name=til_pmnist_ewc_fi_hat

for seed in $(seq 1 10); 
do
    clrun -- experiment=$experiment_name global_seed=$seed
done