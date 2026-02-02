# -------------- main study: Permuted MNIST, 20 tasks, TIL --------------
for global_seed in {1..10}
do
# Finetuning
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/finetuning_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/finetuning/seed_${global_seed} global_seed=${global_seed}
# LwF
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/lwf_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/lwf/seed_${global_seed} global_seed=${global_seed}
# HAT
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/hat_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/hat/seed_${global_seed} global_seed=${global_seed}
# AdaHAT
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/adahat_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/adahat/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (IG)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_ig_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_ig/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (OG)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_og_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_og/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (CU)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_cu_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_cu/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (ICU)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_icu_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_icu/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (AFI)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_afi_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_afi/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (FA)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_fa_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_fa/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (II)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_ii_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_ii/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (GS)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_gs_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_gs/seed_${global_seed} global_seed=${global_seed}
# FG-AdaHAT (DL)
clarena pipeline=CL_MAIN_EXPR index=fgadahat_paper/fgadahat_dl_pmnist_20tasks cl_paradigm=TIL output_dir=output_fgadahat_paper/main_study/pmnist_20tasks_til/fgadahat_dl/seed_${global_seed} global_seed=${global_seed}
done
