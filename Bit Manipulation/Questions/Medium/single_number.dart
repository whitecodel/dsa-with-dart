// Bit Manipulation: Single Number
//
// Problem: Given a non-empty array of integers where every element appears twice
// except for one, find that single number.
//
// Example:
// Input: nums = [2, 2, 1]
// Output: 1
//
// Input: nums = [4, 1, 2, 1, 2]
// Output: 4
//
// Your solution should have linear time complexity and use constant extra space.
//
// This problem demonstrates a key application of XOR operations in bit manipulation.

// O(n) solution using XOR bit manipulation
int singleNumber(List<int> nums) {
  // Initialize result with 0 (XOR with 0 leaves the number unchanged)
  int result = 0;

  // XOR all numbers in the array
  for (int num in nums) {
    result ^= num;
  }

  // The properties of XOR ensure that:
  // 1. XOR is commutative and associative: a ^ b = b ^ a
  // 2. XOR of a number with itself is 0: a ^ a = 0
  // 3. XOR of a number with 0 is the number itself: a ^ 0 = a

  // So, all paired numbers will cancel out (become 0),
  // and only the single number will remain
  return result;
}

// Test function
void main() {
  // Test cases
  List<int> nums1 = [2, 2, 1];
  List<int> nums2 = [4, 1, 2, 1, 2];
  List<int> nums3 = [1, 3, 1, 3, 5, 6, 6];

  print('Input: $nums1');
  print('Output: ${singleNumber(nums1)}');

  print('\nInput: $nums2');
  print('Output: ${singleNumber(nums2)}');

  print('\nInput: $nums3');
  print('Output: ${singleNumber(nums3)}');

  // Detailed explanation
  print('\nDetailed explanation for [4, 1, 2, 1, 2]:');
  print('Start with result = 0');
  print('result ^ 4 = 0 ^ 4 = 4');
  print('result ^ 1 = 4 ^ 1 = 5');
  print('result ^ 2 = 5 ^ 2 = 7');
  print('result ^ 1 = 7 ^ 1 = 6 (1 cancels out with previous 1)');
  print('result ^ 2 = 6 ^ 2 = 4 (2 cancels out with previous 2)');
  print('Final result = 4');
}

/* Execution Trace:
1. singleNumber([4, 1, 2, 1, 2]) is called:
   - Initialize result = 0
   
   - Loop through nums:
     - result ^= 4  // result = 0 ^ 4 = 4
     - result ^= 1  // result = 4 ^ 1 = 5
     - result ^= 2  // result = 5 ^ 2 = 7
     - result ^= 1  // result = 7 ^ 1 = 6 (1 cancels out)
     - result ^= 2  // result = 6 ^ 2 = 4 (2 cancels out)
   
   - Return result = 4

2. Let's see the bit representations to understand better:
   - 0 ^ 4: 000 ^ 100 = 100 (4)
   - 4 ^ 1: 100 ^ 001 = 101 (5)
   - 5 ^ 2: 101 ^ 010 = 111 (7)
   - 7 ^ 1: 111 ^ 001 = 110 (6)
   - 6 ^ 2: 110 ^ 010 = 100 (4)

Output:
Input: [2, 2, 1]
Output: 1

Input: [4, 1, 2, 1, 2]
Output: 4

Input: [1, 3, 1, 3, 5, 6, 6]
Output: 5

Detailed explanation for [4, 1, 2, 1, 2]:
Start with result = 0
result ^ 4 = 0 ^ 4 = 4
result ^ 1 = 4 ^ 1 = 5
result ^ 2 = 5 ^ 2 = 7
result ^ 1 = 7 ^ 1 = 6 (1 cancels out with previous 1)
result ^ 2 = 6 ^ 2 = 4 (2 cancels out with previous 2)
Final result = 4
*/
