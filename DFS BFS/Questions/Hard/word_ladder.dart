// DFS/BFS: Word Ladder
//
// Problem: Given two words (beginWord and endWord), and a dictionary's word list,
// find the length of shortest transformation sequence from beginWord to endWord, such that:
// 1. Only one letter can be changed at a time.
// 2. Each transformed word must exist in the word list.
//
// Example:
// Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
// Output: 5
// Explanation: The shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
// with a length of 5.
//
// Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
// Output: 0
// Explanation: The endWord "cog" is not in wordList, so no transformation is possible.
//
// This problem demonstrates an application of BFS to find the shortest path in a graph.

// Function to find the length of the shortest transformation sequence
int ladderLength(String beginWord, String endWord, List<String> wordList) {
  // Convert wordList to a Set for O(1) lookups
  Set<String> wordSet = Set<String>.from(wordList);

  // If endWord is not in wordSet, return 0
  if (!wordSet.contains(endWord)) {
    return 0;
  }

  // Queue for BFS
  List<String> queue = [beginWord];
  // Set to track visited words
  Set<String> visited = {beginWord};

  // Start with level 1 (the beginWord)
  int level = 1;

  // BFS traversal
  while (queue.isNotEmpty) {
    int size = queue.length;

    // Process all nodes at the current level
    for (int i = 0; i < size; i++) {
      String currentWord = queue.removeAt(0);

      // If we reach the endWord, return the level
      if (currentWord == endWord) {
        return level;
      }

      // Try changing each character of the word
      for (int j = 0; j < currentWord.length; j++) {
        // Try all possible characters
        for (int k = 0; k < 26; k++) {
          // Generate a new word with one character changed
          String newWord =
              currentWord.substring(0, j) +
              String.fromCharCode(97 + k) +
              currentWord.substring(j + 1);

          // If the new word is in wordSet and hasn't been visited
          if (wordSet.contains(newWord) && !visited.contains(newWord)) {
            queue.add(newWord);
            visited.add(newWord);
          }
        }
      }
    }

    // Move to the next level
    level++;
  }

  // If we've exhausted the BFS and haven't found endWord
  return 0;
}

// Test function
void main() {
  // Test cases
  String beginWord1 = "hit";
  String endWord1 = "cog";
  List<String> wordList1 = ["hot", "dot", "dog", "lot", "log", "cog"];

  String beginWord2 = "hit";
  String endWord2 = "cog";
  List<String> wordList2 = ["hot", "dot", "dog", "lot", "log"];

  String beginWord3 = "a";
  String endWord3 = "c";
  List<String> wordList3 = ["a", "b", "c"];

  print(
    'Input: beginWord = "$beginWord1", endWord = "$endWord1", wordList = $wordList1',
  );
  print('Output: ${ladderLength(beginWord1, endWord1, wordList1)}');

  print(
    '\nInput: beginWord = "$beginWord2", endWord = "$endWord2", wordList = $wordList2',
  );
  print('Output: ${ladderLength(beginWord2, endWord2, wordList2)}');

  print(
    '\nInput: beginWord = "$beginWord3", endWord = "$endWord3", wordList = $wordList3',
  );
  print('Output: ${ladderLength(beginWord3, endWord3, wordList3)}');

  // Detailed explanation for the example
  print(
    '\nDetailed explanation for beginWord = "hit", endWord = "cog", wordList = ["hot", "dot", "dog", "lot", "log", "cog"]:',
  );

  print('1. Initialize:');
  print('   - Convert wordList to wordSet for O(1) lookups');
  print('   - Check if "cog" is in wordSet (it is)');
  print('   - Initialize queue = ["hit"], visited = {"hit"}, level = 1');

  print('\n2. Start BFS:');
  print('   - Level 1:');
  print('     * Process "hit":');
  print(
    '       - Change first character: "ait", "bit", ..., "zit" (none in wordSet)',
  );
  print(
    '       - Change second character: "hat", "hbt", ..., "hot", ... (only "hot" in wordSet)',
  );
  print(
    '       - Change third character: "hia", "hib", ..., "hiz" (none in wordSet)',
  );
  print(
    '       - Add "hot" to queue, queue = ["hot"], visited = {"hit", "hot"}',
  );

  print('   - Level 2:');
  print('     * Process "hot":');
  print('       - Change characters, find "dot" and "lot" in wordSet');
  print(
    '       - Add "dot", "lot" to queue, queue = ["dot", "lot"], visited = {"hit", "hot", "dot", "lot"}',
  );

  print('   - Level 3:');
  print('     * Process "dot":');
  print('       - Change characters, find "dog" in wordSet');
  print('       - Add "dog" to queue, queue = ["lot", "dog"]');
  print('     * Process "lot":');
  print('       - Change characters, find "log" in wordSet');
  print('       - Add "log" to queue, queue = ["dog", "log"]');

  print('   - Level 4:');
  print('     * Process "dog":');
  print('       - Change characters, find "cog" in wordSet');
  print('       - Add "cog" to queue, queue = ["log", "cog"]');
  print('     * Process "log":');
  print(
    '       - Change characters, find "cog" (already visited), queue = ["cog"]',
  );

  print('   - Level 5:');
  print('     * Process "cog":');
  print('       - It matches endWord, so return level = 5');

  print('\n3. Result: 5');
}

