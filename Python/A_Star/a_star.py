from dataclasses import dataclass, field
from typing import List, Dict, Tuple, Optional
import math
import json


@dataclass
class Edge:
    target: str
    weight: Optional[float] = 1.0


@dataclass
class Node:
    name: str
    x: float
    y: float
    edges: List[Edge] = field(default_factory=list)


class Graph:
    
    def __init__(self):
        self.nodes: Dict[str, Node] = {}
        
    @classmethod
    def from_json(cls, json_data: str) -> "Graph":
        """Create a Graph instance from JSON data."""
        data = json.loads(json_data)
        graph = cls()

        # Add nodes
        for node in data["nodes"]:
            graph.add_node(node["id"], node["x"], node["y"])

        # Add edges
        for edge in data["edges"]:
            graph.add_edge(edge["source"], edge["target"], edge["weight"])

        return graph

    def add_node(self, id: str, x: float, y: float):
        """Add a node with an (x, y) position."""
        if id not in self.nodes:
            self.nodes[id] = Node(id, x, y)

    def add_edge(self, source: str, target: str, weight: Optional[float] = 1.0):
        """Add an edge between two nodes."""
        if source not in self.nodes or target not in self.nodes:
            raise ValueError(f"Both nodes {source} and {target} must exist before adding an edge.")
        self.nodes[source].edges.append(Edge(target, weight))

    def get_neighbors(self, node_id: str) -> List[Tuple[str, float]]:
        """Return neighbors as (target, weight)."""
        return [(edge.target, edge.weight) for edge in self.nodes.get(node_id, Node(node_id, 0, 0)).edges]

    def heuristic(self, node_id: str, target_id: str) -> float:
        """Calculate the Euclidean distance between two nodes."""
        node = self.nodes[node_id]
        target = self.nodes[target_id]
        return math.sqrt((node.x - target.x) ** 2 + (node.y - target.y) ** 2)

    def get_path(self, source: str, target: str) -> Tuple[List[str], float]:
        """Find the shortest path using A*."""
        import heapq

        if source not in self.nodes or target not in self.nodes:
            return [], float('inf')

        open_set = []
        heapq.heappush(open_set, (0, source))  # Priority queue with (f_score, node)

        came_from = {}
        g_score = {node: float('inf') for node in self.nodes}
        g_score[source] = 0
        f_score = {node: float('inf') for node in self.nodes}
        f_score[source] = self.heuristic(source, target)

        while open_set:
            _, current = heapq.heappop(open_set)

            if current == target:
                # Reconstruct the path
                path = []
                while current in came_from:
                    path.append(current)
                    current = came_from[current]
                path.append(source)
                return path[::-1], g_score[target]

            for neighbor, weight in self.get_neighbors(current):
                tentative_g_score = g_score[current] + weight
                if tentative_g_score < g_score[neighbor]:
                    came_from[neighbor] = current
                    g_score[neighbor] = tentative_g_score
                    f_score[neighbor] = tentative_g_score + self.heuristic(neighbor, target)
                    if neighbor not in [n[1] for n in open_set]:
                        heapq.heappush(open_set, (f_score[neighbor], neighbor))

        return [], float('inf')  # No path found

    def __repr__(self):
        return "\n".join(
            f"{node.name} ({node.x}, {node.y}): {[f'{edge.target} (weight: {edge.weight})' for edge in node.edges]}"
            for node in self.nodes.values()
        )

def main():
    # Load JSON from file
    with open("graph.json", "r") as f:
        json_data = f.read()

    # Create a graph instance from JSON
    graph = Graph.from_json(json_data)

    # Print the graph
    print("Graph:")
    print(graph)
    print("Path:")
    print(graph.get_path("A", "E"))


if __name__ == "__main__":
    main()
