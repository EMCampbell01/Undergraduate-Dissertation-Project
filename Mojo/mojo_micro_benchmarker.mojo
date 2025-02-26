from Quick_Sort.quick_sort import quick_sort, generate_unsorted_list_python
from Matrix_Multiplication.matrix_multiplication import generate_random_matrix, matrix_multiply
from A_Star.a_star import Graph
from Conways_Game_Of_Life.life import run_display, generate_random_grid
from time import monotonic

def calculate_stats(times: List[Int]) -> List[Float64]:
    sum_time = 0
    min_time = times[0]
    max_time = times[0]

    for pointer in times:
        time = pointer[]
        sum_time += time
        if time < min_time:
            min_time = time
        if time > max_time:
            max_time = time

    average = sum_time / len(times)

    result = List[Float64]()
    result.append(min_time)
    result.append(max_time)
    result.append(average)

    return result

def write_stats(file_path: String, stats: List[Float64], benchmark_name: String, iterations: Int) -> None:

    with open(file_path, "w") as file:

        file.write("Benchmarking " + benchmark_name + " function\n")
        file.write("Benchmark over: " + str(iterations) + " iterations\n")
        file.write("Min time: " + str(stats[0]) + " ns\n")
        file.write("Max time: " + str(stats[1]) + " ns\n")
        file.write("Mean time: " + str(stats[2]) + " ns\n\n")

# Run the benchmarks
def main():
    # Open the file to write the benchmarking results
    file_path = "../mojo_micro_benchmarking.log"
    with open(file_path, "w") as file:
        quick_sort_times = List[Int]()
        
        for i in range(100):
            unsorted_list = generate_unsorted_list_python(1000)
            start_time = monotonic()
            quick_sort(unsorted_list)
            end_time = monotonic()
            time = end_time - start_time
            quick_sort_times.append(time)

        sum_time = 0
        min_time = quick_sort_times[0]
        max_time = quick_sort_times[0]

        for pointer in quick_sort_times:
            time = pointer[]
            sum_time += time
            if time < min_time:
                min_time = time 
            if time > max_time:
                max_time = time 

        average = sum_time / len(quick_sort_times)

        # Write the results to the file using string concatenation
        file.write("Benchmarking benchmark_quick_sort function\n")
        file.write("Benchmark over: " + str(len(quick_sort_times)) + " iterations\n")
        file.write("Min time: " + str(min_time) + " ns\n")
        file.write("Max time: " + str(max_time) + " ns\n")
        file.write("Mean time: " + str(average) + " ns\n\n")

        json_string = String()

        try:
            with open("A_Star/graph.json", "r") as f:
                json_string = f.read()
        except:
            file.write("Error occurred while reading the graph.json file.\n")
            return

        graph = Graph.from_json(json_string)
        a_star_times = List[Int]()

        for i in range(100):
            start_time = monotonic()
            graph.get_path("A", "E")
            end_time = monotonic()
            time = end_time - start_time
            a_star_times.append(time)

        for pointer in a_star_times:
            time = pointer[]
            sum_time += time
            if time < min_time:
                min_time = time
            if time > max_time:
                max_time = time

        average = sum_time / len(a_star_times)

        # Write a_star benchmarking results using string concatenation
        file.write("Benchmarking benchmark_a_star function\n")
        file.write("Benchmark over: " + str(len(a_star_times)) + " iterations\n")
        file.write("Min time: " + str(min_time) + " ns\n")
        file.write("Max time: " + str(max_time) + " ns\n")
        file.write("Mean time: " + str(average) + " ns\n\n")

        life_times = List[Int]()

        for i in range(10):
            start_grid = generate_random_grid()
            start_time = monotonic()
            run_display(start_grid)
            end_time = monotonic()
            time = end_time - start_time
            life_times.append(time)

        for pointer in life_times:
            time = pointer[]
            sum_time += time
            if time < min_time:
                min_time = time
            if time > max_time:
                max_time = time

        average = sum_time / len(life_times)

        # Write game of life benchmarking results using string concatenation
        file.write("Benchmarking benchmark_game_of_life function\n")
        file.write("Benchmark over: " + str(len(life_times)) + " iterations\n")
        file.write("Min time: " + str(min_time) + " ns\n")
        file.write("Max time: " + str(max_time) + " ns\n")
        file.write("Mean time: " + str(average) + " ns\n\n")

        matrix_times = List[Int]()

        for i in range(100):
            A = generate_random_matrix(100, 100)
            B = generate_random_matrix(100, 100)
            start_time = monotonic()
            matrix_multiply(A, B)
            end_time = monotonic()
            time = end_time - start_time
            matrix_times.append(time)

        for pointer in matrix_times:
            time = pointer[]
            sum_time += time
            if time < min_time:
                min_time = time
            if time > max_time:
                max_time = time

        average = sum_time / len(matrix_times)

        # Write matrix multiplication benchmarking results using string concatenation
        file.write("Benchmarking benchmark_matmul function\n")
        file.write("Benchmark over: " + str(len(matrix_times)) + " iterations\n")
        file.write("Min time: " + str(min_time) + " ns\n")
        file.write("Max time: " + str(max_time) + " ns\n")
        file.write("Mean time: " + str(average) + " ns\n")

    return











    


