#!/bin/bash

# Define a list of available Python scripts
declare -A SCRIPTS=(
    [1]="Python/Matrix_Multiplication/matrix_multiplication.py"
    [2]="Python/Matrix_Multiplication/matrix_multiplication_numpy.py"
    [3]="Python/Quick_Sort/quick_sort.py"
    [4]="Python/Conways_Game_Of_Life/life.py"
)

# Define the log file for all results
LOG_FILE="python_macro_benchmark_results.log"
echo "Benchmarking results" > "$LOG_FILE" # Overwrite the log file if it exists

# Loop through each script in the list and benchmark them
for key in "${!SCRIPTS[@]}"; do
    PYTHON_SCRIPT="${SCRIPTS[$key]}"
    echo -e "\nBenchmarking Python script: $PYTHON_SCRIPT"

    # Check if the file exists
    if [ ! -f "$PYTHON_SCRIPT" ]; then
        echo "Error: File '$PYTHON_SCRIPT' does not exist. Skipping."
        continue
    fi

    # Print and log the output of 'time' command
    echo -e "\nUsing 'time' for $PYTHON_SCRIPT:" | tee -a "$LOG_FILE"
    /usr/bin/time -v python3 "$PYTHON_SCRIPT" 2>&1 | tee -a "$LOG_FILE"

    # Print and log the output of 'hyperfine' command
    echo -e "\nUsing 'hyperfine' for $PYTHON_SCRIPT:" | tee -a "$LOG_FILE"
    hyperfine --warmup 3 "python3 $PYTHON_SCRIPT" | tee -a "$LOG_FILE"

    echo -e "\nFinished benchmarking $PYTHON_SCRIPT" | tee -a "$LOG_FILE"
done

echo -e "\nAll scripts have been benchmarked. Results are saved to $LOG_FILE."
