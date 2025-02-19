#!/bin/bash

# Define a list of available Mojo scripts
declare -A SCRIPTS=(
    [1]="Matrix_Multiplication/matrix_multiplication.mojo"
    [2]="Matrix_Multiplication/matrix_multiplication_numpy.mojo"
    [3]="Quick_Sort/quick_sort.mojo"
    [4]="Conways_Game_Of_Life/life.mojo"
)

# Define the log file for all results
LOG_FILE="mojo_benchmark_results.log"
echo "Mojo Benchmarking results" > "$LOG_FILE" # Overwrite the log file if it exists

# Loop through each script in the list and benchmark them
for key in "${!SCRIPTS[@]}"; do
    MOJO_SCRIPT="${SCRIPTS[$key]}"
    echo -e "\nBenchmarking Mojo script: $MOJO_SCRIPT"

    # Check if the file exists
    if [ ! -f "$MOJO_SCRIPT" ]; then
        echo "Error: File '$MOJO_SCRIPT' does not exist. Skipping."
        continue
    fi

    # Print and log the output of 'time' command
    echo -e "\nUsing 'time' for $MOJO_SCRIPT:" | tee -a "$LOG_FILE"
    /usr/bin/time -v mojo "$MOJO_SCRIPT" 2>&1 | tee -a "$LOG_FILE"

    # Print and log the output of 'hyperfine' command
    echo -e "\nUsing 'hyperfine' for $MOJO_SCRIPT:" | tee -a "$LOG_FILE"
    hyperfine --warmup 3 "mojo $MOJO_SCRIPT" | tee -a "$LOG_FILE"

    echo -e "\nFinished benchmarking $MOJO_SCRIPT" | tee -a "$LOG_FILE"
done

echo -e "\nAll scripts have been benchmarked. Results are saved to $LOG_FILE."
