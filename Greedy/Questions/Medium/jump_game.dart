// Jump Game
// Problem: You are given an integer array nums. You are initially positioned at the array's
// first index, and each element in the array represents your maximum jump length at that position.
// Return true if you can reach the last index, or false otherwise.
//
// Example:
//   Input: nums = [2,3,1,1,4]
//   Output: true
//   Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
//
//   Input: nums = [3,2,1,0,4]
//   Output: false
//   Explanation: You will always arrive at index 3, but no further.

// Greedy approach to solve the Jump Game problem
//
// Time Complexity: O(n) - One pass through the array
// Space Complexity: O(1) - Constant extra space
bool canJump(List<int> nums) {
  // Edge cases
  if (nums.isEmpty) return false;
  if (nums.length == 1) return true; // Already at the last position

  // The farthest position we can reach
  int maxReach = 0;

  // Iterate through the array
  for (int i = 0; i < nums.length; i++) {
    // If current position is beyond our reach, we can't proceed
    if (i > maxReach) return false;

    // Update the farthest position we can reach
    maxReach = max(maxReach, i + nums[i]);

    // If we can already reach the end, return true
    if (maxReach >= nums.length - 1) return true;
  }

  // If we've gone through the entire array and can't reach the end
  return false;
}

// Helper function to find maximum of two values
int max(int a, int b) {
  return a > b ? a : b;
}

// Explanation:
// The greedy approach works by tracking the farthest index we can reach at each step.
// - We start at index 0 and initialize maxReach = 0
// - At each position i, we update maxReach if i + nums[i] allows us to jump further
// - If at any point i > maxReach, we know we can't proceed further
// - If maxReach >= last index, we can reach the end
//
// Execution trace for [2,3,1,1,4]:
// - Initialize maxReach = 0
// - i = 0: nums[0] = 2, maxReach = max(0, 0+2) = 2
// - i = 1: nums[1] = 3, maxReach = max(2, 1+3) = 4
// - maxReach = 4 >= nums.length-1 = 4, return true
//
// Execution trace for [3,2,1,0,4]:
// - Initialize maxReach = 0
// - i = 0: nums[0] = 3, maxReach = max(0, 0+3) = 3
// - i = 1: nums[1] = 2, maxReach = max(3, 1+2) = 3
// - i = 2: nums[2] = 1, maxReach = max(3, 2+1) = 3
// - i = 3: nums[3] = 0, maxReach = max(3, 3+0) = 3
// - i = 4: i > maxReach, return false

void main() {
  // Test cases
  List<List<int>> testCases = [
    [2, 3, 1, 1, 4], // Can reach the end
    [3, 2, 1, 0, 4], // Cannot reach the end due to 0
    [0], // Single element (already at the end)
    [1], // Single element (already at the end)
    [5, 9, 3, 2, 1, 0, 2, 3, 3, 1, 0, 0], // Can reach end
    [1, 1, 1, 1], // Just enough jumps
    [3, 0, 0, 0], // Can jump over all zeros
    [2, 0, 0], // Can jump exactly to end
    [1, 0, 1, 0], // Can't jump over second zero
  ];

  // Expected outputs
  List<bool> expected = [
    true,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    false,
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    var nums = testCases[i];
    print('Test case ${i + 1}: $nums');

    bool result = canJump(nums);
    print('Result: $result');
    print('Expected: ${expected[i]}');
    print(result == expected[i] ? 'PASS' : 'FAIL');
    print('---');
  }
}
