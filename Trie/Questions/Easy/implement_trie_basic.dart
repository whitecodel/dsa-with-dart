// Implement Trie (Prefix Tree) - Basic Operations
// Problem: Implement the basic operations of a Trie (Prefix Tree):
// 1. Insert a word
// 2. Search for a word
// 3. Check if there is any word with a given prefix
//
// Example:
//   Input:
//     ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
//     [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
//   Output:
//     [null, null, true, false, true, null, true]
//   Explanation:
//     Trie trie = new Trie();
//     trie.insert("apple");
//     trie.search("apple");   // return True
//     trie.search("app");     // return False
//     trie.startsWith("app"); // return True
//     trie.insert("app");
//     trie.search("app");     // return True

// Trie (Prefix Tree) Implementation
class Trie {
  // Root node of the trie
  final TrieNode _root;

  // Constructor
  Trie() : _root = TrieNode();

  // Insert a word into the trie
  //
  // Time Complexity: O(m) where m is the length of the word
  // Space Complexity: O(m) where m is the length of the word
  void insert(String word) {
    TrieNode node = _root;

    // Iterate through each character in the word
    for (int i = 0; i < word.length; i++) {
      String char = word[i];

      // If the character doesn't exist in the current node's children,
      // create a new node for it
      if (!node.children.containsKey(char)) {
        node.children[char] = TrieNode();
      }

      // Move to the next node
      node = node.children[char]!;
    }

    // Mark the end of the word
    node.isEndOfWord = true;
  }

  // Search for a word in the trie
  //
  // Time Complexity: O(m) where m is the length of the word
  // Space Complexity: O(1)
  bool search(String word) {
    TrieNode node = _root;

    // Iterate through each character in the word
    for (int i = 0; i < word.length; i++) {
      String char = word[i];

      // If the character doesn't exist in the current node's children,
      // the word doesn't exist in the trie
      if (!node.children.containsKey(char)) {
        return false;
      }

      // Move to the next node
      node = node.children[char]!;
    }

    // Check if the last node represents the end of a word
    return node.isEndOfWord;
  }

  // Check if there is any word in the trie that starts with the given prefix
  //
  // Time Complexity: O(m) where m is the length of the prefix
  // Space Complexity: O(1)
  bool startsWith(String prefix) {
    TrieNode node = _root;

    // Iterate through each character in the prefix
    for (int i = 0; i < prefix.length; i++) {
      String char = prefix[i];

      // If the character doesn't exist in the current node's children,
      // no word starts with the prefix
      if (!node.children.containsKey(char)) {
        return false;
      }

      // Move to the next node
      node = node.children[char]!;
    }

    // If we can traverse all characters in the prefix, it exists
    return true;
  }
}

// TrieNode class to represent each node in the Trie
class TrieNode {
  // Map to store children nodes, where key is the character and value is the child node
  final Map<String, TrieNode> children = {};

  // Flag to mark the end of a word
  bool isEndOfWord = false;

  // Constructor
  TrieNode();
}

// Execution trace for ["apple", "app"]:
//
// 1. Insert "apple":
//    - Start at root
//    - For 'a': Add 'a' to root's children
//    - For 'p': Add 'p' to 'a' node's children
//    - For 'p': Add 'p' to first 'p' node's children
//    - For 'l': Add 'l' to second 'p' node's children
//    - For 'e': Add 'e' to 'l' node's children
//    - Mark 'e' node as end of word
//
// 2. Search "apple":
//    - Start at root
//    - Traverse: 'a' -> 'p' -> 'p' -> 'l' -> 'e'
//    - 'e' node is marked as end of word, return true
//
// 3. Search "app":
//    - Start at root
//    - Traverse: 'a' -> 'p' -> 'p'
//    - Last 'p' node is not marked as end of word, return false
//
// 4. startsWith "app":
//    - Start at root
//    - Traverse: 'a' -> 'p' -> 'p'
//    - Successfully traversed all characters in prefix, return true
//
// 5. Insert "app":
//    - Start at root
//    - For 'a': 'a' already exists in root's children
//    - For 'p': 'p' already exists in 'a' node's children
//    - For 'p': 'p' already exists in first 'p' node's children
//    - Mark second 'p' node as end of word
//
// 6. Search "app":
//    - Start at root
//    - Traverse: 'a' -> 'p' -> 'p'
//    - Last 'p' node is now marked as end of word, return true

void main() {
  // Test Case 1: Basic operations
  print('Test Case 1: Basic operations from example');
  var trie1 = Trie();

  print('Insert "apple"');
  trie1.insert("apple");

  print('Search "apple": ${trie1.search("apple")}');
  print('Search "app": ${trie1.search("app")}');
  print('StartsWith "app": ${trie1.startsWith("app")}');

  print('Insert "app"');
  trie1.insert("app");

  print('Search "app": ${trie1.search("app")}');

  // Test Case 2: More complex operations
  print('\nTest Case 2: More complex operations');
  var trie2 = Trie();

  // Insert multiple words
  List<String> words = [
    "hello",
    "world",
    "help",
    "heap",
    "heal",
    "hearing",
    "cat",
    "car",
  ];
  for (var word in words) {
    print('Insert "$word"');
    trie2.insert(word);
  }

  // Search operations
  var searchWords = [
    "hello",
    "world",
    "help",
    "heap",
    "hear",
    "he",
    "cat",
    "car",
    "card",
  ];
  for (var word in searchWords) {
    print('Search "$word": ${trie2.search(word)}');
  }

  // Prefix operations
  var prefixes = ["he", "hea", "hear", "hell", "ca", "co"];
  for (var prefix in prefixes) {
    print('StartsWith "$prefix": ${trie2.startsWith(prefix)}');
  }

  // Test Case 3: Empty string and special cases
  print('\nTest Case 3: Empty string and special cases');
  var trie3 = Trie();

  print('Insert empty string');
  trie3.insert("");

  print('Search empty string: ${trie3.search("")}');
  print('StartsWith empty string: ${trie3.startsWith("")}');

  print('Insert single character "a"');
  trie3.insert("a");

  print('Search "a": ${trie3.search("a")}');
  print('StartsWith "a": ${trie3.startsWith("a")}');
}
