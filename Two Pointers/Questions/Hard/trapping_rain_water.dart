// Two Pointers: Trapping Rain Water
//
// Problem: Given n non-negative integers representing an elevation map where the width
// of each bar is 1, compute how much water it can trap after raining.
//
// Example:
// Input: height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
// Output: 6
// Explanation: The elevation map is represented by the array [0,1,0,2,1,0,1,3,2,1,2,1].
// In this case, 6 units of rain water (shown in blue) are being trapped.
//
// This is a classic hard-level two pointers problem that requires careful
// tracking of left and right boundaries.

// Solution using two pointers approach - O(n) time, O(1) space
int trap(List<int> height) {
  if (height.isEmpty) return 0;

  int left = 0;
  int right = height.length - 1;
  int leftMax = height[left];
  int rightMax = height[right];
  int waterTrapped = 0;

  // Use two pointers to process the array
  while (left < right) {
    if (leftMax < rightMax) {
      // Move left pointer
      left++;

      // Update leftMax if current height is greater
      if (height[left] > leftMax) {
        leftMax = height[left];
      } else {
        // Accumulate trapped water
        waterTrapped += leftMax - height[left];
      }
    } else {
      // Move right pointer
      right--;

      // Update rightMax if current height is greater
      if (height[right] > rightMax) {
        rightMax = height[right];
      } else {
        // Accumulate trapped water
        waterTrapped += rightMax - height[right];
      }
    }
  }

  return waterTrapped;
}

// Alternative solution using dynamic programming - O(n) time, O(n) space
// This is easier to understand but uses more space
int trapDP(List<int> height) {
  if (height.isEmpty) return 0;

  int n = height.length;
  int waterTrapped = 0;

  // Arrays to store maximum height to the left and right of each position
  List<int> leftMax = List<int>.filled(n, 0);
  List<int> rightMax = List<int>.filled(n, 0);

  // Fill leftMax array
  leftMax[0] = height[0];
  for (int i = 1; i < n; i++) {
    leftMax[i] = max(leftMax[i - 1], height[i]);
  }

  // Fill rightMax array
  rightMax[n - 1] = height[n - 1];
  for (int i = n - 2; i >= 0; i--) {
    rightMax[i] = max(rightMax[i + 1], height[i]);
  }

  // Calculate trapped water at each position
  for (int i = 0; i < n; i++) {
    waterTrapped += min(leftMax[i], rightMax[i]) - height[i];
  }

  return waterTrapped;
}

// Helper function for max
int max(int a, int b) {
  return (a > b) ? a : b;
}

// Helper function for min
int min(int a, int b) {
  return (a < b) ? a : b;
}

// Test function
void main() {
  // Test cases
  List<int> heights1 = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1];
  List<int> heights2 = [4, 2, 0, 3, 2, 5];

  print('Input: heights = $heights1');
  print('Output: ${trap(heights1)}');
  print('Output (using DP): ${trapDP(heights1)}');

  print('\nInput: heights = $heights2');
  print('Output: ${trap(heights2)}');
  print('Output (using DP): ${trapDP(heights2)}');

  // Detailed explanation for the example
  print(
    '\nDetailed explanation for heights = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]:',
  );

  print('\nTwo Pointers Approach:');
  print(
    '1. Initialize: left = 0, right = 11, leftMax = 0, rightMax = 1, waterTrapped = 0',
  );
  print('2. Compare leftMax (0) < rightMax (1), move left pointer:');
  print('   - left = 1, height[1] = 1, update leftMax = 1');
  print('   - leftMax = 1, rightMax = 1');

  print('3. Compare leftMax (1) = rightMax (1), move right pointer:');
  print('   - right = 10, height[10] = 2, update rightMax = 2');
  print('   - leftMax = 1, rightMax = 2');

  print('4. Compare leftMax (1) < rightMax (2), move left pointer:');
  print('   - left = 2, height[2] = 0, leftMax = 1');
  print('   - Water trapped += leftMax - height[2] = 1 - 0 = 1');
  print('   - Total water trapped = 1');

  print('5. Continue this process...');
  print('   - Eventually, we will accumulate 6 units of water');

  print('\nDP Approach:');
  print('1. Calculate leftMax array:');
  print('   - leftMax = [0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3]');

  print('2. Calculate rightMax array:');
  print('   - rightMax = [3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1]');

  print('3. Calculate water trapped at each position:');
  print('   - Position 0: min(0, 3) - 0 = 0');
  print('   - Position 1: min(1, 3) - 1 = 0');
  print('   - Position 2: min(1, 3) - 0 = 1');
  print('   - Position 3: min(2, 3) - 2 = 0');
  print('   - Position 4: min(2, 3) - 1 = 1');
  print('   - Position 5: min(2, 3) - 0 = 2');
  print('   - Position 6: min(2, 3) - 1 = 1');
  print('   - Position 7: min(3, 3) - 3 = 0');
  print('   - Position 8: min(3, 2) - 2 = 0');
  print('   - Position 9: min(3, 2) - 1 = 1');
  print('   - Position 10: min(3, 2) - 2 = 0');
  print('   - Position 11: min(3, 1) - 1 = 0');
  print(
    '   - Total water trapped = 0 + 0 + 1 + 0 + 1 + 2 + 1 + 0 + 0 + 1 + 0 + 0 = 6',
  );
}

