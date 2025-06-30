# Binary Search Algorithm Pattern

## Overview

Binary Search is a divide-and-conquer algorithm that efficiently finds a target value within a sorted array. It works by repeatedly dividing the search interval in half, eliminating half of the remaining elements in each step.

## How It Works

1. Start with the middle element of the sorted array
2. If the target value equals the middle element, return its position
3. If the target value is greater, search the right half
4. If the target value is smaller, search the left half
5. Repeat until the target is found or the subarray size becomes zero

## Types of Binary Search

### 1. Classic Binary Search

- Search for an exact value in a sorted array
- Return the index if found, or indicate absence

### 2. Finding Boundaries

- First occurrence of a value
- Last occurrence of a value
- Insertion point for a new value

### 3. Binary Search on Answer

- Finding a value that satisfies certain conditions
- The search space is over possible answers rather than array indices
- Often used in optimization problems

### 4. Rotated or Modified Arrays

- Finding elements in rotated sorted arrays
- Peak elements in bitonic arrays
- K-th smallest/largest element

## Time & Space Complexity

- **Time Complexity**: O(log n) where n is the size of the input array
  - Each step reduces the search space by half
- **Space Complexity**:
  - O(1) for iterative implementation
  - O(log n) for recursive implementation (due to call stack)

## When to Use Binary Search

- When the data is sorted or partially sorted
- When you need to find a specific value or boundary
- When the problem involves searching in a range of potential answers
- When the brute force solution is too slow (usually O(n) or worse)
- When you need to optimize beyond linear search
- When working with large datasets where efficiency is crucial

## Basic Binary Search Template (Dart)

```dart
// Classic Binary Search
int binarySearch(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;

  while (left <= right) {
    int mid = left + (right - left) ~/ 2;  // Prevent integer overflow

    if (nums[mid] == target) {
      return mid;  // Target found
    } else if (nums[mid] < target) {
      left = mid + 1;  // Search the right half
    } else {
      right = mid - 1;  // Search the left half
    }
  }

  return -1;  // Target not found
}

// Finding leftmost occurrence
int findLeftBound(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;
  int result = -1;

  while (left <= right) {
    int mid = left + (right - left) ~/ 2;

    if (nums[mid] == target) {
      result = mid;      // Save this as a potential result
      right = mid - 1;   // But continue searching on the left
    } else if (nums[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return result;
}

// Binary search on answer space (example: finding square root)
int mySqrt(int x) {
  if (x <= 1) return x;

  int left = 1;
  int right = x ~/ 2;  // Square root can't be more than x/2 for x > 4
  int result = 0;

  while (left <= right) {
    int mid = left + (right - left) ~/ 2;

    if (mid <= x ~/ mid) {  // Equivalent to mid*mid <= x without overflow
      result = mid;        // Save potential result
      left = mid + 1;      // Try bigger values
    } else {
      right = mid - 1;     // Try smaller values
    }
  }

  return result;
}
```

## Common Variations and Tricks

### 1. Infinite Array / Unknown Size

When the array is very large or its size is unknown, use doubling to find bounds before binary search.

```dart
int searchInfinite(InfiniteArray arr, int target) {
  // First, find upper bound
  int low = 0;
  int high = 1;

  while (arr.get(high) < target) {
    low = high;
    high = high * 2;  // Double the bound
  }

  // Now perform binary search between low and high
  return binarySearch(arr, target, low, high);
}
```

### 2. Binary Search in 2D Sorted Matrix

When a matrix is sorted (each row and each column is sorted), you can apply binary search.

### 3. Handle Duplicates

Special handling is needed for arrays with duplicates to find first or last occurrences.

## Common Pitfalls

1. **Off-by-one errors**: Be careful with boundary conditions (< vs <=)
2. **Integer overflow**: Use mid = left + (right - left) / 2 instead of (left + right) / 2
3. **Infinite loops**: Ensure the search space is always reduced
4. **Incorrect comparisons**: Double-check the comparison logic
5. **Not handling edge cases**: Empty arrays, single elements, etc.

## Real-World Applications

- Database indexing and queries
- Finding items in sorted collections
- Machine learning algorithms (e.g., hyperparameter tuning)
- Computational geometry
- Search algorithms
- Approximate matching
- Dictionary lookups
