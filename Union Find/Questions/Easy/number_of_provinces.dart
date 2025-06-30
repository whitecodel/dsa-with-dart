// Number of Provinces
// Problem: There are n cities. Some of them are connected, while some are not.
// If city a is connected directly with city b, and city b is connected directly with city c,
// then city a is connected indirectly with city c.
//
// A province is a group of directly or indirectly connected cities and no other cities outside of the group.
//
// You are given an n x n matrix isConnected where isConnected[i][j] = 1 if the ith city and the jth city
// are directly connected, and isConnected[i][j] = 0 otherwise.
//
// Return the total number of provinces.
//
// Example:
//   Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
//   Output: 2
//   Explanation: There are 3 cities. Cities 0 and 1 are connected, forming one province.
//                City 2 is by itself, forming another province. Hence, there are 2 provinces.
//
//   Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
//   Output: 3
//   Explanation: Each city is its own province as there are no connections.

// Union-Find (Disjoint Set) solution for finding the number of provinces
//
// Time Complexity: O(n²) where n is the number of cities
// Space Complexity: O(n) for the parent array
int findCircleNum(List<List<int>> isConnected) {
  int n = isConnected.length;

  // Initialize Union-Find data structure
  UnionFind uf = UnionFind(n);

  // Process all connections
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      // If cities i and j are connected, union them
      if (isConnected[i][j] == 1) {
        uf.union(i, j);
      }
    }
  }

  // Count number of distinct roots (provinces)
  return uf.count;
}

// Union-Find (Disjoint Set) data structure
class UnionFind {
  // Array to store parent of each node
  late List<int> parent;

  // Array to store rank (approximate height) of each set
  late List<int> rank;

  // Number of distinct sets (components)
  int count;

  // Constructor
  UnionFind(int n) : count = n {
    // Initialize parent array - each node is initially its own parent
    parent = List<int>.generate(n, (i) => i);

    // Initialize rank array - each set initially has height 0
    rank = List<int>.filled(n, 0);
  }

  // Find the root/representative of the set that x belongs to (with path compression)
  int find(int x) {
    if (x != parent[x]) {
      // Path compression - make x point directly to the root
      parent[x] = find(parent[x]);
    }
    return parent[x];
  }

  // Union two sets by rank
  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);

    // If already in the same set, do nothing
    if (rootX == rootY) {
      return;
    }

    // Union by rank - attach smaller rank tree under root of higher rank tree
    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
      parent[rootY] = rootX;
    } else {
      // If ranks are same, make one the parent and increment its rank
      parent[rootY] = rootX;
      rank[rootX]++;
    }

    // Decrease count since two sets are merged into one
    count--;
  }
}

// Execution trace for [[1,1,0],[1,1,0],[0,0,1]]:
//
// 1. Initialize UnionFind with n = 3:
//    - parent = [0, 1, 2]
//    - rank = [0, 0, 0]
//    - count = 3
//
// 2. Process connections:
//    - i=0, j=0: isConnected[0][0] = 1, self-connection (already in same set)
//    - i=0, j=1: isConnected[0][1] = 1, union(0, 1)
//      - rootX = find(0) = 0, rootY = find(1) = 1
//      - ranks are equal, make 1's parent = 0, increment rank of 0
//      - parent = [0, 0, 2], rank = [1, 0, 0], count = 2
//    - i=0, j=2: isConnected[0][2] = 0, no connection
//    - i=1, j=0: isConnected[1][0] = 1, union(1, 0)
//      - rootX = find(1) = 0, rootY = find(0) = 0 (already in same set)
//    - i=1, j=1: isConnected[1][1] = 1, self-connection
//    - i=1, j=2: isConnected[1][2] = 0, no connection
//    - i=2, j=0: isConnected[2][0] = 0, no connection
//    - i=2, j=1: isConnected[2][1] = 0, no connection
//    - i=2, j=2: isConnected[2][2] = 1, self-connection
//
// 3. Final state:
//    - parent = [0, 0, 2]
//    - Cities 0 and 1 form one province
//    - City 2 forms another province
//    - count = 2
//
// 4. Return count = 2

void main() {
  // Test cases
  List<List<List<int>>> testCases = [
    // Test case 1: 2 provinces (cities 0 and 1 are connected, city 2 is separate)
    [
      [1, 1, 0],
      [1, 1, 0],
      [0, 0, 1],
    ],

    // Test case 2: 3 provinces (all cities are separate)
    [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1],
    ],

    // Test case 3: 1 province (all cities are connected)
    [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
    ],

    // Test case 4: Larger example with 3 provinces
    [
      [1, 0, 0, 1, 0],
      [0, 1, 0, 0, 0],
      [0, 0, 1, 0, 0],
      [1, 0, 0, 1, 0],
      [0, 0, 0, 0, 1],
    ],

    // Test case 5: Single city
    [
      [1],
    ],

    // Test case 6: Complex connections (2 provinces)
    [
      [1, 1, 0, 0, 0],
      [1, 1, 1, 0, 0],
      [0, 1, 1, 0, 0],
      [0, 0, 0, 1, 1],
      [0, 0, 0, 1, 1],
    ],
  ];

  // Expected outputs
  List<int> expected = [2, 3, 1, 3, 1, 2];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    var isConnected = testCases[i];

    print('Test case ${i + 1}:');
    print('isConnected:');
    for (var row in isConnected) {
      print('  $row');
    }

    int result = findCircleNum(isConnected);
    print('Result: $result');
    print('Expected: ${expected[i]}');
    print(result == expected[i] ? 'PASS' : 'FAIL');
    print('---');
  }

  // Alternative solution using DFS
  print('Alternative solution using DFS:');
  for (int i = 0; i < testCases.length; i++) {
    var isConnected = testCases[i];
    int result = findCircleNumDFS(isConnected);
    print(
      'Test case ${i + 1}: Result: $result, Expected: ${expected[i]}, ${result == expected[i] ? "PASS" : "FAIL"}',
    );
  }
}

// Alternative DFS solution for finding number of provinces
//
// Time Complexity: O(n²) where n is the number of cities
// Space Complexity: O(n) for the visited array and recursion stack
int findCircleNumDFS(List<List<int>> isConnected) {
  int n = isConnected.length;
  List<bool> visited = List<bool>.filled(n, false);
  int count = 0;

  // DFS function to mark all cities in a province as visited
  void dfs(int city) {
    visited[city] = true;

    for (int j = 0; j < n; j++) {
      // If city j is connected to current city and not visited yet
      if (isConnected[city][j] == 1 && !visited[j]) {
        dfs(j);
      }
    }
  }

  // Start DFS from each unvisited city
  for (int i = 0; i < n; i++) {
    if (!visited[i]) {
      // Found a new province
      count++;
      dfs(i);
    }
  }

  return count;
}
