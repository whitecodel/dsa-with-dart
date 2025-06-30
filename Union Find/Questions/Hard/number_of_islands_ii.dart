// Union Find: Number of Islands II
//
// Problem: You are given an m x n 2D grid initialized with all zeros.
// We have a list of positions (r, c) where we want to incrementally operate on the grid.
// An operation is to change the cell at position (r, c) to a 1.
// After each operation, we need to return the number of islands in the grid.
// An island is a group of 1's connected horizontally or vertically.
//
// Example:
// Input: m = 3, n = 3, positions = [[0,0], [0,1], [1,2], [2,1]]
// Output: [1, 1, 2, 3]
// Explanation:
// - Initially, the grid is all 0's
// - After the first operation at [0,0], there is one island: [[1,0,0],[0,0,0],[0,0,0]]
// - After the second operation at [0,1], the island expands: [[1,1,0],[0,0,0],[0,0,0]]
// - After the third operation at [1,2], there are two islands: [[1,1,0],[0,0,1],[0,0,0]]
// - After the fourth operation at [2,1], there are three islands: [[1,1,0],[0,0,1],[0,1,0]]
//
// This is a classic Union-Find problem where we need to efficiently:
// 1. Add new land cells
// 2. Merge adjacent islands
// 3. Count the number of distinct islands

// Union-Find data structure
class UnionFind {
  List<int> parent;
  List<int> rank;
  int count;

  UnionFind(int size)
    : parent = List<int>.filled(size, -1),
      rank = List<int>.filled(size, 0),
      count = 0;

  // Find the parent of element x (with path compression)
  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]);
    }
    return parent[x];
  }

  // Union two elements x and y (with rank optimization)
  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);

    if (rootX != rootY) {
      // Union by rank to keep the tree flat
      if (rank[rootX] < rank[rootY]) {
        parent[rootX] = rootY;
      } else if (rank[rootX] > rank[rootY]) {
        parent[rootY] = rootX;
      } else {
        parent[rootY] = rootX;
        rank[rootX]++;
      }
      // When two islands merge, reduce the count by 1
      count--;
    }
  }

  // Add a new element with itself as parent
  void addElement(int x) {
    if (parent[x] == -1) {
      parent[x] = x;
      // When adding a new island, increment the count
      count++;
    }
  }
}

// Function to solve the Number of Islands II problem
List<int> numIslands2(int m, int n, List<List<int>> positions) {
  UnionFind uf = UnionFind(m * n);
  List<int> result = [];
  Set<int> visited = {}; // To track visited cells

  // Define the four possible directions (up, right, down, left)
  List<List<int>> directions = [
    [-1, 0],
    [0, 1],
    [1, 0],
    [0, -1],
  ];

  for (List<int> position in positions) {
    int row = position[0];
    int col = position[1];
    int index = row * n + col;

    // Check if this position was already visited
    if (visited.contains(index)) {
      result.add(uf.count);
      continue;
    }

    // Add this cell as a new island
    uf.addElement(index);
    visited.add(index);

    // Check all four adjacent cells
    for (List<int> dir in directions) {
      int newRow = row + dir[0];
      int newCol = col + dir[1];
      int newIndex = newRow * n + newCol;

      // Skip if out of bounds or not a land cell
      if (newRow < 0 ||
          newRow >= m ||
          newCol < 0 ||
          newCol >= n ||
          !visited.contains(newIndex)) {
        continue;
      }

      // Merge the current island with adjacent island
      uf.union(index, newIndex);
    }

    // Add the current count of islands to the result
    result.add(uf.count);
  }

  return result;
}

