conda activate work

cltrain til_pmnist_finetuning --config-dir my_configs
cltrain til_pmnist_lwf --config-dir my_configs
cltrain til_pmnist_ewc --config-dir my_configs
cltrain til_pmnist_hat --config-dir my_configs
cltrain til_pmnist_adahat --config-dir my_configs

cltrain til_scifar100_finetuning --config-dir my_configs
cltrain til_scifar100_lwf --config-dir my_configs
cltrain til_scifar100_ewc --config-dir my_configs
cltrain til_scifar100_hat --config-dir my_configs
cltrain til_scifar100_adahat --config-dir my_configs
