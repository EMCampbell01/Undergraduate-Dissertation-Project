from python import Python
import benchmark
import random

fn quick_sort(arr: List[Int]) -> List[Int]:
    
    if len(arr) <= 1:
        return arr
    
    var pivot = arr[len(arr) // 2]
    
    var left: List[Int] = List[Int]()
    var middle: List[Int] = List[Int]()
    var right: List[Int] = List[Int]()
    
    for x_ptr in arr:
        var x: Int = x_ptr[]
        if x < pivot:
            left.append(x)
        elif x == pivot:
            middle.append(x)
        else:
            right.append(x)
    
    return quick_sort(left) + middle + quick_sort(right)

def generate_unsorted_list_python(size: Int) -> List[Int]:
    random = Python.import_module("random")
    unsorted_list = List[Int]()
    for _ in range(1000):
        unsorted_list.append(random.randint(1, 1000))
    return unsorted_list

# Mojo's random implementation is very slow because it's a crytographic RNG.
fn generate_unsorted_list_mojo(size: Int) -> List[Int]:
    var unsorted_list: List[Int] = List[Int]()
    for _ in range(1000):
        unsorted_list.append(int(random.random_si64(1, 1000)))
    return unsorted_list

fn  quick_sort_benchmark():
    try:
        for i in range(10):
            var unsorted_list: List[Int] = generate_unsorted_list_mojo(1000)
            var sorted_data: List[Int] = quick_sort(unsorted_list)
    except:
        print("Error occurred while sorting the list.")
        return

fn main():
    
    try:
        var report = benchmark.run[quick_sort_benchmark]()
        report.print()
    except:
        print("Error occurred while running the benchmark.")
        return