import random

def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    return quick_sort(left) + middle + quick_sort(right)


if __name__ == "__main__":

    for i in range(10):
        
        unsorted_list = [random.randint(1, 1000) for _ in range(1000)]
        sorted_data = quick_sort(unsorted_list)
        
    print("done")