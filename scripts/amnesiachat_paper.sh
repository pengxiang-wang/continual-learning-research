# all scripts to run experiments for AmnesiaHAT paper


# main study: Permuted MNIST, 5 tasks, TIL
for global_seed in {1..5}
do
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/independent_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/independent/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/finetuning_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/finetuning/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/lwf/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/ewc/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/der/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/amnesiachat/seed_${global_seed} global_seed=${global_seed}
done

# main study: Split MNIST, 5 tasks, TIL
for global_seed in {1..5}
do
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/independent_smnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/smnist_5tasks_til/independent/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/finetuning_smnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/smnist_5tasks_til/finetuning/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_smnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/smnist_5tasks_til/lwf/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_smnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/smnist_5tasks_til/ewc/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_smnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/smnist_5tasks_til/der/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_smnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/smnist_5tasks_til/amnesiachat/seed_${global_seed} global_seed=${global_seed}
done


# main study: Permuted MNIST, 5 tasks, DIL
for global_seed in {1..5}
do
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/independent_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/independent/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/finetuning_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/finetuning/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/lwf/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/ewc/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_til/der/seed_${global_seed} global_seed=${global_seed}
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/amnesiachat/seed_${global_seed} global_seed=${global_seed}
done


# ablation study: Permuted MNIST, 5 tasks, TIL
for global_seed in {1..5}
do
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat/seed_${global_seed} global_seed=${global_seed} cul_algorithm.if_backup_compensation=true cul_algorithm.if_replay_fixing=true
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat_no_backup_compensation/seed_${global_seed} global_seed=${global_seed} cul_algorithm.if_backup_compensation=false cul_algorithm.if_replay_fixing=true
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat_no_replay_repairing/seed_${global_seed} global_seed=${global_seed} cul_algorithm.if_backup_compensation=true cul_algorithm.if_replay_fixing=false
clarena pipeline=CUL_FULL_EXPR index=amnnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat_no_backup_compensation_no_replay_repairing/seed_${global_seed} global_seed=${global_seed} cul_algorithm.if_backup_compensation=false cul_algorithm.if_replay_fixing=false
done

# hyperparameter study