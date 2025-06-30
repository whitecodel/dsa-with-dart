// Two Sum - Sorted Array
// LeetCode 167: Two Sum II - Input Array Is Sorted

/*
Problem Statement:
Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order,
find two numbers such that they add up to a specific target number.
Return the 1-indexed indices of the two numbers as an array [index1, index2].

Example:
Input: numbers = [2, 7, 11, 15], target = 9
Output: [1, 2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2.
*/

// Time Complexity: O(n) where n is the length of the array
// Space Complexity: O(1) as we only use two pointer variables

List<int> twoSum(List<int> numbers, int target) {
  // Step 1: Initialize two pointers - one at the beginning and one at the end
  int left = 0;
  int right = numbers.length - 1;

  // Step 2: Iterate until the pointers meet
  while (left < right) {
    // Step 3: Calculate current sum
    int currentSum = numbers[left] + numbers[right];

    // Debug: Current state
    // print('Checking indices: left=$left, right=$right, values: ${numbers[left]} + ${numbers[right]} = $currentSum');

    // Step 4: Compare current sum with target and adjust pointers
    if (currentSum == target) {
      // Found the pair, return their 1-indexed positions
      return [left + 1, right + 1];
    } else if (currentSum < target) {
      // If sum is too small, move the left pointer to increase the sum
      left++;
      // print('Sum too small, moving left pointer to ${left}');
    } else {
      // If sum is too large, move the right pointer to decrease the sum
      right--;
      // print('Sum too large, moving right pointer to ${right}');
    }
  }

  // Step 5: If no solution found, return an empty array (shouldn't happen given problem constraints)
  return [];
}

/*
Execution trace for example [2, 7, 11, 15] with target = 9:

1. Initialize:
   - left = 0, right = 3
   - numbers[left] = 2, numbers[right] = 15

2. Iteration 1:
   - currentSum = 2 + 15 = 17
   - 17 > 9 (target), so right--
   - left = 0, right = 2

3. Iteration 2:
   - currentSum = 2 + 11 = 13
   - 13 > 9 (target), so right--
   - left = 0, right = 1

4. Iteration 3:
   - currentSum = 2 + 7 = 9
   - 9 == 9 (target), we found our pair!
   - Return [1, 2] (1-indexed positions)

Result: [1, 2]
*/

void main() {
  List<int> numbers = [2, 7, 11, 15];
  int target = 9;

  List<int> result = twoSum(numbers, target);
  print(
    'Indices of the two numbers that add up to $target: $result',
  ); // Expected: [1, 2]

  // Additional test cases
  numbers = [2, 3, 4];
  target = 6;
  result = twoSum(numbers, target);
  print(
    'Indices of the two numbers that add up to $target: $result',
  ); // Expected: [1, 3]

  numbers = [-1, 0];
  target = -1;
  result = twoSum(numbers, target);
  print(
    'Indices of the two numbers that add up to $target: $result',
  ); // Expected: [1, 2]

  numbers = [1, 3, 4, 5, 7, 11];
  target = 9;
  result = twoSum(numbers, target);
  print(
    'Indices of the two numbers that add up to $target: $result',
  ); // Expected: [2, 4]
}
