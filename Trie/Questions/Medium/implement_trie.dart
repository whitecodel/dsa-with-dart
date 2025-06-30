// Implement Trie (Prefix Tree)
// LeetCode 208: Implement Trie (Prefix Tree)

/*
Problem Statement:
Implement a trie with insert, search, and startsWith methods.

Example:
Trie trie = new Trie();
trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");
trie.search("app");     // returns true

Note:
- You may assume that all inputs are consisting of lowercase letters a-z.
- All inputs are guaranteed to be non-empty strings.
*/

// TrieNode class to represent each node in the Trie
class TrieNode {
  // Map to store children nodes, with character as key and TrieNode as value
  Map<String, TrieNode> children = {};

  // Flag to mark the end of a word
  bool isEndOfWord = false;
}

class Trie {
  // Root node of the Trie
  TrieNode root = TrieNode();

  // Step 1: Insert a word into the Trie
  // Time Complexity: O(m) where m is the length of the word
  // Space Complexity: O(m) in the worst case when adding a new word
  void insert(String word) {
    TrieNode current = root;

    // Traverse the Trie for each character in the word
    for (int i = 0; i < word.length; i++) {
      String char = word[i];

      // If the character doesn't exist in the current node's children,
      // create a new node for that character
      if (!current.children.containsKey(char)) {
        current.children[char] = TrieNode();

        // Debug: Print when a new node is created
        // print('Created new node for character: $char');
      }

      // Move to the next node
      current = current.children[char]!;

      // Debug: Print current path
      // print('Current path: ${word.substring(0, i + 1)}');
    }

    // Mark the end of the word
    current.isEndOfWord = true;

    // Debug: Print when a word is inserted
    // print('Inserted word: $word');
  }

  // Step 2: Search for a word in the Trie
  // Time Complexity: O(m) where m is the length of the word
  // Space Complexity: O(1) as we don't create any new nodes
  bool search(String word) {
    TrieNode? node = _findNode(word);

    // The word exists if we found a node and it's marked as the end of a word
    return node != null && node.isEndOfWord;
  }

  // Step 3: Check if there is any word in the Trie that starts with the given prefix
  // Time Complexity: O(m) where m is the length of the prefix
  // Space Complexity: O(1) as we don't create any new nodes
  bool startsWith(String prefix) {
    // If we found a node for the prefix, then there is at least one word
    // that starts with this prefix
    return _findNode(prefix) != null;
  }

  // Helper method to find a node corresponding to a word or prefix
  // Returns null if the node doesn't exist
  TrieNode? _findNode(String str) {
    TrieNode current = root;

    // Traverse the Trie for each character in the string
    for (int i = 0; i < str.length; i++) {
      String char = str[i];

      // If the character doesn't exist in current node's children,
      // the word or prefix doesn't exist
      if (!current.children.containsKey(char)) {
        return null;
      }

      // Move to the next node
      current = current.children[char]!;
    }

    return current;
  }

  // Additional method: Delete a word from the Trie
  // Time Complexity: O(m) where m is the length of the word
  // Space Complexity: O(1) as we don't create any new nodes
  bool delete(String word) {
    return _deleteHelper(root, word, 0);
  }

  // Recursive helper method for deletion
  bool _deleteHelper(TrieNode node, String word, int index) {
    // Base case: reached the end of the word
    if (index == word.length) {
      // If this node doesn't represent the end of a word, the word doesn't exist
      if (!node.isEndOfWord) {
        return false;
      }

      // Mark this node as not the end of a word
      node.isEndOfWord = false;

      // Return true if this node has no children, indicating it can be deleted
      return node.children.isEmpty;
    }

    // Get the current character
    String char = word[index];

    // If the character doesn't exist in the Trie, the word doesn't exist
    if (!node.children.containsKey(char)) {
      return false;
    }

    // Recursively delete from the child node
    bool shouldDeleteChild = _deleteHelper(
      node.children[char]!,
      word,
      index + 1,
    );

    // If the child should be deleted
    if (shouldDeleteChild) {
      node.children.remove(char);

      // Return true if this node is not the end of another word and has no other children
      return !node.isEndOfWord && node.children.isEmpty;
    }

    return false;
  }

  // Additional method: Display all words in the Trie
  List<String> getAllWords() {
    List<String> words = [];
    _getAllWordsHelper(root, '', words);
    return words;
  }