// Test function
void main() {
  // Test cases
  int m1 = 3;
  int n1 = 3;
  List<List<int>> positions1 = [
    [0, 0],
    [0, 1],
    [1, 2],
    [2, 1],
  ];

  int m2 = 2;
  int n2 = 2;
  List<List<int>> positions2 = [
    [0, 0],
    [1, 1],
    [0, 1],
  ];

  print('Input: m = $m1, n = $n1, positions = $positions1');
  print('Output: ${numIslands2(m1, n1, positions1)}');

  print('\nInput: m = $m2, n = $n2, positions = $positions2');
  print('Output: ${numIslands2(m2, n2, positions2)}');

  // Detailed explanation
  print(
    '\nDetailed explanation for m = 3, n = 3, positions = [[0,0], [0,1], [1,2], [2,1]]:',
  );

  print('\n1. Initially, the grid is all 0\'s and count = 0');

  print('\n2. Add land at (0,0):');
  print('   - Position index: 0*3 + 0 = 0');
  print('   - Add new element 0 to Union-Find');
  print('   - No neighbors to merge');
  print('   - Count = 1, Result = [1]');
  print('   - Grid: [[1,0,0],[0,0,0],[0,0,0]]');

  print('\n3. Add land at (0,1):');
  print('   - Position index: 0*3 + 1 = 1');
  print('   - Add new element 1 to Union-Find');
  print('   - Check neighbors: (0,0) is land, merge islands');
  print('   - Union(1, 0): both belong to the same island now');
  print('   - Count = 1, Result = [1, 1]');
  print('   - Grid: [[1,1,0],[0,0,0],[0,0,0]]');

  print('\n4. Add land at (1,2):');
  print('   - Position index: 1*3 + 2 = 5');
  print('   - Add new element 5 to Union-Find');
  print('   - No neighbors to merge');
  print('   - Count = 2, Result = [1, 1, 2]');
  print('   - Grid: [[1,1,0],[0,0,1],[0,0,0]]');

  print('\n5. Add land at (2,1):');
  print('   - Position index: 2*3 + 1 = 7');
  print('   - Add new element 7 to Union-Find');
  print('   - No neighbors to merge');
  print('   - Count = 3, Result = [1, 1, 2, 3]');
  print('   - Grid: [[1,1,0],[0,0,1],[0,1,0]]');
}

/* Execution Trace:
1. numIslands2(3, 3, [[0,0], [0,1], [1,2], [2,1]]) is called:
   - Initialize UnionFind with size 3*3 = 9
   - Initialize empty result list and visited set
   
   - Process position [0,0]:
     - Calculate index = 0*3 + 0 = 0
     - Add element 0 to Union-Find
     - Check adjacent cells:
       - (-1,0): Out of bounds, skip
       - (0,1): Not visited yet, skip
       - (1,0): Not visited yet, skip
       - (0,-1): Out of bounds, skip
     - Count = 1, add to result
   
   - Process position [0,1]:
     - Calculate index = 0*3 + 1 = 1
     - Add element 1 to Union-Find
     - Check adjacent cells:
       - (-1,1): Out of bounds, skip
       - (0,2): Not visited yet, skip
       - (1,1): Not visited yet, skip
       - (0,0): Visited, union(1, 0)
         - Find roots: root(1) = 1, root(0) = 0
         - Union by rank: parent[1] = 0, count--
     - Count = 1, add to result
   
   - Process position [1,2]:
     - Calculate index = 1*3 + 2 = 5
     - Add element 5 to Union-Find
     - Check adjacent cells:
       - (0,2): Not visited yet, skip
       - (1,3): Out of bounds, skip
       - (2,2): Not visited yet, skip
       - (1,1): Not visited yet, skip
     - Count = 2, add to result
   
   - Process position [2,1]:
     - Calculate index = 2*3 + 1 = 7
     - Add element 7 to Union-Find
     - Check adjacent cells:
       - (1,1): Not visited yet, skip
       - (2,2): Not visited yet, skip
       - (3,1): Out of bounds, skip
       - (2,0): Not visited yet, skip
     - Count = 3, add to result
   
   - Return result = [1, 1, 2, 3]

Output:
Input: m = 3, n = 3, positions = [[0, 0], [0, 1], [1, 2], [2, 1]]
Output: [1, 1, 2, 3]

Input: m = 2, n = 2, positions = [[0, 0], [1, 1], [0, 1]]
Output: [1, 2, 1]

Detailed explanation for m = 3, n = 3, positions = [[0,0], [0,1], [1,2], [2,1]]:

1. Initially, the grid is all 0's and count = 0

2. Add land at (0,0):
   - Position index: 0*3 + 0 = 0
   - Add new element 0 to Union-Find
   - No neighbors to merge
   - Count = 1, Result = [1]
   - Grid: [[1,0,0],[0,0,0],[0,0,0]]

3. Add land at (0,1):
   - Position index: 0*3 + 1 = 1
   - Add new element 1 to Union-Find
   - Check neighbors: (0,0) is land, merge islands
   - Union(1, 0): both belong to the same island now
   - Count = 1, Result = [1, 1]
   - Grid: [[1,1,0],[0,0,0],[0,0,0]]

4. Add land at (1,2):
   - Position index: 1*3 + 2 = 5
   - Add new element 5 to Union-Find
   - No neighbors to merge
   - Count = 2, Result = [1, 1, 2]
   - Grid: [[1,1,0],[0,0,1],[0,0,0]]

5. Add land at (2,1):
   - Position index: 2*3 + 1 = 7
   - Add new element 7 to Union-Find
   - No neighbors to merge
   - Count = 3, Result = [1, 1, 2, 3]
   - Grid: [[1,1,0],[0,0,1],[0,1,0]]
*/
