// 3Sum
// Problem: Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]]
// such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
// Notice that the solution set must not contain duplicate triplets.
//
// Example:
//   Input: nums = [-1,0,1,2,-1,-4]
//   Output: [[-1,-1,2],[-1,0,1]]
//   Explanation:
//   nums[0] + nums[2] + nums[4] = (-1) + 1 + (-1) = -1 + 0 = -1 != 0
//   nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0
//   nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0
//
//   Input: nums = []
//   Output: []
//
//   Input: nums = [0]
//   Output: []

// Two pointers solution for the 3Sum problem
//
// Time Complexity: O(n²) where n is the length of the array
// Space Complexity: O(1) excluding the output array
List<List<int>> threeSum(List<int> nums) {
  // Result list to store all valid triplets
  List<List<int>> result = [];

  // If array has fewer than 3 elements, no solution possible
  if (nums.length < 3) {
    return result;
  }

  // Sort the array to make the two-pointer approach work
  nums.sort();

  // For each element as a potential first number in the triplet
  for (int i = 0; i < nums.length - 2; i++) {
    // Skip duplicates for the first number to avoid duplicate triplets
    if (i > 0 && nums[i] == nums[i - 1]) {
      continue;
    }

    // If the smallest element is already positive, sum can't be 0
    if (nums[i] > 0) {
      break;
    }

    // Use two pointers approach to find the other two numbers
    int left = i + 1;
    int right = nums.length - 1;

    while (left < right) {
      int sum = nums[i] + nums[left] + nums[right];

      if (sum < 0) {
        // Sum is too small, move left pointer to increase sum
        left++;
      } else if (sum > 0) {
        // Sum is too large, move right pointer to decrease sum
        right--;
      } else {
        // Found a triplet that sums to 0
        result.add([nums[i], nums[left], nums[right]]);

        // Skip duplicates for the second number
        while (left < right && nums[left] == nums[left + 1]) {
          left++;
        }

        // Skip duplicates for the third number
        while (left < right && nums[right] == nums[right - 1]) {
          right--;
        }

        // Move both pointers to find other potential solutions
        left++;
        right--;
      }
    }
  }

  return result;
}

// Execution trace for [-1,0,1,2,-1,-4]:
// 1. Sort the array: [-4,-1,-1,0,1,2]
//
// 2. Iteration i=0, nums[0]=-4:
//    - left=1, right=5: sum=(-4)+(-1)+2=-3 < 0, left=2
//    - left=2, right=5: sum=(-4)+(-1)+2=-3 < 0, left=3
//    - left=3, right=5: sum=(-4)+0+2=-2 < 0, left=4
//    - left=4, right=5: sum=(-4)+1+2=-1 < 0, left=5
//    - left=5, right=5: left >= right, exit loop
//
// 3. Iteration i=1, nums[1]=-1:
//    - left=2, right=5: sum=(-1)+(-1)+2=0, add [-1,-1,2] to result
//    - Skip duplicate for third number (none)
//    - Skip duplicate for second number (none)
//    - left=3, right=4: sum=(-1)+0+1=0, add [-1,0,1] to result
//    - Skip duplicate for third number (none)
//    - Skip duplicate for second number (none)
//    - left=4, right=3: left >= right, exit loop
//
// 4. Iteration i=2, nums[2]=-1:
//    - Skip iteration as nums[2] == nums[1]
//
// 5. Iteration i=3, nums[3]=0:
//    - left=4, right=5: sum=0+1+2=3 > 0, right=4
//    - left=4, right=4: left >= right, exit loop
//
// 6. Iteration i=4, nums[4]=1:
//    - nums[4] > 0, break loop
//
// 7. Result = [[-1,-1,2], [-1,0,1]]

void main() {
  // Test cases
  List<List<int>> testCases = [
    [-1, 0, 1, 2, -1, -4], // Standard case with solution
    [], // Empty array
    [0], // Single element
    [0, 0, 0], // All zeros
    [-2, 0, 0, 2, 2], // Duplicates
    [3, 0, -2, -1, 1, 2], // Multiple solutions
    [-1, 0, 1, 0], // Duplicate zeros
    [1, 2, -2, -1], // No solutions
  ];

  // Expected outputs
  List<List<List<int>>> expected = [
    [
      [-1, -1, 2],
      [-1, 0, 1],
    ],
    [],
    [],
    [
      [0, 0, 0],
    ],
    [
      [-2, 0, 2],
    ],
    [
      [-2, -1, 3],
      [-2, 0, 2],
      [-1, 0, 1],
    ],
    [
      [-1, 0, 1],
    ],
    [],
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    var nums = testCases[i];
    print('Test case ${i + 1}: $nums');

    List<List<int>> result = threeSum(nums);
    print('Result: $result');
    print('Expected: ${expected[i]}');

    // Simple check for equality (ignores order)
    bool isEquivalent = checkEquivalentSolutions(result, expected[i]);
    print(isEquivalent ? 'PASS' : 'FAIL');
    print('---');
  }
}

// Helper function to check if two lists of triplets are equivalent
// (i.e., contain the same triplets, regardless of order)
bool checkEquivalentSolutions(
  List<List<int>> actual,
  List<List<int>> expected,
) {
  if (actual.length != expected.length) return false;

  // Convert each triplet to a sorted string representation for comparison
  Set<String> actualSet = actual.map((list) {
    List<int> sorted = List<int>.from(list)..sort();
    return sorted.join(',');
  }).toSet();

  Set<String> expectedSet = expected.map((list) {
    List<int> sorted = List<int>.from(list)..sort();
    return sorted.join(',');
  }).toSet();

  return actualSet.length == expectedSet.length &&
      actualSet.every((element) => expectedSet.contains(element));
}
