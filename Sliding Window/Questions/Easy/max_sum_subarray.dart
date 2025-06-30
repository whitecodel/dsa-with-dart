// Maximum Sum Subarray of Size K
// LeetCode similar problem: Maximum Average Subarray I (leetcode 643)

/*
Problem Statement:
Given an array of positive integers and a positive integer 'k', find the maximum sum of any
contiguous subarray of size 'k'.

Example:
Input: [2, 1, 5, 1, 3, 2], k=3
Output: 9
Explanation: Subarrays of size 3 are:
[2, 1, 5] = 8
[1, 5, 1] = 7
[5, 1, 3] = 9 (maximum)
[1, 3, 2] = 6
*/

// Time Complexity: O(n) where n is the length of the array
// Space Complexity: O(1) as we use only a few variables

int findMaxSumSubarray(List<int> arr, int k) {
  // Step 1: Check for edge cases
  if (arr.isEmpty || k <= 0 || k > arr.length) {
    // If array is empty or k is invalid, return error or default value
    // Here we return 0 as default
    return 0;
  }

  // Step 2: Initialize variables
  int maxSum = 0; // This will store our result - the maximum sum
  int windowSum = 0; // This tracks the current window sum
  int windowStart = 0; // Start index of our current window

  // Step 3: Iterate through the array
  for (int windowEnd = 0; windowEnd < arr.length; windowEnd++) {
    // Add the current element to our window sum
    windowSum += arr[windowEnd];

    // Print the current state for clarity
    // print('Added ${arr[windowEnd]} at index $windowEnd, windowSum = $windowSum');

    // Step 4: When we've accumulated 'k' elements in our window
    if (windowEnd >= k - 1) {
      // Update the maxSum if current windowSum is greater
      maxSum = maxSum > windowSum ? maxSum : windowSum;
      // print('Window complete [${arr.sublist(windowStart, windowEnd + 1)}], windowSum = $windowSum, maxSum = $maxSum');

      // Step 5: Remove the element going out of the window
      windowSum -= arr[windowStart];
      // print('Removed ${arr[windowStart]} from window, new windowSum = $windowSum');

      // Step 6: Move the window start forward
      windowStart++;
    }
  }

  return maxSum;
}

/*
Execution trace for example [2, 1, 5, 1, 3, 2] with k=3:

1. windowEnd = 0:
   - Add arr[0] = 2 to windowSum → windowSum = 2
   - Window size is 1, less than k=3, so we continue

2. windowEnd = 1:
   - Add arr[1] = 1 to windowSum → windowSum = 2 + 1 = 3
   - Window size is 2, less than k=3, so we continue

3. windowEnd = 2:
   - Add arr[2] = 5 to windowSum → windowSum = 3 + 5 = 8
   - Window size is 3, equal to k=3
   - maxSum = max(0, 8) = 8
   - Remove arr[0] = 2 from windowSum → windowSum = 8 - 2 = 6
   - Move windowStart to 1

4. windowEnd = 3:
   - Add arr[3] = 1 to windowSum → windowSum = 6 + 1 = 7
   - Window size is 3, equal to k=3
   - maxSum = max(8, 7) = 8
   - Remove arr[1] = 1 from windowSum → windowSum = 7 - 1 = 6
   - Move windowStart to 2

5. windowEnd = 4:
   - Add arr[4] = 3 to windowSum → windowSum = 6 + 3 = 9
   - Window size is 3, equal to k=3
   - maxSum = max(8, 9) = 9
   - Remove arr[2] = 5 from windowSum → windowSum = 9 - 5 = 4
   - Move windowStart to 3

6. windowEnd = 5:
   - Add arr[5] = 2 to windowSum → windowSum = 4 + 2 = 6
   - Window size is 3, equal to k=3
   - maxSum = max(9, 6) = 9
   - Remove arr[3] = 1 from windowSum → windowSum = 6 - 1 = 5
   - Move windowStart to 4

7. End of array, return maxSum = 9
*/

// Main function to test the algorithm
void main() {
  List<int> testArray = [2, 1, 5, 1, 3, 2];
  int k = 3;

  int result = findMaxSumSubarray(testArray, k);
  print('Maximum sum of a subarray of size $k is: $result');

  // Additional test cases
  testArray = [1, 4, 2, 10, 23, 3, 1, 0, 20];
  k = 4;
  result = findMaxSumSubarray(testArray, k);
  print('Maximum sum of a subarray of size $k is: $result'); // Expected: 39

  testArray = [3, 4, 5, 1, 2];
  k = 2;
  result = findMaxSumSubarray(testArray, k);
  print('Maximum sum of a subarray of size $k is: $result'); // Expected: 9
}
