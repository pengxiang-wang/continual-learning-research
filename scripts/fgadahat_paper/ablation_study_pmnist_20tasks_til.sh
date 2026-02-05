# -------------- ablation study: Permuted MNIST, 20 tasks, TIL --------------
for global_seed in {1..10}
do
# FG-AdaHAT (ICU)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_icu_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/ablation_study/pmnist_20tasks_til/fgadahat/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# Case 1 (no linear term)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_case1_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/ablation_study/pmnist_20tasks_til/case1_no_linear/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# Case 2 (no base linear)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_case2_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/ablation_study/pmnist_20tasks_til/case2_no_base_linear/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# AdaHAT
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/adahat_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/ablation_study/pmnist_20tasks_til/adahat/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
done
