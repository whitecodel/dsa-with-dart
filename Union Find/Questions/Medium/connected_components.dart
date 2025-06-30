// Union Find: Number of Connected Components
//
// Problem: Find the number of connected components in an undirected graph.
//
// Example:
// Input: n = 5, edges = [[0,1], [1,2], [3,4]]
// Output: 2
// Explanation: There are two connected components: [0,1,2] and [3,4]
//
// This problem demonstrates the classic application of the Union-Find data structure.

// Union-Find class with path compression and union by rank
class UnionFind {
  List<int> parent;
  List<int> rank;
  int count; // Number of connected components

  // Initialize with n nodes (0 to n-1)
  UnionFind(int n)
    : parent = List<int>.generate(n, (i) => i),
      rank = List<int>.filled(n, 0),
      count = n;

  // Find the root of the set that element x belongs to
  // Uses path compression for efficiency
  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]); // Path compression
    }
    return parent[x];
  }

  // Union of two sets containing x and y
  // Uses union by rank for efficiency
  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);

    // If x and y are already in the same set
    if (rootX == rootY) return;

    // Union by rank: attach smaller rank tree under root of higher rank tree
    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
      parent[rootY] = rootX;
    } else {
      // If ranks are same, make one as root and increment its rank
      parent[rootY] = rootX;
      rank[rootX]++;
    }

    // Decrement count since we merged two components
    count--;
  }

  // Get the number of connected components
  int getCount() {
    return count;
  }
}

// Function to count the number of connected components
int countComponents(int n, List<List<int>> edges) {
  // Initialize Union-Find data structure
  UnionFind uf = UnionFind(n);

  // Process each edge and perform union
  for (List<int> edge in edges) {
    int u = edge[0];
    int v = edge[1];
    uf.union(u, v);
  }

  // Return the count of connected components
  return uf.getCount();
}

// Test function
void main() {
  // Test cases
  int n1 = 5;
  List<List<int>> edges1 = [
    [0, 1],
    [1, 2],
    [3, 4],
  ];

  int n2 = 5;
  List<List<int>> edges2 = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
  ];

  int n3 = 5;
  List<List<int>> edges3 = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
    [4, 0],
  ];

  print('Input: n = $n1, edges = $edges1');
  print('Output: ${countComponents(n1, edges1)}');

  print('\nInput: n = $n2, edges = $edges2');
  print('Output: ${countComponents(n2, edges2)}');

  print('\nInput: n = $n3, edges = $edges3');
  print('Output: ${countComponents(n3, edges3)}');

  // Detailed explanation
  print('\nDetailed explanation for n = 5, edges = [[0,1], [1,2], [3,4]]:');
  print('1. Initialize UnionFind with 5 nodes (0-4)');
  print(
    '   - parent = [0, 1, 2, 3, 4] (Each node is its own parent initially)',
  );
  print('   - rank = [0, 0, 0, 0, 0]');
  print('   - count = 5 (Each node is its own component)');

  print('\n2. Process edge [0,1]:');
  print('   - Union(0,1)');
  print('   - rootX = 0, rootY = 1');
  print('   - Ranks are equal, so make 1\'s root as 0 and increment rank of 0');
  print('   - parent = [0, 0, 2, 3, 4]');
  print('   - rank = [1, 0, 0, 0, 0]');
  print('   - count = 4');

  print('\n3. Process edge [1,2]:');
  print('   - Union(1,2)');
  print('   - rootX = find(1) = 0, rootY = 2');
  print('   - rank[0] > rank[2], so make 2\'s root as 0');
  print('   - parent = [0, 0, 0, 3, 4]');
  print('   - rank = [1, 0, 0, 0, 0]');
  print('   - count = 3');

  print('\n4. Process edge [3,4]:');
  print('   - Union(3,4)');
  print('   - rootX = 3, rootY = 4');
  print('   - Ranks are equal, so make 4\'s root as 3 and increment rank of 3');
  print('   - parent = [0, 0, 0, 3, 3]');
  print('   - rank = [1, 0, 0, 1, 0]');
  print('   - count = 2');

  print('\n5. Final count = 2 (Components: [0,1,2] and [3,4])');
}

/* Execution Trace:
1. countComponents(5, [[0,1], [1,2], [3,4]]) is called:
   - Initialize UnionFind with 5 nodes (0-4)
   - parent = [0, 1, 2, 3, 4] (Each node is its own parent initially)
   - rank = [0, 0, 0, 0, 0]
   - count = 5 (Each node is its own component)
   
   - Process edge [0,1]:
     - Union(0,1)
     - rootX = 0, rootY = 1
     - Ranks are equal, so make 1's root as 0 and increment rank of 0
     - parent = [0, 0, 2, 3, 4]
     - rank = [1, 0, 0, 0, 0]
     - count = 4
   
   - Process edge [1,2]:
     - Union(1,2)
     - rootX = find(1) = 0, rootY = 2
     - rank[0] > rank[2], so make 2's root as 0
     - parent = [0, 0, 0, 3, 4]
     - rank = [1, 0, 0, 0, 0]
     - count = 3
   
   - Process edge [3,4]:
     - Union(3,4)
     - rootX = 3, rootY = 4
     - Ranks are equal, so make 4's root as 3 and increment rank of 3
     - parent = [0, 0, 0, 3, 3]
     - rank = [1, 0, 0, 1, 0]
     - count = 2
   
   - Return count = 2

2. The two connected components are [0,1,2] and [3,4].

Output:
Input: n = 5, edges = [[0, 1], [1, 2], [3, 4]]
Output: 2

Input: n = 5, edges = [[0, 1], [1, 2], [2, 3], [3, 4]]
Output: 1

Input: n = 5, edges = [[0, 1], [1, 2], [2, 3], [3, 4], [4, 0]]
Output: 1

Detailed explanation for n = 5, edges = [[0,1], [1,2], [3,4]]:
1. Initialize UnionFind with 5 nodes (0-4)
   - parent = [0, 1, 2, 3, 4] (Each node is its own parent initially)
   - rank = [0, 0, 0, 0, 0]
   - count = 5 (Each node is its own component)

2. Process edge [0,1]:
   - Union(0,1)
   - rootX = 0, rootY = 1
   - Ranks are equal, so make 1's root as 0 and increment rank of 0
   - parent = [0, 0, 2, 3, 4]
   - rank = [1, 0, 0, 0, 0]
   - count = 4

3. Process edge [1,2]:
   - Union(1,2)
   - rootX = find(1) = 0, rootY = 2
   - rank[0] > rank[2], so make 2's root as 0
   - parent = [0, 0, 0, 3, 4]
   - rank = [1, 0, 0, 0, 0]
   - count = 3

4. Process edge [3,4]:
   - Union(3,4)
   - rootX = 3, rootY = 4
   - Ranks are equal, so make 4's root as 3 and increment rank of 3
   - parent = [0, 0, 0, 3, 3]
   - rank = [1, 0, 0, 1, 0]
   - count = 2

5. Final count = 2 (Components: [0,1,2] and [3,4])
*/
