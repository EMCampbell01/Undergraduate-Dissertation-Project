# UNDERGRADUATE DISSERTATION PROJECT

# "A Comparative Analysis of CPython & Mojo For Performance and Usability"

## Overview

This project presents a comparative analysis of CPython and Mojo for evaluating both performance and usability. Through various benchmark tests, its aim to assess the strengths and weaknesses of each language in different computational scenarios. The benchmarks involve tasks like matrix multiplication, sorting algorithms, and simulations, which are commonly used in performance-critical applications.

The project contains two main directories, one for Python and one for Mojo, each containing:

- Implementation directories for different algorithms being tested.
- Benchmarking scripts to automate performance measurement and comparison.

## Implementations Compared

### A*

The A* algorithm is a widely used pathfinding and graph traversal method that efficiently finds the shortest path between two points. For A* to function, it requires a graph structure with nodes, a defined start node, a goal node, and a heuristic function that estimates the cost from any node to the goal. Robotics relies on A* for motion planning, enabling autonomous drones and vehicles to calculate collision-free routes in real time. Transportation systems use it in GPS navigation tools to determine the shortest or fastest travel routes, balancing distance and traffic conditions. It also underpins network routing protocols, guiding data packets through the most efficient paths in communication systems. Developing A* implementations in CPython and Mojo will reveal critical insights into how language design impacts real-world algorithm performance and usability. 

### Matrix Multiplication

Matrix multiplication is a core operation in linear algebra, combining two matrices to produce a third matrix. Matrix multiplication plays a critical role in numerous areas of computer science, underpinning many advanced algorithms and systems. In machine learning, it is fundamental for training neural networks, performing dimensionality reduction, and solving optimization problems. Developing comparable matrix multiplication algorithms in CPython and Mojo provides specific benefits and insights that extend beyond the individual implementation. Matrix multiplication serves as a foundational operation, providing a clear and measurable basis for comparing execution speed, memory usage, and scalability between the two languages.

### Quick Sort

Quick Sort is a highly efficient, comparison-based sorting algorithm that employs a divide-and-conquer strategy to sort elements. The algorithm begins by selecting a "pivot" element from the array. Quick Sort is widely used in practice due to its efficiency and adaptability. It is a fundamental algorithm in computer science and is often implemented in standard libraries of programming languages. Quick Sort is used for indexing and query optimization, where fast sorting of large datasets is critical. Implementing Quick Sort in both CPython and Mojo offers a valuable opportunity to compare the performance and usability of the two languages in a computationally intensive task. Quick Sort's reliance on recursive partitioning and frequent element comparisons makes it an ideal benchmark for evaluating execution speed, memory usage, and scalability

### Conways Game of Life

Conway’s Game of Life is a cellular automaton devised by mathematician John Horton Conway in 1970. Conway’s Game of Life is a computationally light but visually complex simulation, requiring updates to a grid of cells based on simple rules. It tests a language’s ability to handle iterative, rule-based computations and graphical output.

## Results (PLACEHOLDER)

| Algorithm                     | Python Time | Mojo Time | Python Memory Usage | Mojo Memory Usage |
|-------------------------------|-------------|-----------|---------------------|-------------------|
| A*                            | 0           | 0         | 0                   | 0                 |
| Conway's Game of Life         | 0           | 0         | 0                   | 0                 |
| Matrix Multiplication         | 0           | 0         | 0                   | 0                 |
| Quick Sort                    | 0           | 0         | 0                   | 0                 |

## Conclusion (PLACEHOLDER)

This is placeholder text.