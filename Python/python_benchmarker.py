import time
from Quick_Sort.quick_sort import quick_sort, generate_unsorted_list
from Matrix_Multiplication.matrix_multiplication import generate_random_matrix, matrix_multiply
from A_Star.a_star import Graph
from Conways_Game_Of_Life.life import run_display, generate_random_grid

# Decorator to benchmark functions
def benchmark(iterations=100, log_file="python_internal_benchmark_results.log"):
    def decorator(func):
        def wrapper(setup_func, *args, **kwargs):
            times = []
            for _ in range(iterations):
                setup_data = setup_func()

                start_time = time.time()
                func(setup_data, *args, **kwargs)
                end_time = time.time()

                times.append(end_time - start_time)

            min_time = min(times)
            max_time = max(times)
            mean_time = sum(times) / len(times)

            result_str = (f"Benchmarking {func.__name__} function\n"
                          f"Benchmark over {iterations} iterations:\n"
                          f"Min time: {min_time:.6f} seconds\n"
                          f"Max time: {max_time:.6f} seconds\n"
                          f"Mean time: {mean_time:.6f} seconds\n\n")

            # Print the results to the console
            print(result_str)

            # Write the results to the log file
            with open(log_file, "a") as f:
                f.write(result_str)

        return wrapper
    return decorator

# Benchmark functions
@benchmark(iterations=100)
def benchmark_quick_sort(unsorted_list):
    quick_sort(unsorted_list)

@benchmark(iterations=100)
def benchmark_matrix_multiplication(matrices):
    matrix_a, matrix_b = matrices
    matrix_multiply(matrix_a, matrix_b)
    
@benchmark(iterations=100)
def benchmark_a_star(graph):
    path = graph.get_path("A", "E")
    
@benchmark(iterations=10)
def benchmark_conways_game_of_life(grid):
    run_display(grid)

# Setup functions
def setup_quick_sort():
    return generate_unsorted_list()

def setup_matrix_multiplication():
    matrix_a = generate_random_matrix(100, 100)
    matrix_b = generate_random_matrix(100, 100)
    return matrix_a, matrix_b

def setup_a_star():
    with open(r"Python/A_star/graph.json", "r") as f:
        json_string = f.read()
    graph = Graph().from_json(json_string)
    return graph

def setup_conways_game_of_life():
    return generate_random_grid(128, 128)

# Run the benchmarks
benchmark_quick_sort(setup_quick_sort)
benchmark_matrix_multiplication(setup_matrix_multiplication)
benchmark_a_star(setup_a_star)
benchmark_conways_game_of_life(setup_conways_game_of_life)