  // Recursive helper method to get all words
  void _getAllWordsHelper(
    TrieNode node,
    String currentWord,
    List<String> words,
  ) {
    // If this node is the end of a word, add the current word to the list
    if (node.isEndOfWord) {
      words.add(currentWord);
    }

    // Visit all children
    node.children.forEach((char, childNode) {
      _getAllWordsHelper(childNode, currentWord + char, words);
    });
  }
}

/*
Execution trace for the example operations:

1. Initialize:
   - Create a new Trie with an empty root node

2. trie.insert("apple"):
   - Start at the root
   - Process 'a': Create a new node for 'a' in root's children
   - Process 'p': Create a new node for 'p' in 'a' node's children
   - Process 'p': Create a new node for 'p' in 'p' node's children
   - Process 'l': Create a new node for 'l' in 'p' node's children
   - Process 'e': Create a new node for 'e' in 'l' node's children
   - Mark 'e' node as the end of a word
   - Trie structure now: root -> a -> p -> p -> l -> e (isEndOfWord=true)

3. trie.search("apple"):
   - Start at the root
   - Follow the path: 'a' -> 'p' -> 'p' -> 'l' -> 'e'
   - 'e' node exists and isEndOfWord=true
   - Return true

4. trie.search("app"):
   - Start at the root
   - Follow the path: 'a' -> 'p' -> 'p'
   - 'p' node exists but isEndOfWord=false
   - Return false

5. trie.startsWith("app"):
   - Start at the root
   - Follow the path: 'a' -> 'p' -> 'p'
   - 'p' node exists
   - Return true

6. trie.insert("app"):
   - Start at the root
   - Follow the path: 'a' -> 'p' -> 'p' (all nodes already exist)
   - Mark 'p' node as the end of a word
   - Trie structure now: root -> a -> p -> p (isEndOfWord=true) -> l -> e (isEndOfWord=true)

7. trie.search("app"):
   - Start at the root
   - Follow the path: 'a' -> 'p' -> 'p'
   - 'p' node exists and isEndOfWord=true
   - Return true
*/

void main() {
  // Create a new Trie
  Trie trie = Trie();

  // Test insertion and search
  trie.insert("apple");
  print('Search "apple": ${trie.search("apple")}'); // Expected: true
  print('Search "app": ${trie.search("app")}'); // Expected: false
  print('StartsWith "app": ${trie.startsWith("app")}'); // Expected: true

  trie.insert("app");
  print(
    'Search "app" after insertion: ${trie.search("app")}',
  ); // Expected: true

  // Additional test cases
  print('\nAdditional test cases:');

  // Test more words
  trie.insert("banana");
  trie.insert("band");
  trie.insert("bat");

  print('Search "banana": ${trie.search("banana")}'); // Expected: true
  print('Search "band": ${trie.search("band")}'); // Expected: true
  print('Search "ban": ${trie.search("ban")}'); // Expected: false
  print('StartsWith "ban": ${trie.startsWith("ban")}'); // Expected: true

  // Test deletion
  print('\nTesting deletion:');
  print('All words before deletion: ${trie.getAllWords()}');

  trie.delete("band");
  print('After deleting "band": ${trie.getAllWords()}');
  print(
    'Search "band" after deletion: ${trie.search("band")}',
  ); // Expected: false
  print(
    'Search "banana" after deletion: ${trie.search("banana")}',
  ); // Expected: true

  trie.delete("banana");
  print('After deleting "banana": ${trie.getAllWords()}');
  print(
    'StartsWith "ban" after deletion: ${trie.startsWith("ban")}',
  ); // Expected: false

  // Performance test
  print('\nPerformance test:');
  Stopwatch watch = Stopwatch()..start();

  // Insert a large number of words
  for (int i = 0; i < 1000; i++) {
    trie.insert('word$i');
  }

  watch.stop();
  print('Time to insert 1000 words: ${watch.elapsedMilliseconds}ms');

  // Search for all inserted words
  watch = Stopwatch()..start();
  bool allFound = true;

  for (int i = 0; i < 1000; i++) {
    if (!trie.search('word$i')) {
      allFound = false;
      break;
    }
  }

  watch.stop();
  print('All words found: $allFound');
  print('Time to search 1000 words: ${watch.elapsedMilliseconds}ms');
}
