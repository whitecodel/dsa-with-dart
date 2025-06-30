// Prefix Sum: Subarray Sum Equals K
//
// Problem: Given an array of integers and an integer k, find the total number of
// subarrays whose sum equals k.
//
// Example:
// Input: nums = [1, 1, 1], k = 2
// Output: 2
// Explanation: There are two subarrays with sum equals to 2: [1, 1] and [1, 1]
//
// This problem demonstrates how prefix sums can be combined with a hash map
// to efficiently solve subarray sum problems.

// Function to find the number of subarrays with sum equal to k
// Time complexity: O(n), Space complexity: O(n)
int subarraySum(List<int> nums, int k) {
  // Map to store prefix sum frequencies
  // Key: prefix sum, Value: number of occurrences
  Map<int, int> prefixSumCount = {0: 1}; // Initialize with 0 sum occurring once

  int currentSum = 0; // Running sum
  int count = 0; // Result: count of subarrays with sum k

  for (int i = 0; i < nums.length; i++) {
    // Update running sum
    currentSum += nums[i];

    // Check if (currentSum - k) exists in the map
    // If it does, it means there are subarrays ending at current index with sum k
    int complement = currentSum - k;
    if (prefixSumCount.containsKey(complement)) {
      count += prefixSumCount[complement]!;
    }

    // Update the frequency of current sum
    prefixSumCount[currentSum] = (prefixSumCount[currentSum] ?? 0) + 1;
  }

  return count;
}

// Test function
void main() {
  // Test cases
  List<int> nums1 = [1, 1, 1];
  int k1 = 2;

  List<int> nums2 = [1, 2, 3];
  int k2 = 3;

  List<int> nums3 = [3, 4, 7, 2, -3, 1, 4, 2];
  int k3 = 7;

  print('Input: nums = $nums1, k = $k1');
  print('Output: ${subarraySum(nums1, k1)}');

  print('\nInput: nums = $nums2, k = $k2');
  print('Output: ${subarraySum(nums2, k2)}');

  print('\nInput: nums = $nums3, k = $k3');
  print('Output: ${subarraySum(nums3, k3)}');

  // Detailed explanation
  print('\nDetailed explanation for [1, 1, 1] with k = 2:');
  print('Initialize prefixSumCount = {0: 1}, currentSum = 0, count = 0');

  print('\nIteration 1 (i = 0, nums[0] = 1):');
  print('  currentSum = 0 + 1 = 1');
  print('  complement = currentSum - k = 1 - 2 = -1');
  print('  -1 is not in prefixSumCount, so no subarrays found yet');
  print('  Update prefixSumCount = {0: 1, 1: 1}');

  print('\nIteration 2 (i = 1, nums[1] = 1):');
  print('  currentSum = 1 + 1 = 2');
  print('  complement = currentSum - k = 2 - 2 = 0');
  print('  0 is in prefixSumCount with count 1, so count = 0 + 1 = 1');
  print('  Update prefixSumCount = {0: 1, 1: 1, 2: 1}');

  print('\nIteration 3 (i = 2, nums[2] = 1):');
  print('  currentSum = 2 + 1 = 3');
  print('  complement = currentSum - k = 3 - 2 = 1');
  print('  1 is in prefixSumCount with count 1, so count = 1 + 1 = 2');
  print('  Update prefixSumCount = {0: 1, 1: 1, 2: 1, 3: 1}');

  print('\nFinal result: count = 2');
}

/* Execution Trace:
1. subarraySum([1, 1, 1], 2) is called:
   - Initialize prefixSumCount = {0: 1}, currentSum = 0, count = 0
   
   - Loop through nums:
     - i = 0 (nums[0] = 1):
       - currentSum = 0 + 1 = 1
       - complement = 1 - 2 = -1
       - -1 is not in prefixSumCount, so no update to count
       - Update prefixSumCount[1] = 1, prefixSumCount = {0: 1, 1: 1}
     
     - i = 1 (nums[1] = 1):
       - currentSum = 1 + 1 = 2
       - complement = 2 - 2 = 0
       - 0 is in prefixSumCount with value 1
       - count = 0 + 1 = 1
       - Update prefixSumCount[2] = 1, prefixSumCount = {0: 1, 1: 1, 2: 1}
     
     - i = 2 (nums[2] = 1):
       - currentSum = 2 + 1 = 3
       - complement = 3 - 2 = 1
       - 1 is in prefixSumCount with value 1
       - count = 1 + 1 = 2
       - Update prefixSumCount[3] = 1, prefixSumCount = {0: 1, 1: 1, 2: 1, 3: 1}
   
   - Return count = 2

2. The two subarrays with sum 2 are:
   - nums[0...1] = [1, 1] (indices 0 to 1)
   - nums[1...2] = [1, 1] (indices 1 to 2)

Output:
Input: nums = [1, 1, 1], k = 2
Output: 2

Input: nums = [1, 2, 3], k = 3
Output: 2

Input: nums = [3, 4, 7, 2, -3, 1, 4, 2], k = 7
Output: 4

Detailed explanation for [1, 1, 1] with k = 2:
Initialize prefixSumCount = {0: 1}, currentSum = 0, count = 0

Iteration 1 (i = 0, nums[0] = 1):
  currentSum = 0 + 1 = 1
  complement = currentSum - k = 1 - 2 = -1
  -1 is not in prefixSumCount, so no subarrays found yet
  Update prefixSumCount = {0: 1, 1: 1}

Iteration 2 (i = 1, nums[1] = 1):
  currentSum = 1 + 1 = 2
  complement = currentSum - k = 2 - 2 = 0
  0 is in prefixSumCount with count 1, so count = 0 + 1 = 1
  Update prefixSumCount = {0: 1, 1: 1, 2: 1}

Iteration 3 (i = 2, nums[2] = 1):
  currentSum = 2 + 1 = 3
  complement = currentSum - k = 3 - 2 = 1
  1 is in prefixSumCount with count 1, so count = 1 + 1 = 2
  Update prefixSumCount = {0: 1, 1: 1, 2: 1, 3: 1}

Final result: count = 2
*/
