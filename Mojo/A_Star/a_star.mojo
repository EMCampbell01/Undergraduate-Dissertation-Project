from python import Python
from collections import Dict

@value
struct Edge(StringableRaising):
    var target: String 
    var weight: Int

    def __str__(self) -> String:
        return "Edge(target=" + self.target + ", weight=" + str(self.weight) + ")"


@value
struct Node(StringableRaising):
    var name: String
    var x: Int
    var y: Int
    var edges: List[Edge]

    def __str__(self) -> String:
        # Start with node information
        var result = "Node(name=" + self.name + ", x=" + str(self.x) + ", y=" + str(self.y) + ", edges=["
        # Add string representations of edges
        for edge in self.edges:
            result += edge.__str__() + ", "
        # Remove trailing comma and space, then close the list
        if len(self.edges) > 0:
            result = result[:-2]
        result += "])"
        return result

    def add_edge(self, target: String, weight: Int):
        """Add an edge to this node."""
        self.edges.append(Edge(target=target, weight=weight))


@value
struct Graph(StringableRaising):
    var nodes: Dict[String, Node]

    fn __init__(out self, nodes: Dict[String, Node] = Dict[String, Node]()):
        self.nodes: Dict[String, Node] = nodes

    def __str__(self) -> String:
        print("*** Printing Graph ***")
        var result: String = "Graph(nodes=["

        # Safely check for "A" in the dictionary
        if "A" in self.nodes:
            print("Node A exists:", str(self.nodes["A"]))
        else:
            print("Node A does not exist.")

        # Loop through nodes in the dictionary
        for node in self.nodes.values():
            print("Looping through node:", str(node))
            result += node.__str__() + ", "

        if len(self.nodes) > 0:
            result = result[:-2]  # Remove trailing comma
        result += "])"
        return result

    def add_node(self, name: String, x: Int, y: Int):
        """Add a node to the graph."""
        if not self.nodes.__contains__(name):
            self.nodes[name] = Node(name=name, x=x, y=y, edges=List[Edge]())
            print("Added node:", str(self.nodes[name]))
        else:
            print("Node with name '" + name + "' already exists.")


def read_json():

    json = Python.import_module("json")

    with open("graph.json", "r") as f:
        json_data = f.read()
    
    data = json.loads(json_data)

    print(data)

# Main function
def main():
    
    # Create an edge instance
    edge1 = Edge(target="B", weight=5)
    edge2 = Edge(target="C", weight=10)

    # Print the edge instances
    print("Edge 1: " + str(edge1))
    print("Edge 2: " + str(edge2))

    edges = List[Edge](edge1, edge2)

    graph = Graph()
    graph.add_node("A", 0, 0)
    print("Graph:", str(graph))
