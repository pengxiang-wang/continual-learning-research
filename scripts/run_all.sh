# run all experiments in configs/experiment
for file in ./configs/experiment/*;
do
    experiment_name=$(basename "$file" | sed 's/\.[^.]*$//')
    echo "Now running: clrun -- experiment=$experiment_name"
    clrun -- experiment=$experiment_name
done