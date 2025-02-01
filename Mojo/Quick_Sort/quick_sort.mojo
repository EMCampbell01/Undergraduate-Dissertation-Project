import random

fn quick_sort(arr: List[Int]) -> List[Int]:
    
    if len(arr) <= 1:
        return arr
    
    # Dereference the pivot element
    pivot = arr[len(arr) // 2]
    
    left = List[Int]()
    middle = List[Int]()
    right = List[Int]()
    
    for x_ptr in arr:
        x = x_ptr[]
        if x < pivot:
            left.append(x)
        elif x == pivot:
            middle.append(x)
        else:
            right.append(x)
    
    return quick_sort(left) + middle + quick_sort(right)

def main():
    
    for i in range(10000):
        
        unsorted_list = List[Int]()
        for _ in range(1000):
            unsorted_list.append(int(random.random_si64(1, 1000)))
        
        sorted_data = quick_sort(unsorted_list)
    
    print("done")