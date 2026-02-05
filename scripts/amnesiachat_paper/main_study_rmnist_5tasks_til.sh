# -------------- main study: Rotated MNIST, 5 tasks, TIL --------------
for global_seed in {1..5}
do
# Independent
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/independent_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/independent/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# Finetuning
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/finetuning_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/finetuning/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# LwF
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/lwf/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# EWC
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/ewc/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# DER
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/der/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/derpp_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/derpp/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# CLPU-DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/clpu_derpp_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/clpu_derpp/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
# AmnesiacHAT
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_rmnist_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_til/amnesiachat/seed_${global_seed}/${misc.timestamp} global_seed=${global_seed}
done
