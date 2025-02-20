from matrix import Matrix
import benchmark

fn matmul(A: Matrix, B: Matrix) raises -> Matrix:

    if A.cols != B.rows:
        raise Error("Number of columns in A must equal the number of rows in B for matrix multiplication.")
    
    var C = Matrix.empty(A.rows, B.cols)
    
    for m in range(C.rows):
        for k in range(A.cols):
            for n in range(C.cols):
                C[m, n] += A[m, k] * B[k, n]

    return C

fn benchmark_matmul() -> None:

    try:
        var A: Matrix = Matrix.random(100, 100)
        var B: Matrix = Matrix.random(100, 100)
        var result: Matrix = matmul(A, B)
    except:
        print("Error occurred while running the benchmark.")
        return

fn main():

    try:
        var report = benchmark.run[benchmark_matmul]()
        report.print()
    except:
        print("Error occurred while running the benchmark.")
        return
        
