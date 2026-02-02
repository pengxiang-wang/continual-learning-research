# -------------- main study: Permuted MNIST, 5 tasks, DIL --------------
for global_seed in {1..5}
do
# Finetuning
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/finetuning_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/finetuning/seed_${global_seed} global_seed=${global_seed}
# LwF
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/lwf/seed_${global_seed} global_seed=${global_seed}
# EWC
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/ewc/seed_${global_seed} global_seed=${global_seed}
# DER
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/der/seed_${global_seed} global_seed=${global_seed}
# DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/derpp_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/derpp/seed_${global_seed} global_seed=${global_seed}
# CLPU-DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/clpu_derpp_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/clpu_derpp/seed_${global_seed} global_seed=${global_seed}
# AmnesiacHAT
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks cl_paradigm=DIL output_dir=output_amnesiachat_paper/main_study/pmnist_5tasks_dil/amnesiachat/seed_${global_seed} global_seed=${global_seed}
done
