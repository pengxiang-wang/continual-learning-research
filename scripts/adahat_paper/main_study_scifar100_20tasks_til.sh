# -------------- main study: Split CIFAR-100, 20 tasks, TIL --------------
for global_seed in {1..5}
do
# Finetuning
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/finetuning_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/finetuning/seed_${global_seed} global_seed=${global_seed}
# LwF
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/lwf_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/lwf/seed_${global_seed} global_seed=${global_seed}
# EWC
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/ewc_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/ewc/seed_${global_seed} global_seed=${global_seed}
# HAT
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/hat/seed_${global_seed} global_seed=${global_seed}
# HAT-random
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_random_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/hat_random/seed_${global_seed} global_seed=${global_seed}
# HAT-const-alpha
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_const_alpha_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/hat_const_alpha/seed_${global_seed} global_seed=${global_seed}
# HAT-const-1
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/hat_const_1_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/hat_const_1/seed_${global_seed} global_seed=${global_seed}
# AdaHAT
clarena pipeline=CL_MAIN_EXPR index=adahat_paper/adahat_scifar100_20tasks cl_paradigm=TIL output_dir=output_adahat_paper/main_study/scifar100_20tasks_til/adahat/seed_${global_seed} global_seed=${global_seed}
done