/* Execution Trace:
1. ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]) is called:
   - Convert wordList to wordSet: {"hot", "dot", "dog", "lot", "log", "cog"}
   - Check if "cog" is in wordSet (it is)
   - Initialize queue = ["hit"], visited = {"hit"}, level = 1
   
   - Level 1:
     - Process "hit":
       * Try changing each character:
         - "ait", "bit", ..., "zit" (none in wordSet)
         - "hat", "hbt", ..., "hot", ... (only "hot" in wordSet)
         - "hia", "hib", ..., "hiz" (none in wordSet)
       * Add "hot" to queue, queue = ["hot"], visited = {"hit", "hot"}
     - level = 2
     
   - Level 2:
     - Process "hot":
       * Try changing each character, find "dot" and "lot" in wordSet
       * Add "dot", "lot" to queue, queue = ["dot", "lot"], visited = {"hit", "hot", "dot", "lot"}
     - level = 3
     
   - Level 3:
     - Process "dot":
       * Try changing each character, find "dog" in wordSet
       * Add "dog" to queue, queue = ["lot", "dog"]
     - Process "lot":
       * Try changing each character, find "log" in wordSet
       * Add "log" to queue, queue = ["dog", "log"]
     - level = 4
     
   - Level 4:
     - Process "dog":
       * Try changing each character, find "cog" in wordSet
       * Add "cog" to queue, queue = ["log", "cog"]
     - Process "log":
       * Try changing each character, find "cog" (already visited), queue = ["cog"]
     - level = 5
     
   - Level 5:
     - Process "cog":
       * It matches endWord, so return level = 5
   
   - Return 5

2. The shortest transformation sequence is "hit" -> "hot" -> "dot" -> "dog" -> "cog", with a length of 5.

Output:
Input: beginWord = "hit", endWord = "cog", wordList = [hot, dot, dog, lot, log, cog]
Output: 5

Input: beginWord = "hit", endWord = "cog", wordList = [hot, dot, dog, lot, log]
Output: 0

Input: beginWord = "a", endWord = "c", wordList = [a, b, c]
Output: 2

Detailed explanation for beginWord = "hit", endWord = "cog", wordList = ["hot", "dot", "dog", "lot", "log", "cog"]:
1. Initialize:
   - Convert wordList to wordSet for O(1) lookups
   - Check if "cog" is in wordSet (it is)
   - Initialize queue = ["hit"], visited = {"hit"}, level = 1

2. Start BFS:
   - Level 1:
     * Process "hit":
       - Change first character: "ait", "bit", ..., "zit" (none in wordSet)
       - Change second character: "hat", "hbt", ..., "hot", ... (only "hot" in wordSet)
       - Change third character: "hia", "hib", ..., "hiz" (none in wordSet)
       - Add "hot" to queue, queue = ["hot"], visited = {"hit", "hot"}

   - Level 2:
     * Process "hot":
       - Change characters, find "dot" and "lot" in wordSet
       - Add "dot", "lot" to queue, queue = ["dot", "lot"], visited = {"hit", "hot", "dot", "lot"}

   - Level 3:
     * Process "dot":
       - Change characters, find "dog" in wordSet
       - Add "dog" to queue, queue = ["lot", "dog"]
     * Process "lot":
       - Change characters, find "log" in wordSet
       - Add "log" to queue, queue = ["dog", "log"]

   - Level 4:
     * Process "dog":
       - Change characters, find "cog" in wordSet
       - Add "cog" to queue, queue = ["log", "cog"]
     * Process "log":
       - Change characters, find "cog" (already visited), queue = ["cog"]

   - Level 5:
     * Process "cog":
       - It matches endWord, so return level = 5

3. Result: 5
*/
