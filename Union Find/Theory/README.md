# Union Find / Disjoint Set Union (DSU) Algorithm Pattern

## Overview

Union Find (also known as Disjoint Set Union or DSU) is a data structure that keeps track of elements partitioned into a number of disjoint (non-overlapping) subsets. It provides near-constant-time operations for adding new sets, merging sets, and determining whether elements are in the same set.

## Core Operations

### 1. MakeSet(x)

- Creates a new set containing only element x
- Initially, each element is in its own set

### 2. Find(x)

- Returns the representative (or root) of the set containing element x
- Used to determine which set an element belongs to
- Two elements are in the same set if and only if they have the same representative

### 3. Union(x, y)

- Merges the sets containing elements x and y
- Usually implemented by making the representative of one set point to the representative of the other

## Implementation Techniques

### 1. Quick Find

- Each element directly stores its set's representative
- Fast `Find` operation (O(1))
- Slow `Union` operation (O(n))

### 2. Quick Union

- Each element stores a reference to its parent
- Creates a tree structure where the root is the set representative
- `Find` operation follows parent references until reaching the root (O(n) in worst case)
- `Union` operation is faster (O(n) in worst case, but much better in practice)

### 3. Path Compression

- Optimization for Quick Union
- After finding the root, update the parent of every traversed node to point directly to the root
- Dramatically improves performance of subsequent `Find` operations

### 4. Union by Rank/Size

- Optimization for Quick Union
- Attach the smaller tree under the root of the larger tree
- Prevents creating tall trees
- Can use either rank (approximate height) or size (number of nodes)

## Time Complexity

With both path compression and union by rank:

- **MakeSet**: O(1)
- **Find**: O(α(n)) amortized, where α is the inverse Ackermann function (effectively constant time)
- **Union**: O(α(n)) amortized (effectively constant time)

## Implementation in Dart

```dart
class DisjointSet {
  // Parent array to store the parent of each element
  List<int> parent;

  // Rank array to store the rank (approximate height) of each set
  List<int> rank;

  DisjointSet(int n) {
    // Initialize parent and rank arrays
    parent = List<int>.generate(n, (i) => i); // Each element is its own parent
    rank = List<int>.filled(n, 0); // Initial rank is 0
  }

  // Find the representative (root) of the set containing x
  // With path compression
  int find(int x) {
    if (parent[x] != x) {
      // Path compression: point x directly to the root
      parent[x] = find(parent[x]);
    }
    return parent[x];
  }

  // Union the sets containing x and y
  // Using union by rank
  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);

    // If x and y are already in the same set
    if (rootX == rootY) {
      return;
    }

    // Union by rank: attach the smaller tree under the root of the larger tree
    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
      parent[rootY] = rootX;
    } else {
      // If ranks are equal, make one as root and increment its rank
      parent[rootY] = rootX;
      rank[rootX]++;
    }
  }

  // Check if x and y are in the same set
  bool connected(int x, int y) {
    return find(x) == find(y);
  }
}
```

## Common Variations and Extensions

### 1. Weighted Quick-Union

Uses size instead of rank for union decisions.

### 2. Path Halving

Simplifies path compression by making each node point to its grandparent.

### 3. Path Splitting

Similar to path halving, but makes each node point to its grandparent on the find path.

### 4. Union-Find with component size

Tracks the size of each set for applications requiring this information.

## Applications

1. **Kruskal's Algorithm**: For finding minimum spanning tree of a graph
2. **Detecting Cycles**: In an undirected graph
3. **Network Connectivity**: Determining if two elements are connected
4. **Least Common Ancestor**: In trees
5. **Image Processing**: Connected components labeling
6. **Dynamic Graph Connectivity**
7. **Friend Circles/Social Networks**
8. **Grid Percolation**

## Example: Detecting Cycles in an Undirected Graph

```dart
bool hasCycle(List<List<int>> edges, int n) {
  DisjointSet ds = DisjointSet(n);

  for (List<int> edge in edges) {
    int u = edge[0];
    int v = edge[1];

    // If u and v are already in the same set, adding this edge forms a cycle
    if (ds.connected(u, v)) {
      return true;
    }

    // Union u and v
    ds.union(u, v);
  }

  return false;
}
```

## Example: Number of Connected Components

```dart
int countComponents(int n, List<List<int>> edges) {
  DisjointSet ds = DisjointSet(n);

  // Union each edge
  for (List<int> edge in edges) {
    ds.union(edge[0], edge[1]);
  }

  // Count the number of distinct roots
  int count = 0;
  for (int i = 0; i < n; i++) {
    if (ds.parent[i] == i) { // If i is its own parent, it's a root
      count++;
    }
  }

  return count;
}
```

## Advantages and Disadvantages

### Advantages

- Efficient for dynamic connectivity problems
- Near-constant time operations with optimizations
- Simple to implement and use
- Works well for offline problems

### Disadvantages

- Cannot efficiently handle deletions
- Not ideal for dense graphs (adjacency list/matrix may be better)
- Requires knowing the elements in advance

## Common Pitfalls

1. **Forgetting Path Compression**: This optimization is crucial for performance
2. **Improper Union Strategy**: Not using union by rank/size can lead to linear chains
3. **Off-by-one Errors**: Be careful with 0-indexed vs 1-indexed elements
4. **Not Finding the Root**: Calling union directly on elements rather than their roots

## Real-World Applications

- Network routing protocols
- Image segmentation algorithms
- Social network analysis
- Clustering algorithms
- Game development (for entity relationship management)
- Distributed systems (for failure detection)
