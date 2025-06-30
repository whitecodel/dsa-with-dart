# Two Pointers Algorithm Pattern

## Overview

The Two Pointers technique involves using two pointers (or indices) to solve problems involving arrays, linked lists, or strings. These pointers can move toward each other, away from each other, or at different speeds, making it an efficient way to solve problems that might otherwise require nested loops.

## Types of Two Pointers Approaches

### 1. Opposite Direction (Converging Pointers)

- One pointer starts at the beginning, the other at the end
- Both pointers move toward each other until they meet or satisfy a condition
- Examples: Two Sum II, Valid Palindrome

### 2. Same Direction (Fast & Slow Pointers)

- Both pointers start from the beginning
- One pointer moves faster than the other
- Examples: Remove Duplicates, Find Cycle in Linked List

### 3. Partitioning

- Used to partition arrays around a pivot value
- Examples: Dutch National Flag problem, Quick Sort

## Time & Space Complexity

- **Time Complexity**: Typically O(n) where n is the input size
  - Replaces the O(n²) complexity of nested loops
- **Space Complexity**: Usually O(1) as only a few pointer variables are needed

## When to Use Two Pointers?

- When dealing with sorted arrays
- Problems involving searching pairs in a sorted array
- Problems requiring in-place array transformations
- Problems involving palindromes or symmetric structures
- When you need to find a set of elements that fulfill certain constraints

## Common Problem Patterns

1. **Pair with Target Sum (Two Sum)**
2. **Removing duplicates**
3. **Squaring a sorted array**
4. **Triplet Sum to Zero (3Sum)**
5. **Dutch National Flag Problem (Sort Colors)**
6. **Palindrome checks**
7. **Reverse operations**

## Basic Two Pointers Template (Dart)

```dart
// Opposite Direction Two Pointers
void twoPointersOppositeDirection(List<int> arr) {
  int left = 0;
  int right = arr.length - 1;

  while (left < right) {
    // Process elements at left and right pointers

    // Move pointers based on some condition
    if (someCondition) {
      left++;
    } else {
      right--;
    }
  }
}

// Same Direction Two Pointers
void twoPointersSameDirection(List<int> arr) {
  int slow = 0;

  for (int fast = 0; fast < arr.length; fast++) {
    // Process elements using slow and fast pointers

    // Conditionally move the slow pointer
    if (someCondition) {
      // Often involves swapping or updating elements at the slow pointer
      arr[slow] = arr[fast];
      slow++;
    }
  }
}

// Partitioning (Dutch National Flag Problem)
void partition(List<int> arr, int pivot) {
  int low = 0;
  int high = arr.length - 1;
  int i = 0;

  while (i <= high) {
    if (arr[i] < pivot) {
      swap(arr, i, low);
      i++;
      low++;
    } else if (arr[i] > pivot) {
      swap(arr, i, high);
      high--;
    } else {
      i++;
    }
  }
}
```

## Common Pitfalls

1. **Off-by-one errors**: Be careful with boundary conditions and when to terminate loops
2. **Infinite loops**: Ensure pointers are always moving in each iteration
3. **Not handling duplicate elements**: Some problems require special handling for duplicates
4. **Not considering edge cases**: Empty arrays, single-element arrays, or arrays with all identical elements

## Real-World Applications

- String operations (palindrome checks, anagram detection)
- In-place array transformations
- Memory-efficient algorithms
- Cycle detection in linked lists and graphs
- Efficient searching in sorted arrays

## Comparison with Other Techniques

| Technique          | Two Pointers                      | Sliding Window        | Binary Search                |
| ------------------ | --------------------------------- | --------------------- | ---------------------------- |
| Best used for      | Pair finding, in-place operations | Subarrays/substrings  | Searching in sorted arrays   |
| Complexity         | O(n)                              | O(n)                  | O(log n)                     |
| Data requirements  | Often needs sorted data           | Sequential access     | Sorted data required         |
| Number of pointers | 2                                 | 2 (defining a window) | Usually 3 (left, right, mid) |
