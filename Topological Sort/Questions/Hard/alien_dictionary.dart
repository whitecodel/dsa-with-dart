// Alien Dictionary
// Problem: There is a new alien language which uses the latin alphabet. However, the order
// among letters is unknown. You receive a list of non-empty words from the dictionary, where
// words are sorted lexicographically by the rules of this new language. Derive the order of
// letters in this language.
//
// Notes:
// 1. You may assume all letters are in lowercase.
// 2. If the order is invalid, return an empty string.
// 3. There may be multiple valid order of letters, return any one of them.
//
// Example:
//   Input: words = ["wrt", "wrf", "er", "ett", "rftt"]
//   Output: "wertf"
//   Explanation: From "wrt" and "wrf", we know 't' comes before 'f'
//                From "wrt" and "er", we know 'w' comes before 'e'
//                From "er" and "ett", we know 'r' comes before 't'
//                From "ett" and "rftt", we know 'e' comes before 'r'
//                So the correct order is "wertf"
//
//   Input: words = ["z", "x"]
//   Output: "zx"
//
//   Input: words = ["z", "x", "z"]
//   Output: ""
//   Explanation: The order is invalid, since 'z' appears twice.

// Topological Sort solution to find the alien dictionary order
//
// Time Complexity: O(C) where C is the total length of all the words combined
// Space Complexity: O(1) since there are at most 26 characters in the alphabet
String alienOrder(List<String> words) {
  // If there are no words or just one word, we can't derive any order
  if (words.isEmpty) {
    return "";
  }

  // Map to store the graph (adjacency list)
  Map<String, Set<String>> graph = {};

  // Set of all unique characters in the words
  Set<String> chars = {};

  // Add all characters to the set and initialize graph
  for (String word in words) {
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      chars.add(char);
      graph.putIfAbsent(char, () => <String>{});
    }
  }

  // Build the graph
  for (int i = 0; i < words.length - 1; i++) {
    String word1 = words[i];
    String word2 = words[i + 1];

    // Check if word2 is a prefix of word1, which is invalid ordering
    if (word1.length > word2.length && word1.startsWith(word2)) {
      return "";
    }

    // Find the first different character and add an edge
    int minLength = min(word1.length, word2.length);
    for (int j = 0; j < minLength; j++) {
      if (word1[j] != word2[j]) {
        graph[word1[j]]!.add(word2[j]);
        break;
      }
    }
  }

  // Set to track visited nodes in DFS
  // 0: unvisited, 1: visiting (in current path), 2: visited
  Map<String, int> visited = {};
  chars.forEach((char) => visited[char] = 0);

  // Result string to store the topological order
  StringBuffer result = StringBuffer();

  // DFS function to detect cycles and build the topological sort
  bool hasCycle(String node) {
    // Already in the current path, cycle detected
    if (visited[node] == 1) {
      return true;
    }

    // Already processed, skip
    if (visited[node] == 2) {
      return false;
    }

    // Mark as currently visiting
    visited[node] = 1;

    // Visit neighbors
    for (String neighbor in graph[node]!) {
      if (hasCycle(neighbor)) {
        return true;
      }
    }

    // Mark as fully visited
    visited[node] = 2;

    // Add to result (prepend as we're building the reverse order)
    result.write(node);

    return false;
  }

  // Perform DFS on each character
  for (String char in chars) {
    if (visited[char] == 0) {
      if (hasCycle(char)) {
        return "";
      }
    }
  }

  // Reverse the result to get the correct topological order
  return result.toString().split('').reversed.join('');
}

// Helper function to get the minimum of two integers
int min(int a, int b) {
  return a < b ? a : b;
}