/* Execution Trace:
1. trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]) is called:
   - Initialize: left = 0, right = 11, leftMax = 0, rightMax = 1, waterTrapped = 0
   
   - Loop while left < right:
     - leftMax (0) < rightMax (1), so move left pointer
     - left = 1, height[1] = 1, update leftMax = 1
     - leftMax (1) == rightMax (1), so move right pointer
     - right = 10, height[10] = 2, update rightMax = 2
     - leftMax (1) < rightMax (2), so move left pointer
     - left = 2, height[2] = 0, leftMax = 1
     - Water trapped += leftMax - height[2] = 1 - 0 = 1
     
     - leftMax (1) < rightMax (2), so move left pointer
     - left = 3, height[3] = 2, update leftMax = 2
     - leftMax (2) == rightMax (2), so move right pointer
     - right = 9, height[9] = 1, rightMax = 2
     - Water trapped += rightMax - height[9] = 2 - 1 = 1
     
     - Continue this process...
     - Eventually, we'll accumulate 6 units of water
   
   - Return waterTrapped = 6

2. trapDP([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]) is called:
   - Fill leftMax array:
     - leftMax[0] = height[0] = 0
     - leftMax[1] = max(leftMax[0], height[1]) = max(0, 1) = 1
     - leftMax[2] = max(leftMax[1], height[2]) = max(1, 0) = 1
     - leftMax[3] = max(leftMax[2], height[3]) = max(1, 2) = 2
     - And so on...
     - Final leftMax = [0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3]
   
   - Fill rightMax array:
     - rightMax[11] = height[11] = 1
     - rightMax[10] = max(rightMax[11], height[10]) = max(1, 2) = 2
     - rightMax[9] = max(rightMax[10], height[9]) = max(2, 1) = 2
     - And so on...
     - Final rightMax = [3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1]
   
   - Calculate water trapped at each position:
     - Position 0: min(0, 3) - 0 = 0
     - Position 1: min(1, 3) - 1 = 0
     - Position 2: min(1, 3) - 0 = 1
     - Position 3: min(2, 3) - 2 = 0
     - Position 4: min(2, 3) - 1 = 1
     - Position 5: min(2, 3) - 0 = 2
     - Position 6: min(2, 3) - 1 = 1
     - Position 7: min(3, 3) - 3 = 0
     - Position 8: min(3, 2) - 2 = 0
     - Position 9: min(3, 2) - 1 = 1
     - Position 10: min(3, 2) - 2 = 0
     - Position 11: min(3, 1) - 1 = 0
     - Total water trapped = 0 + 0 + 1 + 0 + 1 + 2 + 1 + 0 + 0 + 1 + 0 + 0 = 6
   
   - Return waterTrapped = 6

Output:
Input: heights = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
Output: 6
Output (using DP): 6

Input: heights = [4, 2, 0, 3, 2, 5]
Output: 9
Output (using DP): 9

Detailed explanation for heights = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]:

Two Pointers Approach:
1. Initialize: left = 0, right = 11, leftMax = 0, rightMax = 1, waterTrapped = 0
2. Compare leftMax (0) < rightMax (1), move left pointer:
   - left = 1, height[1] = 1, update leftMax = 1
   - leftMax = 1, rightMax = 1

3. Compare leftMax (1) = rightMax (1), move right pointer:
   - right = 10, height[10] = 2, update rightMax = 2
   - leftMax = 1, rightMax = 2

4. Compare leftMax (1) < rightMax (2), move left pointer:
   - left = 2, height[2] = 0, leftMax = 1
   - Water trapped += leftMax - height[2] = 1 - 0 = 1
   - Total water trapped = 1

5. Continue this process...
   - Eventually, we'll accumulate 6 units of water

DP Approach:
1. Calculate leftMax array:
   - leftMax = [0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3]

2. Calculate rightMax array:
   - rightMax = [3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1]

3. Calculate water trapped at each position:
   - Position 0: min(0, 3) - 0 = 0
   - Position 1: min(1, 3) - 1 = 0
   - Position 2: min(1, 3) - 0 = 1
   - Position 3: min(2, 3) - 2 = 0
   - Position 4: min(2, 3) - 1 = 1
   - Position 5: min(2, 3) - 0 = 2
   - Position 6: min(2, 3) - 1 = 1
   - Position 7: min(3, 3) - 3 = 0
   - Position 8: min(3, 2) - 2 = 0
   - Position 9: min(3, 2) - 1 = 1
   - Position 10: min(3, 2) - 2 = 0
   - Position 11: min(3, 1) - 1 = 0
   - Total water trapped = 0 + 0 + 1 + 0 + 1 + 2 + 1 + 0 + 0 + 1 + 0 + 0 = 6
*/
