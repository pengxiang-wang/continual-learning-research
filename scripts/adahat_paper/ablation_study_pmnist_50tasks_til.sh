# -------------- ablation study: Permuted MNIST, 50 tasks, TIL --------------
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

for global_seed in {1..5}
do
# AdaHAT
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/adahat_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/ablation_study/pmnist_50tasks_til/adahat/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# AdaHAT-no-sum
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/adahat_no_sum_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/ablation_study/pmnist_50tasks_til/adahat_no_sum/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# AdaHAT-no-reg
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/adahat_no_reg_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/ablation_study/pmnist_50tasks_til/adahat_no_reg/seed_${global_seed}/${timestamp} global_seed=${global_seed}
done
