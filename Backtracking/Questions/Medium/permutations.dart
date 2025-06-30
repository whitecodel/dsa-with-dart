// Permutations
// LeetCode 46: Permutations

/*
Problem Statement:
Given an array nums of distinct integers, return all possible permutations.
You can return the answer in any order.

Example 1:
Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

Example 2:
Input: nums = [0,1]
Output: [[0,1],[1,0]]

Example 3:
Input: nums = [1]
Output: [[1]]
*/

// Time Complexity: O(n * n!) where n is the length of the input array
// - We have n! permutations
// - Each permutation takes O(n) time to construct
// Space Complexity: O(n * n!) for storing all permutations

List<List<int>> permute(List<int> nums) {
  // Step 1: Initialize the result list to store all permutations
  List<List<int>> result = [];

  // Step 2: Call the backtracking helper function
  backtrack(nums, [], result, List<bool>.filled(nums.length, false));

  return result;
}

// Backtracking helper function
// nums: The original array
// current: The current permutation being built
// result: List to store all valid permutations
// used: Tracks which elements have been used in the current permutation
void backtrack(
  List<int> nums,
  List<int> current,
  List<List<int>> result,
  List<bool> used,
) {
  // Step 3: Base case - if current permutation is complete
  if (current.length == nums.length) {
    // Add a copy of the current permutation to the result
    result.add(List<int>.from(current));

    // Debug: Print when a complete permutation is found
    // print('Found permutation: $current');

    return;
  }

  // Step 4: Try all possible next elements
  for (int i = 0; i < nums.length; i++) {
    // Skip if the element is already used in the current permutation
    if (used[i]) {
      continue;
    }

    // Debug: Print current state before adding a new element
    // print('Current: $current, Adding: ${nums[i]}');

    // Step 5: Add the current element to the permutation
    current.add(nums[i]);
    used[i] = true;

    // Step 6: Recursive call to continue building the permutation
    backtrack(nums, current, result, used);

    // Step 7: Backtrack - remove the last added element to try other possibilities
    current.removeLast();
    used[i] = false;

    // Debug: Print current state after backtracking
    // print('Backtracked: $current');
  }
}

/*
Execution trace for permute([1, 2, 3]):

1. Initialize:
   - result = []
   - Start with backtrack([1,2,3], [], result, [false, false, false])

2. First recursive call: current = []
   - Try i = 0 (value 1)
     - Add 1 to current => [1]
     - Mark used[0] = true => [true, false, false]
     - Call backtrack([1,2,3], [1], result, [true, false, false])
   
3. Second recursive call: current = [1]
   - Try i = 1 (value 2)
     - Add 2 to current => [1, 2]
     - Mark used[1] = true => [true, true, false]
     - Call backtrack([1,2,3], [1, 2], result, [true, true, false])
   
4. Third recursive call: current = [1, 2]
   - Try i = 2 (value 3)
     - Add 3 to current => [1, 2, 3]
     - Mark used[2] = true => [true, true, true]
     - Call backtrack([1,2,3], [1, 2, 3], result, [true, true, true])
   
5. Fourth recursive call: current = [1, 2, 3]
   - Base case: current.length == nums.length (3 == 3)
   - Add [1, 2, 3] to result => result = [[1, 2, 3]]
   - Return
   
6. Back to third call: current = [1, 2, 3]
   - Backtrack: Remove 3 => current = [1, 2]
   - Mark used[2] = false => [true, true, false]
   - End of loop, return
   
7. Back to second call: current = [1, 2]
   - Backtrack: Remove 2 => current = [1]
   - Mark used[1] = false => [true, false, false]
   - Try i = 2 (value 3)
     - Add 3 to current => [1, 3]
     - Mark used[2] = true => [true, false, true]
     - Call backtrack([1,2,3], [1, 3], result, [true, false, true])

8. Continue this pattern, trying all possibilities...

9. Eventually, all permutations are generated:
   - [1, 2, 3]
   - [1, 3, 2]
   - [2, 1, 3]
   - [2, 3, 1]
   - [3, 1, 2]
   - [3, 2, 1]

10. Final result = [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
*/

// Alternate implementation without the used array (using element swapping)
List<List<int>> permuteAlternate(List<int> nums) {
  List<List<int>> result = [];
  permuteHelper(0, nums, result);
  return result;
}

void permuteHelper(int start, List<int> nums, List<List<int>> result) {
  // Base case: If we've fixed all positions
  if (start == nums.length) {
    result.add(List<int>.from(nums));
    return;
  }

  // Try all possible elements at the current position
  for (int i = start; i < nums.length; i++) {
    // Swap elements to fix the current position
    swap(nums, start, i);

    // Recursively generate permutations for the remaining positions
    permuteHelper(start + 1, nums, result);

    // Backtrack: Restore the original array
    swap(nums, start, i);
  }
}

// Helper function to swap elements in a list
void swap(List<int> nums, int i, int j) {
  if (i != j) {
    int temp = nums[i];
    nums[i] = nums[j];
    nums[j] = temp;
  }
}

void main() {
  List<int> nums1 = [1, 2, 3];
  print('Permutations of $nums1:');
  print(permute(nums1));

  List<int> nums2 = [0, 1];
  print('\nPermutations of $nums2:');
  print(permute(nums2));

  List<int> nums3 = [1];
  print('\nPermutations of $nums3:');
  print(permute(nums3));

  // Verify the alternate implementation
  print('\nUsing alternate implementation:');
  print('Permutations of $nums1:');
  print(permuteAlternate(nums1));

  // Benchmark larger input
  List<int> nums4 = [1, 2, 3, 4];
  print('\nNumber of permutations for $nums4: ${factorial(nums4.length)}');

  Stopwatch stopwatch = Stopwatch()..start();
  List<List<int>> perms = permute(nums4);
  stopwatch.stop();
  print(
    'Generated ${perms.length} permutations in ${stopwatch.elapsedMilliseconds}ms',
  );
}

// Helper function to calculate factorial
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}
