// Find the Duplicate Number
// Problem: Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.
// There is only one repeated number in nums, return this repeated number.
// You must solve the problem without modifying the array nums and using only constant extra space.
//
// Example:
//   Input: nums = [1,3,4,2,2]
//   Output: 2
//
//   Input: nums = [3,1,3,4,2]
//   Output: 3

// Fast & Slow Pointers (Floyd's Tortoise and Hare) solution to find duplicate number
//
// This problem can be viewed as finding the entrance to a cycle in a linked list.
// Where the array values represent pointers to the next index.
//
// Time Complexity: O(n) - We only need to traverse the array twice
// Space Complexity: O(1) - Only use two pointers regardless of input size
int findDuplicate(List<int> nums) {
  // Edge case: empty or single element array
  if (nums.isEmpty || nums.length <= 1) {
    throw ArgumentError("Array must contain at least two elements");
  }

  // Phase 1: Find the intersection point of the two pointers
  // This confirms there's a cycle and finds a point in the cycle
  int slow = nums[0];
  int fast = nums[0];

  do {
    slow = nums[slow]; // Move slow pointer one step
    fast = nums[nums[fast]]; // Move fast pointer two steps
  } while (slow != fast);

  // Phase 2: Find the entrance of the cycle (the duplicate number)
  // Reset slow to the start, and move both pointers at the same speed
  slow = nums[0];
  while (slow != fast) {
    slow = nums[slow];
    fast = nums[fast];
  }

  return slow;
}

// Explanation of the algorithm:
//
// This solution uses Floyd's Tortoise and Hare algorithm to find a cycle in a sequence.
// We treat the array as a linked list where the value at index i represents the next index to visit.
//
// Consider array [1,3,4,2,2]:
// Index: 0 1 2 3 4
// Value: 1 3 4 2 2
//
// Starting at index 0, the sequence would be:
// 0 → 1 → 3 → 2 → 4 → 2 → 4 → 2 → ... (cycle detected)
//
// The duplicate number (2) is the entrance to the cycle.
//
// Execution trace for [1,3,4,2,2]:
// - Initialize slow = nums[0] = 1, fast = nums[0] = 1
// - Iteration 1: slow = nums[1] = 3, fast = nums[nums[1]] = nums[3] = 2
// - Iteration 2: slow = nums[3] = 2, fast = nums[nums[2]] = nums[4] = 2
// - slow == fast, exit loop (intersection point is 2)
// - Reset slow = nums[0] = 1
// - Iteration 1: slow = nums[1] = 3, fast = nums[2] = 4
// - Iteration 2: slow = nums[3] = 2, fast = nums[4] = 2
// - slow == fast, return 2

void main() {
  // Test cases
  List<List<int>> testCases = [
    [1, 3, 4, 2, 2], // Duplicate is 2
    [3, 1, 3, 4, 2], // Duplicate is 3
    [2, 2, 2, 2, 2], // All elements are the same duplicate
    [1, 1, 2, 3, 4], // Duplicate at the beginning
    [1, 2, 3, 4, 4], // Duplicate at the end
    [4, 3, 1, 4, 2], // Duplicate in the middle
    [2, 5, 9, 6, 9, 3, 8, 9, 7, 1], // Larger array with duplicate 9
  ];

  // Expected outputs
  List<int> expected = [2, 3, 2, 1, 4, 4, 9];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    var nums = testCases[i];
    print('Test case ${i + 1}: $nums');

    int result = findDuplicate(nums);
    print('Result: $result');
    print('Expected: ${expected[i]}');
    print(result == expected[i] ? 'PASS' : 'FAIL');
    print('---');
  }
}
