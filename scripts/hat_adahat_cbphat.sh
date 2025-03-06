
for seed in $(seq 1 10); 
do
    clrun -- experiment=til_pmnist_hat global_seed=$seed
    clrun -- experiment=til_pmnist_adahat global_seed=$seed
    clrun -- experiment=til_pmnist_cbphat global_seed=$seed
done

for seed in $(seq 1 10); 
do
    clrun -- experiment=til_scifar100_hat global_seed=$seed
    clrun -- experiment=til_scifar100_adahat global_seed=$seed
    clrun -- experiment=til_scifar100_cbphat global_seed=$seed
done