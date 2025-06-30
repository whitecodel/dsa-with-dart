// Binary Search
// Problem: Given a sorted array of integers and a target value, return the index if the target is found.
// If not, return -1.
//
// Example:
//   Input: nums = [-1, 0, 3, 5, 9, 12], target = 9
//   Output: 4
//   Explanation: 9 exists in nums and its index is 4
//
//   Input: nums = [-1, 0, 3, 5, 9, 12], target = 2
//   Output: -1
//   Explanation: 2 does not exist in nums so return -1

// Binary Search Algorithm
//
// Time Complexity: O(log n) - Divides search space in half each iteration
// Space Complexity: O(1) - Uses constant extra space
int binarySearch(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;

  // Continue searching while the search space is valid
  while (left <= right) {
    // Calculate the middle index
    int mid = left + (right - left) ~/ 2;

    // Found the target
    if (nums[mid] == target) {
      return mid;
    }

    // Target is in the left half
    if (nums[mid] > target) {
      right = mid - 1;
    }
    // Target is in the right half
    else {
      left = mid + 1;
    }
  }

  // Target not found
  return -1;
}

// Execution trace for [-1, 0, 3, 5, 9, 12], target = 9:
// - Initialize left=0, right=5
// - Iteration 1: mid=2, nums[mid]=3, 3 < 9, so search right half by setting left=3
// - Iteration 2: mid=4, nums[mid]=9, 9 == 9, return 4
//
// Execution trace for [-1, 0, 3, 5, 9, 12], target = 2:
// - Initialize left=0, right=5
// - Iteration 1: mid=2, nums[mid]=3, 3 > 2, so search left half by setting right=1
// - Iteration 2: mid=0, nums[mid]=-1, -1 < 2, so search right half by setting left=1
// - Iteration 3: mid=1, nums[mid]=0, 0 < 2, so search right half by setting left=2
// - Now left=2, right=1, left > right, loop exits, return -1

void main() {
  // Test cases
  List<List<dynamic>> testCases = [
    [
      [-1, 0, 3, 5, 9, 12],
      9,
      4,
    ], // Target found at index 4
    [
      [-1, 0, 3, 5, 9, 12],
      2,
      -1,
    ], // Target not found
    [
      [1, 2, 3, 4, 5],
      1,
      0,
    ], // Target at beginning
    [
      [1, 2, 3, 4, 5],
      5,
      4,
    ], // Target at end
    [
      [1],
      1,
      0,
    ], // Single element array, target found
    [
      [1],
      2,
      -1,
    ], // Single element array, target not found
    [[], 1, -1], // Empty array
  ];

  for (int i = 0; i < testCases.length; i++) {
    // Properly convert dynamic list to a List<int> using map
    List<int> nums = (testCases[i][0] as List).map((e) => e as int).toList();
    int target = testCases[i][1] as int;
    int expected = testCases[i][2] as int;
    int result = binarySearch(nums, target);

    print('Test case ${i + 1}: nums = $nums, target = $target');
    print('Expected: $expected, Result: $result');
    print(result == expected ? 'PASS' : 'FAIL');
    print('---');
  }
}
