// Number of Islands
// Problem: Given an m x n 2D binary grid representing a map of '1's (land) and '0's (water),
// return the number of islands. An island is surrounded by water and is formed by connecting
// adjacent lands horizontally or vertically.
//
// Example:
//   Input: grid = [
//     ["1","1","1","1","0"],
//     ["1","1","0","1","0"],
//     ["1","1","0","0","0"],
//     ["0","0","0","0","0"]
//   ]
//   Output: 1
//
//   Input: grid = [
//     ["1","1","0","0","0"],
//     ["1","1","0","0","0"],
//     ["0","0","1","0","0"],
//     ["0","0","0","1","1"]
//   ]
//   Output: 3

// Solution: DFS approach to count the number of islands
//
// Time Complexity: O(m * n) - We visit each cell once in the worst case
// Space Complexity: O(m * n) - For the recursive call stack in worst case (entire grid is land)
int numIslands(List<List<String>> grid) {
  // Handle edge case
  if (grid.isEmpty || grid[0].isEmpty) return 0;

  int rows = grid.length;
  int cols = grid[0].length;
  int islandCount = 0;

  // Iterate through each cell in the grid
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      // If we find land, explore the entire island and increment counter
      if (grid[i][j] == "1") {
        islandCount++;
        dfs(grid, i, j);
      }
    }
  }

  return islandCount;
}

// DFS helper to explore all connected land cells (part of the same island)
// and mark them as visited by changing '1' to '0'
void dfs(List<List<String>> grid, int row, int col) {
  int rows = grid.length;
  int cols = grid[0].length;

  // Check boundary conditions and if current cell is land
  if (row < 0 ||
      col < 0 ||
      row >= rows ||
      col >= cols ||
      grid[row][col] == "0") {
    return;
  }

  // Mark current cell as visited
  grid[row][col] = "0";

  // Explore all 4 adjacent cells (up, right, down, left)
  dfs(grid, row - 1, col); // Up
  dfs(grid, row, col + 1); // Right
  dfs(grid, row + 1, col); // Down
  dfs(grid, row, col - 1); // Left
}

// Execution trace for example 1:
// - Initialize islandCount = 0
// - Start at (0,0): grid[0][0] = "1", increment islandCount to 1, call dfs(grid, 0, 0)
// - DFS from (0,0) will mark all connected "1"s as "0"
// - The DFS will explore all cells of the first island: (0,0), (0,1), (0,2), (0,3), (1,0), (1,1), (1,3), (2,0), (2,1)
// - When we continue the grid traversal, all cells of the first island are already marked as "0"
// - No more "1"s are found in the grid
// - Return islandCount = 1

// Execution trace for example 2:
// - Initialize islandCount = 0
// - Start at (0,0): grid[0][0] = "1", increment islandCount to 1, call dfs(grid, 0, 0)
// - DFS from (0,0) will mark the first island as "0": (0,0), (0,1), (1,0), (1,1)
// - Continue to (2,2): grid[2][2] = "1", increment islandCount to 2, call dfs(grid, 2, 2)
// - DFS from (2,2) will mark the second island as "0": (2,2)
// - Continue to (3,3): grid[3][3] = "1", increment islandCount to 3, call dfs(grid, 3, 3)
// - DFS from (3,3) will mark the third island as "0": (3,3), (3,4)
// - Return islandCount = 3

void main() {
  // Test cases
  var testCases = [
    // Test case 1: Single island
    [
      ["1", "1", "1", "1", "0"],
      ["1", "1", "0", "1", "0"],
      ["1", "1", "0", "0", "0"],
      ["0", "0", "0", "0", "0"],
    ],
    // Test case 2: Three islands
    [
      ["1", "1", "0", "0", "0"],
      ["1", "1", "0", "0", "0"],
      ["0", "0", "1", "0", "0"],
      ["0", "0", "0", "1", "1"],
    ],
    // Test case 3: No islands
    [
      ["0", "0", "0"],
      ["0", "0", "0"],
      ["0", "0", "0"],
    ],
    // Test case 4: Many small islands
    [
      ["1", "0", "1", "0", "1"],
      ["0", "1", "0", "1", "0"],
      ["1", "0", "1", "0", "1"],
      ["0", "1", "0", "1", "0"],
    ],
  ];

  // Expected outputs
  var expected = [1, 3, 0, 9];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    // Create a deep copy of the test case to avoid modifying the original
    var grid = testCases[i].map((row) => row.toList()).toList();

    int result = numIslands(grid);
    print('Test case ${i + 1}:');
    print('Input grid:');

    // Print the original grid for clarity
    for (var row in testCases[i]) {
      print(row);
    }

    print('Expected: ${expected[i]}');
    print('Result: $result');
    print(result == expected[i] ? 'PASS' : 'FAIL');
    print('---');
  }
}
