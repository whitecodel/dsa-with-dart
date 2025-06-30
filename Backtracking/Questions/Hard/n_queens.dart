// Backtracking: N-Queens
//
// Problem: The n-queens puzzle is the problem of placing n queens on an n×n chessboard
// such that no two queens attack each other. Given an integer n, return all distinct
// solutions to the n-queens puzzle. Each solution contains a distinct board configuration
// of the n-queens placement, where 'Q' indicates a queen and '.' indicates an empty space.
//
// Example:
// Input: n = 4
// Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
// Explanation: There exist two distinct solutions to the 4-queens puzzle.
//
// This problem is a classic application of backtracking where we try different
// positions for queens and undo our decisions when they lead to conflicts.

// Function to solve the N-Queens problem
List<List<String>> solveNQueens(int n) {
  List<List<String>> result = [];

  // Initialize the chessboard with '.' in all positions
  List<List<String>> board = List.generate(n, (_) => List.filled(n, '.'));

  // Helper function to check if a position is safe for a queen
  bool isSafe(int row, int col) {
    // Check the column above
    for (int i = 0; i < row; i++) {
      if (board[i][col] == 'Q') return false;
    }

    // Check upper-left diagonal
    for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; i--, j--) {
      if (board[i][j] == 'Q') return false;
    }

    // Check upper-right diagonal
    for (int i = row - 1, j = col + 1; i >= 0 && j < n; i--, j++) {
      if (board[i][j] == 'Q') return false;
    }

    return true;
  }

  // Helper function to convert the board to the required format
  List<String> boardToStrings() {
    return board.map((row) => row.join('')).toList();
  }

  // Backtracking function
  void backtrack(int row) {
    // Base case: If we've placed queens in all rows, we have a solution
    if (row == n) {
      result.add(boardToStrings());
      return;
    }

    // Try placing a queen in each column of the current row
    for (int col = 0; col < n; col++) {
      // Check if it's safe to place a queen at this position
      if (isSafe(row, col)) {
        // Place the queen
        board[row][col] = 'Q';

        // Recursively try to place queens in subsequent rows
        backtrack(row + 1);

        // Backtrack - remove the queen to try other positions
        board[row][col] = '.';
      }
    }
  }

  // Start backtracking from the first row
  backtrack(0);

  return result;
}

// Alternative solution using sets to track conflicts
List<List<String>> solveNQueensOptimized(int n) {
  List<List<String>> result = [];
  List<String> board = List.filled(n, '');

  // Sets to keep track of occupied columns and diagonals
  Set<int> cols = {};
  Set<int> posDiags = {}; // row + col
  Set<int> negDiags = {}; // row - col

  void backtrack(int row) {
    if (row == n) {
      result.add(List<String>.from(board));
      return;
    }

    for (int col = 0; col < n; col++) {
      // Calculate diagonal indices
      int posDiag = row + col;
      int negDiag = row - col;

      // Skip if there's a conflict
      if (cols.contains(col) ||
          posDiags.contains(posDiag) ||
          negDiags.contains(negDiag)) {
        continue;
      }

      // Mark the position as occupied
      cols.add(col);
      posDiags.add(posDiag);
      negDiags.add(negDiag);

      // Place queen in the current position
      String rowString = '.'.padRight(col) + 'Q' + '.'.padRight(n - col - 1);
      board[row] = rowString;

      // Proceed to the next row
      backtrack(row + 1);

      // Backtrack
      cols.remove(col);
      posDiags.remove(posDiag);
      negDiags.remove(negDiag);
    }
  }

  backtrack(0);
  return result;
}

