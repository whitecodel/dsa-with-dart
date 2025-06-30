# Sliding Window Algorithm Pattern

## Overview

The Sliding Window pattern is a technique used to process arrays or lists by maintaining a subset of elements as a "window" that slides through the data. This pattern is highly efficient for solving problems involving consecutive elements or subarrays/substrings.

## Types of Sliding Windows

### 1. Fixed-Size Window

- The window size remains constant throughout the operation
- Useful for problems like: "Find the maximum sum subarray of size K"
- Implementation involves sliding a window of fixed size across the array

### 2. Dynamic-Size Window

- The window size can grow or shrink based on certain conditions
- Useful for problems like: "Find the smallest subarray with a sum greater than or equal to X"
- Implementation involves expanding or contracting the window depending on a condition

## Time & Space Complexity

- **Time Complexity**: O(n) where n is the size of the input array/string
  - Much more efficient than nested loops (O(n²))
- **Space Complexity**: Usually O(1) for simple problems or O(k) where k is the window size for more complex problems

## When to Use Sliding Window?

- When dealing with contiguous sequences in arrays or strings
- When you need to find a subrange that meets specific criteria
- Problems involving maximum/minimum/sum of subarrays of a specific size
- Problems that require finding longest/shortest substring with certain properties

## Common Problem Patterns

1. **Maximum/minimum sum subarray of size K**
2. **Longest substring with K distinct characters**
3. **String anagrams or permutations**
4. **Maximum consecutive ones**
5. **Smallest subarray with a given sum**

## Basic Sliding Window Template (Dart)

```dart
// Fixed-size window template
void fixedSizeWindow(List<int> arr, int k) {
  // 1. Initialize window variables and results
  int windowStart = 0;
  int windowSum = 0;
  int maxSum = 0;

  // 2. Iterate through the array
  for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
    // 3. Add the current element to the window
    windowSum += arr[windowEnd];

    // 4. If we've hit the window size, process the window
    if (windowEnd >= k - 1) {
      // 5. Update result (if applicable)
      maxSum = max(maxSum, windowSum);

      // 6. Remove the element going out of the window
      windowSum -= arr[windowStart];

      // 7. Move the window start forward
      windowStart++;
    }
  }
}

// Dynamic-size window template
void dynamicSizeWindow(List<int> arr, int targetSum) {
  int windowStart = 0;
  int windowSum = 0;
  int minLength = double.infinity.toInt();

  // Expand the window
  for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
    windowSum += arr[windowEnd];

    // Contract the window until condition is no longer met
    while (windowSum >= targetSum) {
      minLength = min(minLength, windowEnd - windowStart + 1);
      windowSum -= arr[windowStart];
      windowStart++;
    }
  }
}
```

## Common Pitfalls

1. **Not handling edge cases**: Empty arrays, single-element arrays, or when k is larger than the array
2. **Off-by-one errors**: Be careful with window boundaries and indexing
3. **Inefficient window updates**: Recalculating window properties instead of incremental updates
4. **Not considering constraints**: Negative numbers, zero values, or specific constraints might require special handling

## Real-World Applications

- Stock price analysis (moving averages)
- Network packet analysis
- DNA sequence analysis
- Image processing (convolution operations)
- Data streaming algorithms
