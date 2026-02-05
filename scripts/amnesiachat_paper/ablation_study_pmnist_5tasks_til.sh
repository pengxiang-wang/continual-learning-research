# -------------- ablation study: Permuted MNIST, 5 tasks, TIL --------------
for global_seed in {1..5}
do
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed} cul_algorithm.if_backup_compensation=true cul_algorithm.if_replay_repairing=true
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat_no_backup_compensation/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed} cul_algorithm.if_backup_compensation=false cul_algorithm.if_replay_repairing=true
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat_no_replay_repairing/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed} cul_algorithm.if_backup_compensation=true cul_algorithm.if_replay_repairing=false
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/ablation_study/pmnist_5tasks_til/amnesiachat_no_backup_compensation_no_replay_repairing/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed} cul_algorithm.if_backup_compensation=false cul_algorithm.if_replay_repairing=false
done
