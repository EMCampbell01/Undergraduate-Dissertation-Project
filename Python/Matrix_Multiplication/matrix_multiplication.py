import random


def generate_random_matrix(rows, cols):
    return [[random.randint(1, 10) for _ in range(cols)] for _ in range(rows)]

def matrix_multiply(matrix_a, matrix_b):

    if len(matrix_a[0]) != len(matrix_b):
        raise ValueError("Number of columns in A must equal the number of rows in B for matrix multiplication.")
    
    result = [[0 for _ in range(len(matrix_b[0]))] for _ in range(len(matrix_a))]
    
    for i in range(len(matrix_a)):
        for j in range(len(matrix_b[0])):
            for k in range(len(matrix_b)):
                result[i][j] += matrix_a[i][k] * matrix_b[k][j]
    
    return result


if __name__ == "__main__":
    
    for i in range(10):

        matrix_a = generate_random_matrix(100, 100)
        matrix_b = generate_random_matrix(100, 100)
        
        result = matrix_multiply(matrix_a, matrix_b)

