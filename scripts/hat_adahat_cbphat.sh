
for seed in $(seq 1 10); 
do
    clrun -- experiment=til_pmnist_hat seed=$seed
    clrun -- experiment=til_pmnist_adahat seed=$seed
    clrun -- experiment=til_pmnist_cbphat seed=$seed
done

for seed in $(seq 1 10); 
do
    clrun -- experiment=til_scifar100_hat seed=$seed
    clrun -- experiment=til_scifar100_adahat seed=$seed
    clrun -- experiment=til_scifar100_cbphat seed=$seed
done