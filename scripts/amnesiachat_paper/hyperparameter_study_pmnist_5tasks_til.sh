# -------------- hyperparameter study: AmnesiacHAT on PMNIST 5 tasks (TIL) --------------
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

for global_seed in {1..5}
do
for buffer_size in 20 50 200
do
for repair_num_steps in 50 125 500
do
clarena pipeline=CUL_FULL_EXPR index=amnesiachat_paper/amnesiachat_pmnist_5tasks_hparam cl_paradigm=TIL \
  cl_algorithm.buffer_size=${buffer_size} cul_algorithm.repair_num_steps=${repair_num_steps} \
  output_dir=output_amnesiachat_paper/hyperparameter/pmnist_5tasks_til/amnesiachat/b${buffer_size}_s${repair_num_steps}/seed_${global_seed}/${timestamp} \
  global_seed=${global_seed}
done
done
done