import numpy as np
import random


def generate_random_matrix(rows, cols):
    return [[random.randint(1, 10) for _ in range(cols)] for _ in range(rows)]

def numpy_matrix_multiply(matrix_a, matrix_b):
    
    np_matrix_a = np.array(matrix_a)
    np_matrix_b = np.array(matrix_b)
    
    return np.dot(np_matrix_a, np_matrix_b)


if __name__ == "__main__":
    
    for i in range(100):
        
        matrix_a = generate_random_matrix(1000, 1000)
        matrix_b = generate_random_matrix(1000, 1000)
        
        result = numpy_matrix_multiply(matrix_a, matrix_b)
