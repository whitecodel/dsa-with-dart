# Trie (Prefix Tree) Algorithm Pattern

## Overview

A Trie (pronounced "try") or Prefix Tree is a tree-like data structure used for efficient retrieval of keys in a dataset of strings. Unlike a binary search tree, keys are not stored in nodes but rather implied by the path from the root to the node.

## Structure of a Trie

### Basic Components

- **Root Node**: Usually an empty node that serves as the starting point
- **Child Nodes**: Each node can have multiple children (typically one for each character in the alphabet)
- **Terminal Marker**: Indicates the end of a complete word

### Visual Representation

```
      root
     /   \
    c     t
   /     / \
  a     e   o
 / \     \   \
t   r     a   o
          |
       terminal
```

In this example, the trie stores the words "cat", "car", "tea", and "too".

## Operations and Their Complexities

### 1. Insertion

- Start at the root
- For each character in the key, move to the corresponding child or create one if it doesn't exist
- Mark the last node as terminal
- **Time Complexity**: O(m) where m is the length of the key
- **Space Complexity**: O(m) in the worst case for a new word

### 2. Search

- Start at the root
- For each character in the key, move to the corresponding child
- If a character's path doesn't exist, the key isn't in the trie
- If the final node isn't marked as terminal, the key isn't in the trie as a complete word
- **Time Complexity**: O(m) where m is the length of the key
- **Space Complexity**: O(1)

### 3. Prefix Search

- Similar to search, but doesn't require the terminal marker
- **Time Complexity**: O(m) where m is the length of the prefix
- **Space Complexity**: O(1)

### 4. Deletion

- Find the node corresponding to the last character of the key
- Remove the terminal marker if other branches exist from that node
- Remove nodes from the last character back toward the root until finding a branch point or terminal node
- **Time Complexity**: O(m) where m is the length of the key
- **Space Complexity**: O(1)

## Trie Implementation in Dart

```dart
class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
}

class Trie {
  TrieNode root = TrieNode();

  // Insert a word into the trie
  void insert(String word) {
    TrieNode node = root;

    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!node.children.containsKey(char)) {
        node.children[char] = TrieNode();
      }
      node = node.children[char]!;
    }

    node.isEndOfWord = true; // Mark the end of the word
  }

  // Search for a word in the trie
  bool search(String word) {
    TrieNode node = root;

    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!node.children.containsKey(char)) {
        return false; // Character path doesn't exist
      }
      node = node.children[char]!;
    }

    return node.isEndOfWord; // Check if this is a complete word
  }

  // Check if there is any word that starts with the given prefix
  bool startsWith(String prefix) {
    TrieNode node = root;

    for (int i = 0; i < prefix.length; i++) {
      String char = prefix[i];
      if (!node.children.containsKey(char)) {
        return false; // Prefix doesn't exist
      }
      node = node.children[char]!;
    }

    return true; // Prefix exists
  }

  // Delete a word from the trie
  bool delete(String word) {
    return _deleteHelper(root, word, 0);
  }

  bool _deleteHelper(TrieNode node, String word, int depth) {
    // Base case: reached the end of the word
    if (depth == word.length) {
      if (!node.isEndOfWord) {
        return false; // Word doesn't exist
      }

      node.isEndOfWord = false; // Unmark as end of word

      // Return true if this node has no other children
      return node.children.isEmpty;
    }

    // Recursive case: process characters
    String char = word[depth];
    if (!node.children.containsKey(char)) {
      return false; // Word doesn't exist
    }

    bool shouldDeleteCurrentNode = _deleteHelper(node.children[char]!, word, depth + 1);

    // If the child should be deleted and it's not the end of another word
    if (shouldDeleteCurrentNode) {
      node.children.remove(char);

      // Return true if this node has no other children and is not the end of a word
      return node.children.isEmpty && !node.isEndOfWord;
    }

    return false;
  }
}
```

## Advantages of Tries

1. **Fast Lookups**: O(m) time complexity for operations, where m is the length of the key
2. **Prefix Matching**: Efficient for problems requiring prefix matching
3. **Space Efficiency**: For large datasets with common prefixes, tries can be space-efficient
4. **Predictive Text**: Ideal for implementing autocomplete and predictive text features
5. **Sorted Data**: Keys are inherently stored in lexicographic order

## Common Applications

1. **Autocomplete & Predictive Text**: Suggest words as users type
2. **Spell Checking**: Quickly verify if a word exists in a dictionary
3. **IP Routing**: Store routing tables in network routers
4. **String Search in Documents**: Index texts for faster searching
5. **Word Games**: Efficiently verify valid words (e.g., Scrabble, Boggle)
6. **Longest Prefix Matching**: Find the longest matching prefix
7. **Dictionary Implementation**: For efficient word lookup
8. **Contact List Search**: Search contacts by prefix

## Variations and Extensions

### 1. Compressed Trie (Radix Tree)

- Merges chains of nodes with only one child
- Reduces space requirements
- Improves cache performance

### 2. Suffix Trie

- Stores all suffixes of a given string
- Useful for substring search problems

### 3. Ternary Search Trie

- Each node has three children (left, middle, right)
- More space-efficient than standard trie
- Good for sparse character sets

## Common Problems and Algorithms

1. **Word Search in a Grid**: Find words in a 2D grid of characters
2. **Word Break Problem**: Determine if a string can be segmented into dictionary words
3. **Longest Common Prefix**: Find the longest common prefix among a set of strings
4. **Auto-complete Systems**: Implement type-ahead features
5. **Boggle Solver**: Find all valid words in a Boggle board
6. **Longest Word in Dictionary**: Find the longest word that can be built one character at a time

## Comparison with Other Data Structures

| Aspect            | Trie                      | Hash Table   | Binary Search Tree |
| ----------------- | ------------------------- | ------------ | ------------------ |
| Search Time       | O(m)                      | O(1) average | O(log n) average   |
| Space             | Depends on prefix overlap | O(n\*m)      | O(n\*m)            |
| Prefix Search     | Yes, efficient            | No           | Not directly       |
| Ordered Iteration | Yes, lexicographic        | No           | Yes, sorted order  |
| Implementation    | Complex                   | Simple       | Moderate           |

## Common Pitfalls and Optimizations

1. **Memory Usage**: Standard tries can be memory-intensive; consider compressed tries for large datasets
2. **Character Set Size**: Large alphabets can lead to sparse nodes; consider alternate implementations
3. **Case Sensitivity**: Decide whether to handle case sensitivity or normalize input
4. **Special Characters**: Define how to handle non-alphanumeric characters
5. **Deletion Logic**: Ensure proper cleanup to avoid memory leaks
6. **Thread Safety**: Implement thread-safe operations if used concurrently
