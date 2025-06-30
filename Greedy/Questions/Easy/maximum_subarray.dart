// Maximum Subarray
// LeetCode 53: Maximum Subarray

/*
Problem Statement:
Given an integer array nums, find the contiguous subarray (containing at least 
one number) which has the largest sum and return its sum.

Example 1:
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.

Example 2:
Input: nums = [1]
Output: 1

Example 3:
Input: nums = [5,4,-1,7,8]
Output: 23
*/

// ============== Approach: Greedy (Kadane's Algorithm) ==============
// Time Complexity: O(n) where n is the length of the array
// Space Complexity: O(1) as we only use a few variables

int maxSubArray(List<int> nums) {
  // Step 1: Handle edge case - empty array
  if (nums.isEmpty) {
    return 0;
  }

  // Step 2: Initialize variables
  int currentSum = nums[0]; // Sum of the current subarray
  int maxSum = nums[0]; // Maximum sum found so far

  // Step 3: Iterate through the array starting from the second element
  for (int i = 1; i < nums.length; i++) {
    // Step 4: Make the greedy choice
    // Either start a new subarray from the current element
    // or extend the existing subarray by including the current element
    currentSum = (nums[i] > currentSum + nums[i])
        ? nums[i]
        : currentSum + nums[i];

    // Debug: Print the greedy decision
    // print('At index $i (value ${nums[i]}): Start new? ${nums[i] > currentSum + nums[i]}, currentSum = $currentSum');

    // Step 5: Update the maximum sum if we found a better subarray
    maxSum = maxSum > currentSum ? maxSum : currentSum;

    // Debug: Print maximum sum at each step
    // print('maxSum updated to: $maxSum');
  }

  return maxSum;
}

/*
Execution trace for nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]:

1. Initialize:
   - currentSum = -2 (first element)
   - maxSum = -2

2. i = 1, value = 1:
   - Decision: 1 vs -2 + 1 = -1
   - Start new subarray, currentSum = 1
   - maxSum = max(-2, 1) = 1

3. i = 2, value = -3:
   - Decision: -3 vs 1 + (-3) = -2
   - Continue current subarray, currentSum = -2
   - maxSum = max(1, -2) = 1

4. i = 3, value = 4:
   - Decision: 4 vs -2 + 4 = 2
   - Start new subarray, currentSum = 4
   - maxSum = max(1, 4) = 4

5. i = 4, value = -1:
   - Decision: -1 vs 4 + (-1) = 3
   - Continue current subarray, currentSum = 3
   - maxSum = max(4, 3) = 4

6. i = 5, value = 2:
   - Decision: 2 vs 3 + 2 = 5
   - Continue current subarray, currentSum = 5
   - maxSum = max(4, 5) = 5

7. i = 6, value = 1:
   - Decision: 1 vs 5 + 1 = 6
   - Continue current subarray, currentSum = 6
   - maxSum = max(5, 6) = 6

8. i = 7, value = -5:
   - Decision: -5 vs 6 + (-5) = 1
   - Continue current subarray, currentSum = 1
   - maxSum = max(6, 1) = 6

9. i = 8, value = 4:
   - Decision: 4 vs 1 + 4 = 5
   - Continue current subarray, currentSum = 5
   - maxSum = max(6, 5) = 6

10. Return maxSum = 6
*/

// ============== Alternative Cleaner Implementation ==============
int maxSubArrayCleaner(List<int> nums) {
  if (nums.isEmpty) {
    return 0;
  }

  int currentSum = nums[0];
  int maxSum = nums[0];

  for (int i = 1; i < nums.length; i++) {
    // Take the maximum of either starting fresh with current element
    // or extending previous subarray
    currentSum = nums[i] + (currentSum > 0 ? currentSum : 0);

    // Update maxSum if we found a better subarray
    maxSum = currentSum > maxSum ? currentSum : maxSum;
  }

  return maxSum;
}

