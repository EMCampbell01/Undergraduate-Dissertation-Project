#!/bin/bash

# Define a list of available Python scripts
declare -A SCRIPTS=(
    [1]="Matrix_Multiplication/matrix_multiplication.py"
    [2]="Matrix_Multiplication/matrix_multiplication_numpy.py"
    [3]="Quick_Sort/quick_sort.py"
    [4]="Conways_Game_Of_Life/life.py"
)

# Display the list of scripts for the user to choose from
echo "Available scripts for benchmarking:"
for key in "${!SCRIPTS[@]}"; do
    echo "$key) ${SCRIPTS[$key]}"
done

# Prompt the user to select a script
read -p "Enter the number of the script you want to benchmark: " SELECTION

# Check if the selection is valid
if [[ -z "${SCRIPTS[$SELECTION]}" ]]; then
    echo "Invalid selection. Exiting."
    exit 1
fi

PYTHON_SCRIPT="${SCRIPTS[$SELECTION]}"
echo "Benchmarking Python script: $PYTHON_SCRIPT"

# Check if the file exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: File '$PYTHON_SCRIPT' does not exist."
    exit 1
fi

echo -e "\nUsing 'time':"
/usr/bin/time -v python3 "$PYTHON_SCRIPT" 2>&1 | tee time_benchmark.log

echo -e "\nUsing 'hyperfine':"
hyperfine --warmup 3 "python3 $PYTHON_SCRIPT" | tee hyperfine_benchmark.log
