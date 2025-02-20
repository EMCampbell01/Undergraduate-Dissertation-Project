from emberjson import parse
from collections import Dict, Set
from python import Python
from math import sqrt
import benchmark

struct ParseOptions:
    var ignore_unicode: Bool

@value
struct Edge(StringableRaising):

    var target: String
    var weight: Int

    def __str__(self) -> String:
        str_rep = "{target: " + self.target + ", weight: " + str(self.weight) + "}"
        return str_rep

@value
struct Node(StringableRaising):

    var name: String
    var x: Int
    var y: Int
    var edges: List[Edge]

    def __str__(self) -> String:

        str_rep = "{\n\tname: " + self.name + ",\n\tx: " + str(self.x) + ",\n\ty: " + str(self.y) + ",\n\tedges: {\n"

        for edge in self.edges:
            str_rep += "\t\t" + str(edge[])
            str_rep += ",\n "

        str_rep += "\t}\n}"

        return str_rep

    fn add_edge(mut self, edge: Edge) -> None:
        self.edges.append(edge)

@value 
struct Graph(StringableRaising):

    var nodes: Dict[String, Node]

    @staticmethod
    fn from_json(json_string: String) raises -> Graph:

        var graph: Graph = Graph(Dict[String, Node]())

        try:
            json_object = parse(json_string)

            nodes = json_object.object()["nodes"].array()
            edges = json_object.object()["edges"].array()

            for node in nodes:
                graph.add_node(str(node[].object()["id"].string()), int(node[].object()["x"].int()), int(node[].object()["y"].int()))

            for edge in edges:
                graph.add_edge(str(edge[].object()["source"].string()), str(edge[].object()["target"].string()), int(edge[].object()["weight"].int()))

        except:
            print("Error parsing JSON")

        return graph

    def __str__(self) -> String:

        str_rep = String()
        str_rep = "{"

        for node in self.nodes.values():
            str_rep += "\n" + str(node[]) +","

        str_rep += "\n}"

        return str_rep

    fn add_node(mut self, name: String, x: Int, y: Int) -> None:

        if name not in self.nodes:
            self.nodes[name] = Node(name, x, y, List[Edge]())

    fn add_edge(mut self, source: String, target: String, weight: Int) raises -> None:
        
        if source not in self.nodes or target not in self.nodes:
            raise Error("Both nodes {source} and {target} must exist before adding an edge.")

        self.nodes[source].add_edge(Edge(target, weight))

    fn get_neighbors(self, node_name: String) raises -> List[Tuple[String, Int]]:

        var neighbors = List[Tuple[String, Int]]()

        for edge in self.nodes[node_name].edges:
            neighbors.append((edge[].target, edge[].weight))

        return neighbors

    fn heuristic(self, node_name: String, target_id: String) raises -> Float64:

        var node = self.nodes[node_name]
        var target = self.nodes[target_id]

        var dist = sqrt((Float64(node.x) - Float64(target.x)) ** 2 + (Float64(node.y) - Float64(target.y)) ** 2)
        return dist

    fn compare_nodes(self, a: Tuple[Float64, String], b: Tuple[Float64, String]) -> Int:
        if a[0] < b[0]:
            return -1
        elif a[0] > b[0]:
            return 1
        else:
            return 0

    def get_path(self, start_node: String, end_node: String) -> List[String]:
        opened_nodes = List[Tuple[Float64, String]]()
        closed_nodes = Set[String]()

        g_costs = Dict[String, Float64]()
        f_costs = Dict[String, Float64]()
        parents = Dict[String, String]()

        g_costs[start_node] = 0
        h_cost = self.heuristic(start_node, end_node)
        f_costs[start_node] = h_cost

        opened_nodes.append((f_costs[start_node], start_node))

        def manual_sort():
            for i in range(len(opened_nodes)):
                min_idx = i
                for j in range(i+1, len(opened_nodes)):
                    if opened_nodes[j][0] < opened_nodes[min_idx][0]:
                        min_idx = j
                if min_idx != i:
                    opened_nodes[i], opened_nodes[min_idx] = opened_nodes[min_idx], opened_nodes[i]

        while len(opened_nodes) > 0:
            manual_sort()
            current_f_cost, current_node = opened_nodes.pop(0)

            if current_node == end_node:

                path = List[String]()
                step = end_node
                while step != start_node:
                    path.append(step)
                    step = parents[step]
                path.append(start_node)
                return path

            closed_nodes.add(current_node)

            for entry in self.get_neighbors(current_node):
                var neighbor = entry[][0]
                var weight = entry[][1]
                
                if neighbor in closed_nodes:
                    continue

                tentative_g_cost = g_costs[current_node] + weight

                if neighbor not in g_costs or tentative_g_cost < g_costs[neighbor]:
                    parents[neighbor] = current_node
                    g_costs[neighbor] = tentative_g_cost
                    h_cost = self.heuristic(neighbor, end_node)
                    f_costs[neighbor] = tentative_g_cost + h_cost

                    var found = False
                    for item in opened_nodes:
                        if neighbor == item[][1]:
                            found = True
                            break

                    if not found:
                        opened_nodes.append((f_costs[neighbor], neighbor))

        raise Error("Path not found")

fn benchmark_a_star() -> None:

    try:
        var json_string: String = ""

        with open("A_Star/graph.json", "r") as f:
            json_string = f.read()

        var graph: Graph = Graph.from_json(json_string)
        var path: List[String] = graph.get_path("A", "E")

    except:
        print("Error occurred while running the benchmark.")
        return

fn main():

    try:
        var report = benchmark.run[benchmark_a_star]()
        report.print()
    except:
        print("Error occurred while running the benchmark.")
        return
    