// ============== Dynamic Programming Approach ==============
// (Included for comparison, though the greedy approach is simpler)
int maxSubArrayDP(List<int> nums) {
  if (nums.isEmpty) {
    return 0;
  }

  // dp[i] represents the maximum subarray sum ending at index i
  List<int> dp = List<int>.filled(nums.length, 0);

  // Base case
  dp[0] = nums[0];
  int maxSum = dp[0];

  // Fill dp array
  for (int i = 1; i < nums.length; i++) {
    dp[i] = nums[i] + (dp[i - 1] > 0 ? dp[i - 1] : 0);
    maxSum = maxSum > dp[i] ? maxSum : dp[i];
  }

  return maxSum;
}

// ============== Divide and Conquer Approach ==============
// Time Complexity: O(n log n)
// Space Complexity: O(log n) due to recursion stack
int maxSubArrayDivideConquer(List<int> nums) {
  return _maxSubArrayHelper(nums, 0, nums.length - 1);
}

int _maxSubArrayHelper(List<int> nums, int left, int right) {
  if (left == right) {
    return nums[left];
  }

  int mid = left + (right - left) ~/ 2;

  // Max subarray in left half
  int leftMax = _maxSubArrayHelper(nums, left, mid);

  // Max subarray in right half
  int rightMax = _maxSubArrayHelper(nums, mid + 1, right);

  // Max subarray crossing the midpoint
  int crossMax = _findMaxCrossingSubarray(nums, left, mid, right);

  // Return the maximum of the three
  return [leftMax, rightMax, crossMax].reduce((a, b) => a > b ? a : b);
}

int _findMaxCrossingSubarray(List<int> nums, int left, int mid, int right) {
  // Find maximum sum starting from mid and going left
  int leftSum = 0;
  int maxLeftSum = -999999; // Using a large negative number instead of infinity

  for (int i = mid; i >= left; i--) {
    leftSum += nums[i];
    maxLeftSum = maxLeftSum > leftSum ? maxLeftSum : leftSum;
  }

  // Find maximum sum starting from mid+1 and going right
  int rightSum = 0;
  int maxRightSum =
      -999999; // Using a large negative number instead of infinity

  for (int i = mid + 1; i <= right; i++) {
    rightSum += nums[i];
    maxRightSum = maxRightSum > rightSum ? maxRightSum : rightSum;
  }

  // Return the sum of the two halves
  return maxLeftSum + maxRightSum;
}

void main() {
  List<int> nums1 = [-2, 1, -3, 4, -1, 2, 1, -5, 4];
  print(
    'Maximum subarray sum for $nums1: ${maxSubArray(nums1)}',
  ); // Expected: 6

  List<int> nums2 = [1];
  print(
    'Maximum subarray sum for $nums2: ${maxSubArray(nums2)}',
  ); // Expected: 1

  List<int> nums3 = [5, 4, -1, 7, 8];
  print(
    'Maximum subarray sum for $nums3: ${maxSubArray(nums3)}',
  ); // Expected: 23

  // Edge cases
  List<int> nums4 = [-1];
  print(
    'Maximum subarray sum for $nums4: ${maxSubArray(nums4)}',
  ); // Expected: -1

  List<int> nums5 = [-2, -3, -1, -5];
  print(
    'Maximum subarray sum for $nums5: ${maxSubArray(nums5)}',
  ); // Expected: -1

  // Compare with other implementations
  print('\nComparison with alternative implementations:');
  print('Greedy: ${maxSubArray(nums1)}');
  print('Cleaner: ${maxSubArrayCleaner(nums1)}');
  print('Dynamic Programming: ${maxSubArrayDP(nums1)}');
  print('Divide and Conquer: ${maxSubArrayDivideConquer(nums1)}');
}

// This problem can be solved with multiple approaches, but the greedy approach
// (Kadane's algorithm) provides the most elegant and efficient solution.
// The key insight is that at each position, we have two choices:
// 1. Start a new subarray from the current element
// 2. Extend the existing subarray by adding the current element
// The greedy choice is to take the maximum of these two options.
