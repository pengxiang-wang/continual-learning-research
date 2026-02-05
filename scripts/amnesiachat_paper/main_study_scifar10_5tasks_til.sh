# -------------- main study: Split CIFAR-10, 5 tasks, TIL --------------
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

for global_seed in {1..5}
do
# Independent
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/independent_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/independent/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# Finetuning
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/finetuning_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/finetuning/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# LwF
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/lwf_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/lwf/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# EWC
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/ewc_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/ewc/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# DER
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/der_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/der/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/derpp_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/derpp/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# CLPU-DER++
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/clpu_derpp_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/clpu_derpp/seed_${global_seed}/${timestamp} global_seed=${global_seed}
# AmnesiacHAT
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_scifar10_5tasks cl_paradigm=TIL output_dir=output_amnesiachat_paper/main_study/scifar10_5tasks_til/amnesiachat/seed_${global_seed}/${timestamp} global_seed=${global_seed}
done
