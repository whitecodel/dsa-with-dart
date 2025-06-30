# DFS & BFS (Graph and Tree Traversal) Algorithm Pattern

## Overview

Depth-First Search (DFS) and Breadth-First Search (BFS) are fundamental algorithms for traversing or searching tree and graph data structures. Each has distinct properties that make them suitable for different types of problems.

## Depth-First Search (DFS)

### How It Works

1. Start at a source node (or root in a tree)
2. Explore as far as possible along each branch before backtracking
3. Use a stack (explicit or implicit via recursion) to keep track of nodes to visit

### Types of DFS Traversals (for Trees)

1. **Pre-order**: Process current node before children (Root → Left → Right)
2. **In-order**: Process current node between left and right children (Left → Root → Right)
3. **Post-order**: Process current node after children (Left → Right → Root)

### Implementation Approaches

1. **Recursive**: Uses the call stack implicitly
2. **Iterative**: Uses an explicit stack data structure

### Time & Space Complexity

- **Time Complexity**: O(V + E) where V is the number of vertices and E is the number of edges
- **Space Complexity**: O(h) where h is the height of the tree or the maximum depth of the recursion

## Breadth-First Search (BFS)

### How It Works

1. Start at a source node (or root in a tree)
2. Explore all neighbors at the present depth before moving to nodes at the next depth level
3. Use a queue to keep track of nodes to visit

### Implementation

- Always uses an explicit queue data structure
- Processes nodes level by level

### Time & Space Complexity

- **Time Complexity**: O(V + E) where V is the number of vertices and E is the number of edges
- **Space Complexity**: O(w) where w is the maximum width of the tree/graph

## Comparison: DFS vs BFS

| Aspect            | DFS                                    | BFS                                    |
| ----------------- | -------------------------------------- | -------------------------------------- |
| Data Structure    | Stack                                  | Queue                                  |
| Space Complexity  | O(h) - height                          | O(w) - width                           |
| Completeness      | Not complete for infinite-depth graphs | Complete - finds solution if it exists |
| Path Optimality   | Not optimal for unweighted graphs      | Optimal for unweighted graphs          |
| Use Case Examples | Topological sorting, cycle detection   | Shortest path, level-order traversal   |
| Implementation    | Simpler with recursion                 | Requires explicit queue                |

## When to Use Which?

### Use DFS When:

- Exploring all possible paths (e.g., maze solving)
- Finding nodes far from the root (deep in the tree/graph)
- Checking connectivity or cycle detection
- Topological sorting
- Memory is a constraint and the graph is very wide

### Use BFS When:

- Finding the shortest path (in unweighted graphs)
- Searching nodes near the source first
- Level-order traversal is required
- Testing if a path exists between two nodes
- The graph is very deep or potentially infinite

## Basic Implementation Templates in Dart

### DFS (Recursive)

```dart
void dfsRecursive(Graph graph, int node, Set<int> visited) {
  // Mark current node as visited
  visited.add(node);

  // Process current node
  print('Visited node: $node');

  // Visit all adjacent nodes
  for (int neighbor in graph.getNeighbors(node)) {
    if (!visited.contains(neighbor)) {
      dfsRecursive(graph, neighbor, visited);
    }
  }
}
```

### DFS (Iterative)

```dart
void dfsIterative(Graph graph, int startNode) {
  Set<int> visited = {};
  List<int> stack = [startNode]; // Using List as a stack

  while (stack.isNotEmpty) {
    int node = stack.removeLast(); // Pop from stack

    if (!visited.contains(node)) {
      // Mark as visited
      visited.add(node);

      // Process current node
      print('Visited node: $node');

      // Add all unvisited neighbors to the stack
      for (int neighbor in graph.getNeighbors(node)) {
        if (!visited.contains(neighbor)) {
          stack.add(neighbor);
        }
      }
    }
  }
}
```

### BFS

```dart
void bfs(Graph graph, int startNode) {
  Set<int> visited = {};
  List<int> queue = [startNode]; // Using List as a queue
  visited.add(startNode);

  while (queue.isNotEmpty) {
    int node = queue.removeAt(0); // Dequeue

    // Process current node
    print('Visited node: $node');

    // Add all unvisited neighbors to the queue
    for (int neighbor in graph.getNeighbors(node)) {
      if (!visited.contains(neighbor)) {
        visited.add(neighbor);
        queue.add(neighbor);
      }
    }
  }
}
```

## Common Applications

### DFS Applications

1. **Topological Sorting**: Ordering vertices in a directed graph
2. **Cycle Detection**: Finding cycles in a graph
3. **Path Finding**: Finding any path between two nodes
4. **Connected Components**: Finding strongly connected components
5. **Maze Generation and Solving**: Creating and solving mazes
6. **Game Tree Exploration**: Decision making in games like chess

### BFS Applications

1. **Shortest Path (Unweighted)**: Finding the shortest path in unweighted graphs
2. **Level Order Traversal**: Processing nodes level by level
3. **Finding Connected Components**: In undirected graphs
4. **Testing Bipartiteness**: Checking if a graph is bipartite
5. **Finding All Nodes at Distance K**: Finding nodes at a specific distance
6. **Web Crawling**: Exploring web pages breadth-first

## Common Variations and Extensions

1. **Bidirectional Search**: Running BFS from both source and destination
2. **Iterative Deepening DFS (IDDFS)**: Combines advantages of DFS and BFS
3. **Multi-Source BFS**: Starting BFS from multiple source nodes
4. **Dijkstra's Algorithm**: Extension of BFS for weighted graphs
5. **A\* Search**: Extension of BFS using heuristics for more efficient path finding

## Common Pitfalls

1. **Forgetting to mark nodes as visited**: Causes infinite loops
2. **Incorrect neighbor generation**: Missing or incorrect edges
3. **Not handling disconnected components**: Missing parts of the graph
4. **Stack overflow in recursive DFS**: For very deep graphs
5. **Not checking for cycles in directed graphs**: Can lead to infinite recursion

## Real-World Applications

- Network analysis and packet routing
- Web crawling and search engines
- Social network analysis
- Circuit design verification
- AI and machine learning algorithms
- Recommendation systems
- Computer vision algorithms
