# -------------- longer task sequences: Permuted MNIST, 50 tasks, TIL --------------
for global_seed in {1..5}
do
# Finetuning
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/finetuning_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/finetuning/seed_${global_seed} global_seed=${global_seed}
# LwF
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/lwf_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/lwf/seed_${global_seed} global_seed=${global_seed}
# EWC
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/ewc_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/ewc/seed_${global_seed} global_seed=${global_seed}
# HAT
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/hat/seed_${global_seed} global_seed=${global_seed}
# HAT-random
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_random_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/hat_random/seed_${global_seed} global_seed=${global_seed}
# HAT-const-alpha
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_const_alpha_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/hat_const_alpha/seed_${global_seed} global_seed=${global_seed}
# HAT-const-1
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_const_1_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/hat_const_1/seed_${global_seed} global_seed=${global_seed}
# AdaHAT
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/adahat_pmnist_50tasks cl_paradigm=TIL output_dir=output_adahat_paper/longer_tasks/pmnist_50tasks_til/adahat/seed_${global_seed} global_seed=${global_seed}
done
