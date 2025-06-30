# Topological Sort

## Overview

Topological Sort is an algorithm for ordering the vertices in a directed acyclic graph (DAG) such that for every directed edge (u, v), vertex u comes before vertex v in the ordering. In other words, it's a linear ordering of vertices that respects the direction of edges.

Topological sorting is often used to schedule tasks with dependencies, course prerequisites, build systems, and other scenarios where certain operations must occur before others.

## Key Concepts

### Directed Acyclic Graph (DAG)

A topological sort is only possible if the graph:

1. Is directed (edges have a direction)
2. Contains no cycles (no path leads back to a vertex already visited)

If a cycle exists, no valid topological ordering is possible since there would be a circular dependency.

### Algorithms for Topological Sort

#### 1. Kahn's Algorithm (BFS-based)

1. Calculate the in-degree (number of incoming edges) for each vertex
2. Add all vertices with in-degree 0 to a queue
3. Process each vertex in the queue:
   - Add to result
   - Decrement in-degree of all adjacent vertices
   - Add vertices whose in-degree becomes 0 to the queue
4. If not all vertices are processed, the graph has a cycle

#### 2. Depth-First Search (DFS) Algorithm

1. Perform DFS traversal of the graph
2. For each vertex, after visiting all its adjacent vertices (i.e., during backtracking), add it to the front of the result list
3. Reverse the result list to get the topological order

### Implementation in Dart

Here's an implementation of Kahn's Algorithm:

```dart
List<int> topologicalSort(List<List<int>> graph) {
  int n = graph.length;

  // Calculate in-degrees for all vertices
  List<int> inDegree = List.filled(n, 0);
  for (int u = 0; u < n; u++) {
    for (int v in graph[u]) {
      inDegree[v]++;
    }
  }

  // Initialize queue with all vertices having in-degree 0
  List<int> queue = [];
  for (int i = 0; i < n; i++) {
    if (inDegree[i] == 0) {
      queue.add(i);
    }
  }

  List<int> result = [];

  while (queue.isNotEmpty) {
    int u = queue.removeAt(0);
    result.add(u);

    // Reduce in-degree of adjacent vertices
    for (int v in graph[u]) {
      inDegree[v]--;
      // If in-degree becomes 0, add to queue
      if (inDegree[v] == 0) {
        queue.add(v);
      }
    }
  }

  // If all vertices are not included, graph has a cycle
  if (result.length != n) {
    throw Exception("Graph contains a cycle");
  }

  return result;
}
```

And here is the DFS-based implementation:

```dart
List<int> topologicalSortDFS(List<List<int>> graph) {
  int n = graph.length;
  List<bool> visited = List.filled(n, false);
  List<bool> temp = List.filled(n, false); // For cycle detection
  List<int> result = [];

  for (int i = 0; i < n; i++) {
    if (!visited[i]) {
      if (_dfsTopologicalSort(graph, i, visited, temp, result)) {
        throw Exception("Graph contains a cycle");
      }
    }
  }

  // Reverse the result to get topological order
  return result.reversed.toList();
}

bool _dfsTopologicalSort(
    List<List<int>> graph,
    int vertex,
    List<bool> visited,
    List<bool> temp,
    List<int> result) {

  // If vertex is being processed in current DFS, we found a cycle
  if (temp[vertex]) return true;

  // If vertex is already processed, skip
  if (visited[vertex]) return false;

  // Mark vertex as being processed
  temp[vertex] = true;

  // Process all adjacent vertices
  for (int neighbor in graph[vertex]) {
    if (_dfsTopologicalSort(graph, neighbor, visited, temp, result)) {
      return true; // Found a cycle
    }
  }

  // Mark vertex as processed
  temp[vertex] = false;
  visited[vertex] = true;

  // Add to result during backtracking
  result.add(vertex);

  return false; // No cycle found
}
```

## Applications

1. **Task Scheduling**: Determining the order to execute dependent tasks
2. **Course Prerequisites**: Finding a valid sequence of courses to take
3. **Build Systems**: Determining compilation order in build systems like Make
4. **Package Dependency Resolution**: Managing software package installations
5. **Static Analysis**: In compiler design for instruction scheduling
6. **Circuit Design**: For evaluating components in an electronic circuit

## Common Patterns and Variations

### 1. Detecting Cycles

A topological sort will fail if the graph has cycles. This property can be used to detect cycles in a directed graph.

### 2. Multiple Valid Orderings

A DAG can have multiple valid topological orderings. The specific order produced depends on the algorithm implementation and tie-breaking decisions.

### 3. Lexicographically Smallest Topological Sort

When multiple valid topological orderings exist, finding the lexicographically smallest one (favoring lower-numbered vertices first) is a common variation.

### 4. Partial Ordering

Topological sort represents one of many possible total orderings that satisfy the graph's partial ordering constraints.

## Time and Space Complexity

### Kahn's Algorithm:

- **Time Complexity**: O(V + E) where V is the number of vertices and E is the number of edges
- **Space Complexity**: O(V) for the queue, in-degree array, and result

### DFS-based Algorithm:

- **Time Complexity**: O(V + E)
- **Space Complexity**: O(V) for recursion stack, visited arrays, and result

## Common Pitfalls

1. **Applying to non-DAGs**: Topological sort only works on directed acyclic graphs
2. **Incorrect edge representation**: Ensure the graph's edges point in the right direction
3. **Missing cycle detection**: Always check if a valid topological ordering was found
4. **Inefficient graph representation**: Choose appropriate data structures for your specific problem

## When to Use

Consider using topological sort when:

1. You need to sequence tasks with dependencies
2. You're solving problems involving precedence constraints
3. You need to determine a linear ordering from a partial order
4. You're checking whether a set of dependencies can be satisfied
5. You need to detect cycles in a directed graph

## Dart-Specific Notes

- Dart doesn't have built-in graph data structures, so you'll typically represent graphs using lists of lists or maps
- For larger graphs, consider using specialized graph libraries or implementing more efficient data structures
- Be mindful of Dart's lack of explicit tail call optimization when using recursive DFS implementations
