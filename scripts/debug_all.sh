# debug all experiments in configs/experiment, with 1 epoch, 2 tasks
for file in ./configs/experiment/*; 
do
    experiment_name=$(basename "$file" | sed 's/\.[^.]*$//')
    echo "Now debugging: clrun -- experiment=$experiment_name"
    clrun -- experiment=$experiment_name trainer.max_epochs=1 num_tasks=2
done