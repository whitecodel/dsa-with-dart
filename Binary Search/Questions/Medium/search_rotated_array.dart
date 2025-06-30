// Search in Rotated Sorted Array
// LeetCode 33: Search in Rotated Sorted Array

/*
Problem Statement:
There is an integer array nums sorted in ascending order (with distinct values).

Prior to being passed to your function, nums is possibly rotated at an unknown 
pivot index k (1 <= k < nums.length) such that the resulting array is 
[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed).

For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

Given the array nums after the possible rotation and an integer target, return the index 
of target if it is in nums, or -1 if it is not in nums.

Example 1:
Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4

Example 2:
Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1

Example 3:
Input: nums = [1], target = 0
Output: -1
*/

// Time Complexity: O(log n) where n is the length of the array
// Space Complexity: O(1) as we only use a few variables

int search(List<int> nums, int target) {
  // Step 1: Handle empty array
  if (nums.isEmpty) {
    return -1;
  }

  // Step 2: Initialize binary search pointers
  int left = 0;
  int right = nums.length - 1;

  // Step 3: Apply modified binary search
  while (left <= right) {
    // Calculate middle index
    int mid = left + (right - left) ~/ 2;

    // Debug: Show current search range
    // print('Left: $left, Mid: $mid, Right: $right, Value at mid: ${nums[mid]}');

    // Step 4: Check if middle element is the target
    if (nums[mid] == target) {
      return mid; // Target found
    }

    // Step 5: Determine which half is sorted and narrow search space

    // Check if left half is sorted
    if (nums[left] <= nums[mid]) {
      // Debug: Left half is sorted
      // print('Left half is sorted [${nums[left]}-${nums[mid]}]');

      // Check if target is in the left sorted half
      if (nums[left] <= target && target < nums[mid]) {
        // Target is in the left sorted half
        // print('Target $target is in left sorted half');
        right = mid - 1;
      } else {
        // Target is in the right half (may be unsorted)
        // print('Target $target is NOT in left sorted half');
        left = mid + 1;
      }
    }
    // Right half must be sorted
    else {
      // Debug: Right half is sorted
      // print('Right half is sorted [${nums[mid]}-${nums[right]}]');

      // Check if target is in the right sorted half
      if (nums[mid] < target && target <= nums[right]) {
        // Target is in the right sorted half
        // print('Target $target is in right sorted half');
        left = mid + 1;
      } else {
        // Target is in the left half (may be unsorted)
        // print('Target $target is NOT in right sorted half');
        right = mid - 1;
      }
    }
  }

  // Step 6: Target not found
  return -1;
}

/*
Execution trace for [4,5,6,7,0,1,2], target = 0:

1. Initialize:
   - left = 0, right = 6
   - Array: [4,5,6,7,0,1,2]

2. Iteration 1:
   - mid = (0 + 6) ~/ 2 = 3
   - nums[mid] = 7, target = 0, not equal
   - Check which half is sorted: nums[left] = 4 <= nums[mid] = 7
     - Left half [4,5,6,7] is sorted
     - Is target in left half? 4 <= 0 <= 7? No
     - Search right half: left = mid + 1 = 4

3. Iteration 2:
   - left = 4, right = 6
   - mid = (4 + 6) ~/ 2 = 5
   - nums[mid] = 1, target = 0, not equal
   - Check which half is sorted: nums[left] = 0 <= nums[mid] = 1
     - Left half [0,1] is sorted
     - Is target in left half? 0 <= 0 < 1? Yes
     - Search left half: right = mid - 1 = 4

4. Iteration 3:
   - left = 4, right = 4
   - mid = (4 + 4) ~/ 2 = 4
   - nums[mid] = 0, target = 0, they're equal!
   - Return mid = 4

Result: 4
*/

void main() {
  List<int> nums1 = [4, 5, 6, 7, 0, 1, 2];
  int target1 = 0;

  print(
    'Index of $target1 in $nums1: ${search(nums1, target1)}',
  ); // Expected: 4

  List<int> nums2 = [4, 5, 6, 7, 0, 1, 2];
  int target2 = 3;

  print(
    'Index of $target2 in $nums2: ${search(nums2, target2)}',
  ); // Expected: -1

  List<int> nums3 = [1];
  int target3 = 0;

  print(
    'Index of $target3 in $nums3: ${search(nums3, target3)}',
  ); // Expected: -1

  // Additional test cases
  List<int> nums4 = [1, 3];
  int target4 = 3;

  print(
    'Index of $target4 in $nums4: ${search(nums4, target4)}',
  ); // Expected: 1

  List<int> nums5 = [3, 1];
  int target5 = 3;

  print(
    'Index of $target5 in $nums5: ${search(nums5, target5)}',
  ); // Expected: 0

  List<int> nums6 = [];
  int target6 = 5;

  print(
    'Index of $target6 in $nums6: ${search(nums6, target6)}',
  ); // Expected: -1
}
