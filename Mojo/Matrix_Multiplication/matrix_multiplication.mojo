from .matrix import Matrix
import benchmark

fn matrix_multiply(A: Matrix, B: Matrix) raises -> Matrix:

    if A.cols != B.rows:
        raise Error("Number of columns in A must equal the number of rows in B for matrix multiplication.")
    
    var C = Matrix.empty(A.rows, B.cols)
    
    for m in range(C.rows):
        for k in range(A.cols):
            for n in range(C.cols):
                C[m, n] += A[m, k] * B[k, n]

    return C

fn benchmark_matrix_multiply() -> None:

    try:
        var A: Matrix = Matrix.random(100, 100)
        var B: Matrix = Matrix.random(100, 100)
        var result: Matrix = matrix_multiply(A, B)
    except:
        print("Error occurred while running the benchmark.")
        return

def generate_random_matrix(rows: Int, cols: Int) -> Matrix:

    matrix = Matrix.random(rows, cols)
    return matrix

fn main():

    try:
        var report = benchmark.run[benchmark_matrix_multiply]()
        report.print()
    except:
        print("Error occurred while running the benchmark.")
        return
        