// Test function
void main() {
  // Test cases
  int n1 = 4;
  int n2 = 1;

  print('Input: n = $n1');
  print('Output: ${solveNQueens(n1)}');

  print('\nInput: n = $n2');
  print('Output: ${solveNQueens(n2)}');

  // Test optimized version
  print('\nOptimized solution:');
  print('Input: n = $n1');
  print('Output: ${solveNQueensOptimized(n1)}');

  // Detailed explanation for n = 4
  print('\nDetailed explanation for n = 4:');
  print('1. Start with empty 4x4 board');
  print('2. Begin backtracking from row 0:');
  print('   - Try (0,0): Place Q at (0,0)');
  print('   - Move to row 1');
  print('     * Try (1,0): Not safe (same column as queen at (0,0))');
  print('     * Try (1,1): Not safe (diagonal conflict with queen at (0,0))');
  print('     * Try (1,2): Safe, place Q at (1,2)');
  print('     * Move to row 2');
  print('       - Try positions in row 2: All lead to conflicts');
  print('       - Backtrack from row 2 to row 1');
  print('     * Remove Q from (1,2)');
  print('     * Try (1,3): Not safe (diagonal conflict)');
  print('     * Backtrack from row 1 to row 0');
  print('   - Remove Q from (0,0)');
  print('   - Try (0,1): Place Q at (0,1)');
  print('   - Move to row 1');
  print('     * Try (1,3): Safe, place Q at (1,3)');
  print('     * Move to row 2...');

  print('3. Continue this process, exploring all possibilities');
  print('4. Eventually find two valid solutions:');
  print('   - Solution 1: [[.Q..], [...Q], [Q...], [..Q.]]');
  print('   - Solution 2: [[..Q.], [Q...], [...Q], [.Q..]]');
}

/* Execution Trace (for solveNQueens(4)):
1. Initialize empty result and a 4x4 board filled with '.'
2. Call backtrack(0) to start the process

3. backtrack(0): Try to place a queen in row 0
   - Try col = 0:
     * isSafe(0, 0): returns true (first queen is always safe)
     * Place Q at (0, 0)
     * Call backtrack(1)
   
   - backtrack(1): Try to place a queen in row 1
     * Try col = 0:
       - isSafe(1, 0): returns false (same column as queen at (0,0))
     * Try col = 1:
       - isSafe(1, 1): returns false (diagonal conflict with queen at (0,0))
     * Try col = 2:
       - isSafe(1, 2): returns true
       - Place Q at (1, 2)
       - Call backtrack(2)
     
     - backtrack(2): Try to place a queen in row 2
       * All positions in row 2 lead to conflicts
       * No recursive calls to backtrack(3)
       * Return to backtrack(1)
     
     * Remove Q from (1, 2) (backtrack)
     * Try col = 3:
       - isSafe(1, 3): returns false (diagonal conflict)
     * Return to backtrack(0)
   
   - Remove Q from (0, 0) (backtrack)
   - Try col = 1:
     * isSafe(0, 1): returns true
     * Place Q at (0, 1)
     * Call backtrack(1)
   
   - Continue this process...
   - Eventually find the first solution with queens at positions (0,1), (1,3), (2,0), (3,2)
   - Add to result: [".Q..", "...Q", "Q...", "..Q."]
   - Continue backtracking and find second solution: ["..Q.", "Q...", "...Q", ".Q.."]

4. Return result = [[".Q..", "...Q", "Q...", "..Q."], ["..Q.", "Q...", "...Q", ".Q.."]]

Output:
Input: n = 4
Output: [[.Q.., ...Q, Q..., ..Q.], [..Q., Q..., ...Q, .Q..]]

Input: n = 1
Output: [[Q]]

Optimized solution:
Input: n = 4
Output: [[.Q.., ...Q, Q..., ..Q.], [..Q., Q..., ...Q, .Q..]]

Detailed explanation for n = 4:
1. Start with empty 4x4 board
2. Begin backtracking from row 0:
   - Try (0,0): Place Q at (0,0)
   - Move to row 1
     * Try (1,0): Not safe (same column as queen at (0,0))
     * Try (1,1): Not safe (diagonal conflict with queen at (0,0))
     * Try (1,2): Safe, place Q at (1,2)
     * Move to row 2
       - Try positions in row 2: All lead to conflicts
       - Backtrack from row 2 to row 1
     * Remove Q from (1,2)
     * Try (1,3): Not safe (diagonal conflict)
     * Backtrack from row 1 to row 0
   - Remove Q from (0,0)
   - Try (0,1): Place Q at (0,1)
   - Move to row 1
     * Try (1,3): Safe, place Q at (1,3)
     * Move to row 2...

3. Continue this process, exploring all possibilities
4. Eventually find two valid solutions:
   - Solution 1: [[.Q..], [...Q], [Q...], [..Q.]]
   - Solution 2: [[..Q.], [Q...], [...Q], [.Q..]]
*/
