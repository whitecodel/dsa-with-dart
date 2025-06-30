# Hash Map / Set (Frequency Counters) Algorithm Pattern

## Overview

The Hash Map / Set pattern (also known as Frequency Counters) uses hash-based data structures to store and track frequency or existence of elements. This pattern helps optimize algorithms that would otherwise require nested loops, improving time complexity from O(n²) to O(n) in many cases.

## How It Works

1. Use a hash map or set to store elements and their frequencies
2. Process the data structure once to build the frequency map
3. Process again to check conditions or find patterns
4. Avoid nested iterations that would lead to O(n²) time complexity

## Types of Hash-Based Data Structures

### 1. Hash Map / Dictionary

- Stores key-value pairs
- In Dart: `Map<K, V>`
- Good for tracking frequencies, relationships, or mappings
- Time complexity: O(1) for insertion, deletion, and lookup (average case)

### 2. Hash Set

- Stores unique elements without duplicates
- In Dart: `Set<E>`
- Good for checking existence or storing unique items
- Time complexity: O(1) for insertion, deletion, and lookup (average case)

## Common Applications

### 1. Frequency Counting

Count occurrences of elements in an array or string, useful for:

- Anagrams
- Permutations
- Character frequency analysis
- Finding duplicates

### 2. Two-Sum and Related Problems

Find pairs of elements that satisfy certain conditions:

- Two numbers adding up to a target value
- Pairs with specific differences
- Triplets with given sum

### 3. Set Operations

Efficient implementation of:

- Intersection
- Union
- Difference
- Subset checking

### 4. Caching

Store results of expensive operations:

- Memoization
- LRU Cache implementations
- Computing functions with the same inputs multiple times

## Time & Space Complexity

- **Time Complexity**: O(n) where n is the size of the input
- **Space Complexity**: O(k) where k is the number of unique elements (in worst case, k = n)

## When to Use Hash Map / Set Pattern

- When you need to count frequencies of elements
- When looking for patterns, pairs, or subsets
- When you want to avoid nested iterations
- When checking for existence of elements frequently
- When the problem involves comparisons between two arrays/strings
- When problems involve tracking unique elements

## Basic Hash Map / Set Template (Dart)

```dart
// Frequency counter example (anagram check)
bool areAnagrams(String str1, String str2) {
  // Edge cases: different lengths means not anagrams
  if (str1.length != str2.length) {
    return false;
  }

  // Create a frequency map for the first string
  Map<String, int> frequencyCounter = {};

  // Count characters in first string
  for (int i = 0; i < str1.length; i++) {
    String char = str1[i];
    frequencyCounter[char] = (frequencyCounter[char] ?? 0) + 1;
  }

  // Check characters in second string
  for (int i = 0; i < str2.length; i++) {
    String char = str2[i];

    // If char doesn't exist in map or its count is 0, not an anagram
    if (frequencyCounter[char] == null || frequencyCounter[char] == 0) {
      return false;
    }

    // Decrement frequency
    frequencyCounter[char] = frequencyCounter[char]! - 1;
  }

  return true;
}

// Set example (finding common elements)
List<int> findCommonElements(List<int> arr1, List<int> arr2) {
  Set<int> set = Set<int>.from(arr1);
  List<int> commonElements = [];

  for (int num in arr2) {
    if (set.contains(num)) {
      commonElements.add(num);
      set.remove(num); // To handle duplicates
    }
  }

  return commonElements;
}
```

## Common Pitfalls

1. **Forgetting to handle case sensitivity**: In string problems, decide whether upper and lowercase should be treated differently
2. **Not considering special characters**: Spaces, punctuation, etc. might need special handling
3. **Overlooking hash collisions**: In very large datasets, hash collisions can degrade performance
4. **Memory constraints**: Creating large hash maps/sets for massive inputs might cause memory issues
5. **Improper handling of duplicates**: Be clear on whether duplicates should be preserved

## Optimizations

### 1. Early Termination

You can often stop processing once certain conditions are met:

- Breaking out of loops when a condition is violated
- Returning early when the result can be determined

### 2. Using Primitive Types as Keys

Using primitive types (strings, numbers) as map keys is more efficient than complex objects.

### 3. Pre-sizing Hash Structures

If you know the approximate size beforehand, initialize with that capacity.

## Real-World Applications

- Spell checkers (storing dictionaries)
- Web browser caching (URL to content mapping)
- De-duplication systems
- Database indexing
- Compiler symbol tables
- Implementing sets and maps
- Counting distinct elements in data streams
