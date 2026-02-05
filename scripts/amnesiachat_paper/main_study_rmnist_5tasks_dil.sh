# -------------- main study: Rotated MNIST, 5 tasks, DIL --------------
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

for global_seed in {1..5}
do
# Finetuning
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/finetuning_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/finetuning/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# LwF
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/lwf/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# EWC
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/ewc/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# DER
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/der/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/derpp_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/derpp/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# CLPU-DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/clpu_derpp_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/clpu_derpp/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# AmnesiacHAT
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_rmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/rmnist_5tasks_dil/amnesiachat/seed_${global_seed}/${timestamp} global_seed=${global_seed}
done