// Execution trace for ["wrt", "wrf", "er", "ett", "rftt"]:
//
// 1. Initialize graph:
//    - graph['w'] = {}
//    - graph['r'] = {}
//    - graph['t'] = {}
//    - graph['f'] = {}
//    - graph['e'] = {}
//
// 2. Build the graph:
//    - Compare "wrt" and "wrf":
//      - First diff at index 2: 't' vs 'f'
//      - Add edge t -> f: graph['t'] = {'f'}
//    - Compare "wrf" and "er":
//      - First diff at index 0: 'w' vs 'e'
//      - Add edge w -> e: graph['w'] = {'e'}
//    - Compare "er" and "ett":
//      - First diff at index 1: 'r' vs 't'
//      - Add edge r -> t: graph['r'] = {'t'}
//    - Compare "ett" and "rftt":
//      - First diff at index 0: 'e' vs 'r'
//      - Add edge e -> r: graph['e'] = {'r'}
//
// 3. Final graph:
//    - graph['w'] = {'e'}
//    - graph['r'] = {'t'}
//    - graph['t'] = {'f'}
//    - graph['f'] = {}
//    - graph['e'] = {'r'}
//
// 4. Topological sort:
//    - DFS('w'):
//      - Mark 'w' as visiting
//      - Visit 'e':
//        - Mark 'e' as visiting
//        - Visit 'r':
//          - Mark 'r' as visiting
//          - Visit 't':
//            - Mark 't' as visiting
//            - Visit 'f':
//              - Mark 'f' as visiting
//              - No neighbors
//              - Mark 'f' as visited
//              - Add 'f' to result: result = "f"
//            - Mark 't' as visited
//            - Add 't' to result: result = "ft"
//          - Mark 'r' as visited
//          - Add 'r' to result: result = "ftr"
//        - Mark 'e' as visited
//        - Add 'e' to result: result = "ftre"
//      - Mark 'w' as visited
//      - Add 'w' to result: result = "ftrew"
//
// 5. Reverse the result: "wertf"

void main() {
  // Test cases
  List<List<String>> testCases = [
    ["wrt", "wrf", "er", "ett", "rftt"],
    ["z", "x"],
    ["z", "x", "z"],
    ["za", "zb", "ca", "cb"],
    ["abc", "ab"], // Invalid order (prefix issue)
    ["abc", "abc"], // Same words
    ["z", "z"], // Same single character words
    ["abc", "def", "ghi"], // No common characters
    [], // Empty list
  ];

  // Expected outputs
  List<String> expected = [
    "wertf",
    "zx",
    "",
    "zxcab", // or "zcxab" or other valid ones
    "",
    "abc", // any order is fine since no constraints
    "z",
    "abcdefghi", // any order is fine since no constraints
    "",
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    var words = testCases[i];
    print('Test case ${i + 1}: $words');

    String result = alienOrder(words);
    print('Result: "$result"');
    print('Expected: "${expected[i]}"');

    // For cases with empty expected result, just check if result is empty
    if (expected[i].isEmpty) {
      print(result.isEmpty ? 'PASS' : 'FAIL');
    }
    // For cases with a unique valid order, check for exact match
    else if (i == 0 || i == 1 || i == 6) {
      print(result == expected[i] ? 'PASS' : 'FAIL');
    }
    // For cases with multiple valid orders, check if the result is valid
    else if (!expected[i].isEmpty) {
      print(isValidAlienOrder(words, result) ? 'PASS' : 'FAIL');
    }
    print('---');
  }
}

// Helper function to check if the derived order is valid for the given words
bool isValidAlienOrder(List<String> words, String order) {
  // If the derived order is empty but we have words, it's invalid
  if (order.isEmpty && words.isNotEmpty) {
    return false;
  }

  // Map each character to its position in the order
  Map<String, int> charPosition = {};
  for (int i = 0; i < order.length; i++) {
    charPosition[order[i]] = i;
  }

  // Check if every adjacent pair of words is in the correct order
  for (int i = 0; i < words.length - 1; i++) {
    String word1 = words[i];
    String word2 = words[i + 1];

    // Find the first different character
    int minLength = min(word1.length, word2.length);
    bool found = false;

    for (int j = 0; j < minLength; j++) {
      if (word1[j] != word2[j]) {
        // If word1's char is supposed to come after word2's char, order is invalid
        if (charPosition[word1[j]]! > charPosition[word2[j]]!) {
          return false;
        }
        found = true;
        break;
      }
    }

    // If no difference found and word1 is longer than word2, it's invalid
    if (!found && word1.length > word2.length) {
      return false;
    }
  }

  return true;
}
