// Prefix Sum: Range Sum Query
//
// Problem: Given an array of integers, implement a class to efficiently answer
// multiple queries about the sum of elements between indices i and j.
//
// Example:
// Input: nums = [-2, 0, 3, -5, 2, -1]
// Operations:
//   sumRange(0, 2) -> 1 (-2 + 0 + 3)
//   sumRange(2, 5) -> -1 (3 + (-5) + 2 + (-1))
//   sumRange(0, 5) -> -3 (sum of all elements)
//
// This problem demonstrates the core application of the prefix sum technique.

class NumArray {
  // Store prefix sums to allow O(1) range sum queries
  List<int> prefixSum;

  // Constructor pre-computes the prefix sum array
  NumArray(List<int> nums) : prefixSum = List<int>.filled(nums.length + 1, 0) {
    // Calculate prefix sum for each position
    // Note: we use 1-indexed prefixSum for cleaner code
    // prefixSum[0] remains 0, and prefixSum[i] stores sum of elements nums[0...i-1]
    for (int i = 0; i < nums.length; i++) {
      prefixSum[i + 1] = prefixSum[i] + nums[i];
    }
  }

  // Returns the sum of elements in the range [i, j] inclusive
  // Time complexity: O(1)
  int sumRange(int i, int j) {
    // To compute sum from index i to j, we subtract
    // the prefix sum up to index i-1 from prefix sum up to index j
    return prefixSum[j + 1] - prefixSum[i];
  }
}

// Test function
void main() {
  // Test case
  List<int> nums = [-2, 0, 3, -5, 2, -1];
  NumArray numArray = NumArray(nums);

  // Test queries
  print('Input array: $nums');
  print('sumRange(0, 2) = ${numArray.sumRange(0, 2)}');
  print('sumRange(2, 5) = ${numArray.sumRange(2, 5)}');
  print('sumRange(0, 5) = ${numArray.sumRange(0, 5)}');

  // Detailed explanation
  print('\nDetailed explanation:');
  print('Prefix Sum Array: ${numArray.prefixSum}');
  print('For sumRange(0, 2):');
  print(
    '  prefixSum[3] - prefixSum[0] = ${numArray.prefixSum[3]} - ${numArray.prefixSum[0]} = ${numArray.prefixSum[3] - numArray.prefixSum[0]}',
  );
  print('For sumRange(2, 5):');
  print(
    '  prefixSum[6] - prefixSum[2] = ${numArray.prefixSum[6]} - ${numArray.prefixSum[2]} = ${numArray.prefixSum[6] - numArray.prefixSum[2]}',
  );
  print('For sumRange(0, 5):');
  print(
    '  prefixSum[6] - prefixSum[0] = ${numArray.prefixSum[6]} - ${numArray.prefixSum[0]} = ${numArray.prefixSum[6] - numArray.prefixSum[0]}',
  );
}

/* Execution Trace:
1. Initialize NumArray with [-2, 0, 3, -5, 2, -1]:
   - Create prefixSum array of length 7 (nums.length + 1), initially all 0's: [0, 0, 0, 0, 0, 0, 0]
   - Calculate prefix sums:
     - prefixSum[1] = prefixSum[0] + nums[0] = 0 + (-2) = -2
     - prefixSum[2] = prefixSum[1] + nums[1] = -2 + 0 = -2
     - prefixSum[3] = prefixSum[2] + nums[2] = -2 + 3 = 1
     - prefixSum[4] = prefixSum[3] + nums[3] = 1 + (-5) = -4
     - prefixSum[5] = prefixSum[4] + nums[4] = -4 + 2 = -2
     - prefixSum[6] = prefixSum[5] + nums[5] = -2 + (-1) = -3
   - Final prefixSum: [0, -2, -2, 1, -4, -2, -3]

2. sumRange(0, 2):
   - Return prefixSum[3] - prefixSum[0] = 1 - 0 = 1
   - This gives the sum of elements at indices 0, 1, and 2: -2 + 0 + 3 = 1

3. sumRange(2, 5):
   - Return prefixSum[6] - prefixSum[2] = -3 - (-2) = -1
   - This gives the sum of elements at indices 2, 3, 4, and 5: 3 + (-5) + 2 + (-1) = -1

4. sumRange(0, 5):
   - Return prefixSum[6] - prefixSum[0] = -3 - 0 = -3
   - This gives the sum of all elements in the array: -2 + 0 + 3 + (-5) + 2 + (-1) = -3

Output:
Input array: [-2, 0, 3, -5, 2, -1]
sumRange(0, 2) = 1
sumRange(2, 5) = -1
sumRange(0, 5) = -3

Detailed explanation:
Prefix Sum Array: [0, -2, -2, 1, -4, -2, -3]
For sumRange(0, 2):
  prefixSum[3] - prefixSum[0] = 1 - 0 = 1
For sumRange(2, 5):
  prefixSum[6] - prefixSum[2] = -3 - (-2) = -1
For sumRange(0, 5):
  prefixSum[6] - prefixSum[0] = -3 - 0 = -3
*/
