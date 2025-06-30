// Trie: Word Search II
//
// Problem: Given an m x n board of characters and a list of strings words,
// return all words on the board that can be constructed from letters of
// sequentially adjacent cells. Each word must be constructed from letters of
// sequentially adjacent cells, where adjacent cells are horizontally or
// vertically neighboring. The same letter cell may not be used more than once
// in a word.
//
// Example:
// Input: board = [
//   ["o","a","a","n"],
//   ["e","t","a","e"],
//   ["i","h","k","r"],
//   ["i","f","l","v"]
// ],
// words = ["oath","pea","eat","rain"]
// Output: ["eat","oath"]
//
// This problem combines the Trie data structure with DFS backtracking to
// efficiently search for multiple words in the board.

// TrieNode for the Trie data structure
class TrieNode {
  // Map to store child nodes
  Map<String, TrieNode> children = {};

  // Flag to mark the end of a word
  String? word;
}

// Solution using Trie and DFS backtracking
List<String> findWords(List<List<String>> board, List<String> words) {
  // Build Trie from the list of words
  TrieNode root = buildTrie(words);

  List<String> result = [];
  int m = board.length;
  int n = board[0].length;

  // DFS search starting from each cell on the board
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      dfs(board, i, j, root, result);
    }
  }

  return result;
}

// Helper function to build a Trie from the list of words
TrieNode buildTrie(List<String> words) {
  TrieNode root = TrieNode();

  for (String word in words) {
    TrieNode node = root;

    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      node.children.putIfAbsent(char, () => TrieNode());
      node = node.children[char]!;
    }

    // Mark the end of the word
    node.word = word;
  }

  return root;
}

// DFS search with backtracking
void dfs(
  List<List<String>> board,
  int i,
  int j,
  TrieNode node,
  List<String> result,
) {
  // Check if we're out of bounds or the cell is visited or doesn't match
  if (i < 0 ||
      i >= board.length ||
      j < 0 ||
      j >= board[0].length ||
      board[i][j] == '#' ||
      !node.children.containsKey(board[i][j])) {
    return;
  }

  // Get the current character and move to the next node
  String char = board[i][j];
  TrieNode nextNode = node.children[char]!;

  // If we've found a complete word, add it to the result
  if (nextNode.word != null) {
    result.add(nextNode.word!);
    // Remove the word to avoid duplicates
    nextNode.word = null;
  }

  // Mark the current cell as visited
  board[i][j] = '#';

  // Try all four directions
  dfs(board, i + 1, j, nextNode, result); // down
  dfs(board, i - 1, j, nextNode, result); // up
  dfs(board, i, j + 1, nextNode, result); // right
  dfs(board, i, j - 1, nextNode, result); // left

  // Restore the cell (backtrack)
  board[i][j] = char;

  // Optimization: prune the trie if this node has no children and doesn't end a word
  if (nextNode.children.isEmpty && nextNode.word == null) {
    node.children.remove(char);
  }
}

// Test function
void main() {
  // Test cases
  List<List<String>> board1 = [
    ["o", "a", "a", "n"],
    ["e", "t", "a", "e"],
    ["i", "h", "k", "r"],
    ["i", "f", "l", "v"],
  ];
  List<String> words1 = ["oath", "pea", "eat", "rain"];

  List<List<String>> board2 = [
    ["a", "b"],
    ["c", "d"],
  ];
  List<String> words2 = ["abcb"];

  print('Input: board = $board1, words = $words1');
  print('Output: ${findWords(board1, words1)}');

  print('\nInput: board = $board2, words = $words2');
  print('Output: ${findWords(board2, words2)}');

  // Detailed explanation
  print('\nDetailed explanation for first example:');
  print('1. Build a Trie from ["oath", "pea", "eat", "rain"]');
  print('2. Start DFS from each cell on the board:');
  print('   - Start at (0,0) = "o":');
  print('     * "o" is in the Trie, continue DFS');
  print('     * Try (1,0) = "e", not part of "oath", backtrack');
  print('     * Try (0,1) = "a", matches next char in "oath", continue');
  print('     * Try adjacent cells, eventually find "oath" through path:');
  print('       (0,0) -> (0,1) -> (1,1) -> (2,1)');
  print('     * Add "oath" to result');

  print('   - Start at (1,0) = "e":');
  print('     * "e" is in the Trie, continue DFS');
  print('     * Try (1,1) = "t", not part of "eat", backtrack');
  print('     * Try (2,0) = "i", not part of "eat", backtrack');
  print('     * Try (0,0) = "o", not part of "eat", backtrack');
  print('     * Try (1,1) = "a", matches next char in "eat", continue');
  print('     * Try adjacent cells, eventually find "eat" through path:');
  print('       (1,0) -> (1,1) -> (0,1)');
  print('     * Add "eat" to result');

  print('3. "pea" and "rain" are not found on the board');
  print('4. Final result: ["oath", "eat"]');
}

/* Execution Trace:
1. findWords(board1, ["oath", "pea", "eat", "rain"]) is called:
   - First, build a Trie from the words:
     * Insert "oath": Create nodes for 'o', 'a', 't', 'h', and mark 'h' as end of "oath"
     * Insert "pea": Create nodes for 'p', 'e', 'a', and mark 'a' as end of "pea"
     * Insert "eat": Create nodes for 'e', 'a', 't', and mark 't' as end of "eat"
     * Insert "rain": Create nodes for 'r', 'a', 'i', 'n', and mark 'n' as end of "rain"
   
   - Start DFS from each cell on the board:
     * For (0,0) = 'o':
       - 'o' is in the Trie, continue DFS
       - Try all four directions
       - When exploring path (0,0) -> (0,1) -> (1,1) -> (2,1): "oath" is found
       - Add "oath" to result
     
     * For (1,0) = 'e':
       - 'e' is in the Trie, continue DFS
       - Try all four directions
       - When exploring path (1,0) -> (1,1) -> (0,1): "eat" is found
       - Add "eat" to result
     
     * DFS from other cells doesn't lead to finding more words
   
   - Return result = ["oath", "eat"]

2. The words "pea" and "rain" are not found because:
   - "pea": the board doesn't have a 'p' character to start with
   - "rain": while the board has 'r', 'a', 'i', 'n' characters, they are not in a connected path

Output:
Input: board = [[o, a, a, n], [e, t, a, e], [i, h, k, r], [i, f, l, v]], words = [oath, pea, eat, rain]
Output: [oath, eat]

Input: board = [[a, b], [c, d]], words = [abcb]
Output: []

Detailed explanation for first example:
1. Build a Trie from ["oath", "pea", "eat", "rain"]
2. Start DFS from each cell on the board:
   - Start at (0,0) = "o":
     * "o" is in the Trie, continue DFS
     * Try (1,0) = "e", not part of "oath", backtrack
     * Try (0,1) = "a", matches next char in "oath", continue
     * Try adjacent cells, eventually find "oath" through path:
       (0,0) -> (0,1) -> (1,1) -> (2,1)
     * Add "oath" to result

   - Start at (1,0) = "e":
     * "e" is in the Trie, continue DFS
     * Try (1,1) = "t", not part of "eat", backtrack
     * Try (2,0) = "i", not part of "eat", backtrack
     * Try (0,0) = "o", not part of "eat", backtrack
     * Try (1,1) = "a", matches next char in "eat", continue
     * Try adjacent cells, eventually find "eat" through path:
       (1,0) -> (1,1) -> (0,1)
     * Add "eat" to result

3. "pea" and "rain" are not found on the board
4. Final result: ["oath", "eat"]
*/
