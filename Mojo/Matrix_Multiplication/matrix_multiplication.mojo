from matrix import Matrix

fn multiply_matrices(A: Matrix, B: Matrix) raises -> Matrix:

    if A.cols != B.rows:
        raise Error("Number of columns in A must equal the number of rows in B for matrix multiplication.")
    
    var C = Matrix.empty(A.rows, B.cols)
    
    for m in range(C.rows):
        for k in range(A.cols):
            for n in range(C.cols):
                C[m, n] += A[m, k] * B[k, n]

    return C


def main():

    for i in range(100):

        A = Matrix.random(1000, 1000)
        B = Matrix.random(1000, 1000)
        
        result = multiply_matrices(A, B)
        
