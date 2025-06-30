# Prefix Sum

## Overview

Prefix Sum is a powerful technique used to compute cumulative sums of elements in an array. It's a fundamental algorithmic pattern that allows for efficient range sum queries and is particularly useful in computational geometry, dynamic programming, and various array manipulation problems.

The core idea is to precompute and store the running sum of the array elements, enabling constant-time calculation of sum over any range.

## Key Concepts

### Definition

For an array `A` of length `n`, the prefix sum array `P` of the same length is defined such that:

- `P[0] = A[0]`
- `P[i] = A[0] + A[1] + ... + A[i]` for `i > 0`

### Construction

Building a prefix sum array is straightforward:

```dart
List<int> buildPrefixSum(List<int> arr) {
  List<int> prefixSum = List.filled(arr.length, 0);
  prefixSum[0] = arr[0];

  for (int i = 1; i < arr.length; i++) {
    prefixSum[i] = prefixSum[i - 1] + arr[i];
  }

  return prefixSum;
}
```

### Range Sum Queries

Once the prefix sum array is built, the sum of elements from index `i` to index `j` can be calculated in O(1) time:

- For `i = 0`: sum from 0 to j = `P[j]`
- For `i > 0`: sum from i to j = `P[j] - P[i-1]`

```dart
int rangeSum(List<int> prefixSum, int i, int j) {
  if (i == 0) return prefixSum[j];
  return prefixSum[j] - prefixSum[i - 1];
}
```

## Applications

### 1. Subarray Sum Queries

Quick calculation of sum for any subarray without iterating through elements.

### 2. Equilibrium Point

Finding a position in the array where the sum of elements to the left equals the sum of elements to the right.

### 3. Maximum Subarray Sum

Using prefix sums to optimize the solution for finding a subarray with the largest sum.

### 4. 2D Array Queries

Extension to 2D prefix sums for efficient rectangle area sum calculations.

```dart
List<List<int>> build2DPrefixSum(List<List<int>> matrix) {
  int rows = matrix.length;
  int cols = matrix[0].length;
  List<List<int>> prefixSum = List.generate(
    rows,
    (_) => List.filled(cols, 0)
  );

  // Fill the first row and column
  prefixSum[0][0] = matrix[0][0];

  // Fill first row
  for (int j = 1; j < cols; j++) {
    prefixSum[0][j] = prefixSum[0][j-1] + matrix[0][j];
  }

  // Fill first column
  for (int i = 1; i < rows; i++) {
    prefixSum[i][0] = prefixSum[i-1][0] + matrix[i][0];
  }

  // Fill rest of the matrix
  for (int i = 1; i < rows; i++) {
    for (int j = 1; j < cols; j++) {
      prefixSum[i][j] = prefixSum[i-1][j] + prefixSum[i][j-1]
                      - prefixSum[i-1][j-1] + matrix[i][j];
    }
  }

  return prefixSum;
}

// Get sum of rectangle from (r1,c1) to (r2,c2)
int getSubMatrixSum(List<List<int>> prefixSum, int r1, int c1, int r2, int c2) {
  int result = prefixSum[r2][c2];

  if (r1 > 0) result -= prefixSum[r1-1][c2];
  if (c1 > 0) result -= prefixSum[r2][c1-1];
  if (r1 > 0 && c1 > 0) result += prefixSum[r1-1][c1-1];

  return result;
}
```

### 5. Difference Array (Inverse of Prefix Sum)

Used when you need to perform multiple range update operations.

```dart
// Increment range [l, r] by val
void updateRange(List<int> diff, int l, int r, int val) {
  diff[l] += val;
  if (r + 1 < diff.length) diff[r + 1] -= val;
}

// Reconstruct original array after updates
List<int> reconstructArray(List<int> diff) {
  List<int> result = List.filled(diff.length, 0);
  result[0] = diff[0];

  for (int i = 1; i < diff.length; i++) {
    result[i] = result[i - 1] + diff[i];
  }

  return result;
}
```

## Common Patterns

### 1. Subarray with Target Sum

Using a hash map to find subarrays with a given sum:

```dart
int countSubarraysWithSum(List<int> arr, int targetSum) {
  Map<int, int> prefixSumCount = {0: 1}; // Empty subarray has sum 0
  int currentSum = 0;
  int count = 0;

  for (int num in arr) {
    currentSum += num;
    int complement = currentSum - targetSum;

    // If we've seen a prefix sum of 'complement', it means
    // the subarray ending at current position has sum equal to targetSum
    if (prefixSumCount.containsKey(complement)) {
      count += prefixSumCount[complement]!;
    }

    // Update the count of current prefix sum
    prefixSumCount[currentSum] = (prefixSumCount[currentSum] ?? 0) + 1;
  }

  return count;
}
```

### 2. Continuous Subarray Sum

Finding subarrays with sum divisible by k:

```dart
bool checkSubarraySum(List<int> nums, int k) {
  // Map from prefix sum modulo k to its index
  Map<int, int> modMap = {0: -1};
  int runningSum = 0;

  for (int i = 0; i < nums.length; i++) {
    runningSum += nums[i];

    // Take modulo only if k is not 0
    int mod = k != 0 ? runningSum % k : runningSum;

    // If we've seen this modulo before and subarray length is at least 2
    if (modMap.containsKey(mod)) {
      if (i - modMap[mod]! > 1) return true;
    } else {
      modMap[mod] = i;
    }
  }

  return false;
}
```

## Time and Space Complexity

### Prefix Sum Array Construction

- **Time Complexity**: O(n) - One pass through the array
- **Space Complexity**: O(n) - Additional array to store prefix sums

### Range Sum Queries

- **Time Complexity**: O(1) per query (after preprocessing)
- **Space Complexity**: O(1) per query (excluding the prefix sum array)

## Dart-Specific Notes

- When working with large arrays, be aware of integer overflow. Consider using `Int64` from the `fixnum` package for very large sums.
- The standard library's `Iterable` class provides convenient methods like `fold` and `reduce` that can be used for computing running sums in a functional style.

## When to Use

- When you need to perform multiple range sum queries efficiently
- When calculating cumulative property over array segments
- In problems involving subarrays that satisfy certain sum conditions
- For 2D grid/matrix problems requiring efficient area calculations
- When dealing with problems that can be transformed into range updates and point queries
