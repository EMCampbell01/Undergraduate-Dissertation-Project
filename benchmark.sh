#!/bin/bash

# Function to activate and run Mojo script
run_mojo() {

  echo "cd into Mojo"
  cd Mojo
  echo "Running Mojo script..."
  magic run "mojo mojo_micro_benchmarker.mojo"

  echo "cd out of Mojo"
  cd ..
}

# Function to activate and run Python script
run_python() {
  echo "Activating Python virtual environment..."
  # Activate Python virtual environment
  source Python/myenv/bin/activate

  # Run Python script
  echo "Running Python script..."
  python Python/python_micro_benchmarker.py

  # Deactivate Python virtual environment
  echo "Deactivating Python virtual environment..."
  deactivate
}

# Run Mojo script
run_mojo

# Run Python script
run_python

echo "Both Mojo and Python scripts have been executed."
