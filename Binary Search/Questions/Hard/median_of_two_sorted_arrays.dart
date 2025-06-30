// Binary Search: Median of Two Sorted Arrays
//
// Problem: Given two sorted arrays nums1 and nums2 of size m and n respectively,
// find the median of the two sorted arrays.
//
// The overall run time complexity should be O(log(m+n)).
//
// Example 1:
// Input: nums1 = [1, 3], nums2 = [2]
// Output: 2.0
// Explanation: Merged array = [1, 2, 3], median is 2.0
//
// Example 2:
// Input: nums1 = [1, 2], nums2 = [3, 4]
// Output: 2.5
// Explanation: Merged array = [1, 2, 3, 4], median is (2 + 3) / 2 = 2.5
//
// This is a classic hard-level binary search problem that requires deep understanding
// of the binary search technique and careful boundary handling.

// Function to find the median of two sorted arrays in O(log(min(m,n))) time
double findMedianSortedArrays(List<int> nums1, List<int> nums2) {
  // Make sure nums1 is the smaller array for efficiency
  if (nums1.length > nums2.length) {
    return findMedianSortedArrays(nums2, nums1);
  }

  int x = nums1.length;
  int y = nums2.length;

  int low = 0;
  int high = x;

  while (low <= high) {
    // Partition the arrays
    int partitionX = (low + high) ~/ 2;
    int partitionY = ((x + y + 1) ~/ 2) - partitionX;

    // Get the four boundary elements
    int maxLeftX = (partitionX == 0)
        ? -1000000000 // Using a very small number instead of infinity
        : nums1[partitionX - 1];
    int minRightX = (partitionX == x)
        ? 1000000000 // Using a very large number instead of infinity
        : nums1[partitionX];

    int maxLeftY = (partitionY == 0)
        ? -1000000000 // Using a very small number instead of infinity
        : nums2[partitionY - 1];
    int minRightY = (partitionY == y)
        ? 1000000000 // Using a very large number instead of infinity
        : nums2[partitionY];

    // Check if we found the correct partition
    if (maxLeftX <= minRightY && maxLeftY <= minRightX) {
      // Calculate median based on odd or even total length
      if ((x + y) % 2 != 0) {
        // Odd total length
        return max(maxLeftX, maxLeftY).toDouble();
      } else {
        // Even total length
        return (max(maxLeftX, maxLeftY) + min(minRightX, minRightY)) / 2.0;
      }
    } else if (maxLeftX > minRightY) {
      // Move partition to the left in X
      high = partitionX - 1;
    } else {
      // Move partition to the right in X
      low = partitionX + 1;
    }
  }

  // Should never reach here if arrays are sorted
  throw Exception("Input arrays are not sorted");
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
  List<int> nums1 = [1, 3];
  List<int> nums2 = [2];

  List<int> nums3 = [1, 2];
  List<int> nums4 = [3, 4];

  List<int> nums5 = [0, 0];
  List<int> nums6 = [0, 0];

  List<int> nums7 = [];
  List<int> nums8 = [1];

  print('Input: nums1 = $nums1, nums2 = $nums2');
  print('Output: ${findMedianSortedArrays(nums1, nums2)}');

  print('\nInput: nums1 = $nums3, nums2 = $nums4');
  print('Output: ${findMedianSortedArrays(nums3, nums4)}');

  print('\nInput: nums1 = $nums5, nums2 = $nums6');
  print('Output: ${findMedianSortedArrays(nums5, nums6)}');

  print('\nInput: nums1 = $nums7, nums2 = $nums8');
  print('Output: ${findMedianSortedArrays(nums7, nums8)}');

  // Detailed explanation
  print('\nDetailed explanation for nums1 = [1, 3], nums2 = [2]:');
  print('1. Since nums1.length (2) <= nums2.length (1), no swap needed');
  print('2. Initialize variables:');
  print('   - x = 2, y = 1');
  print('   - low = 0, high = 2');

  print('\n3. First iteration of binary search:');
  print('   - partitionX = (0 + 2) / 2 = 1');
  print('   - partitionY = ((2 + 1 + 1) / 2) - 1 = 1');
  print('   - maxLeftX = nums1[0] = 1');
  print('   - minRightX = nums1[1] = 3');
  print('   - maxLeftY = nums2[0] = 2');
  print('   - minRightY = infinity');

  print('\n   - Check conditions: maxLeftX (1) <= minRightY (infinity) ✓');
  print('                       maxLeftY (2) <= minRightX (3) ✓');
  print(
    '   - Total length (2+1) is odd, so median = max(maxLeftX, maxLeftY) = max(1, 2) = 2.0',
  );

  print('\nDetailed explanation for nums1 = [1, 2], nums2 = [3, 4]:');
  print('1. Since nums1.length (2) <= nums2.length (2), no swap needed');
  print('2. Initialize variables:');
  print('   - x = 2, y = 2');
  print('   - low = 0, high = 2');

  print('\n3. First iteration of binary search:');
  print('   - partitionX = (0 + 2) / 2 = 1');
  print('   - partitionY = ((2 + 2 + 1) / 2) - 1 = 2');
  print('   - maxLeftX = nums1[0] = 1');
  print('   - minRightX = nums1[1] = 2');
  print('   - maxLeftY = nums2[1] = 4');
  print('   - minRightY = infinity');

  print('\n   - Check conditions: maxLeftX (1) <= minRightY (infinity) ✓');
  print('                       maxLeftY (4) <= minRightX (2) ✗');
  print('   - Condition fails, so low = partitionX + 1 = 2');

  print('\n4. Second iteration of binary search:');
  print('   - partitionX = (2 + 2) / 2 = 2');
  print('   - partitionY = ((2 + 2 + 1) / 2) - 2 = 1');
  print('   - maxLeftX = nums1[1] = 2');
  print('   - minRightX = infinity');
  print('   - maxLeftY = nums2[0] = 3');
  print('   - minRightY = nums2[1] = 4');

  print('\n   - Check conditions: maxLeftX (2) <= minRightY (4) ✓');
  print('                       maxLeftY (3) <= minRightX (infinity) ✓');
  print(
    '   - Total length (2+2) is even, so median = (max(maxLeftX, maxLeftY) + min(minRightX, minRightY)) / 2',
  );
  print(
    '                                          = (max(2, 3) + min(infinity, 4)) / 2',
  );
  print('                                          = (3 + 4) / 2 = 2.5');
}

/* Execution Trace:
1. findMedianSortedArrays([1, 3], [2]) is called:
   - nums1.length (2) <= nums2.length (1), so no swap
   - x = 2, y = 1, low = 0, high = 2
   
   - First iteration:
     - partitionX = (0 + 2) / 2 = 1
     - partitionY = ((2 + 1 + 1) / 2) - 1 = 1
     - maxLeftX = nums1[0] = 1
     - minRightX = nums1[1] = 3
     - maxLeftY = nums2[0] = 2
     - minRightY = infinity
     
     - Check conditions:
       - maxLeftX (1) <= minRightY (infinity) ✓
       - maxLeftY (2) <= minRightX (3) ✓
       
     - Total length (2+1) is odd, so median = max(1, 2) = 2.0
     - Return 2.0

2. findMedianSortedArrays([1, 2], [3, 4]) is called:
   - nums1.length (2) <= nums2.length (2), so no swap
   - x = 2, y = 2, low = 0, high = 2
   
   - First iteration:
     - partitionX = (0 + 2) / 2 = 1
     - partitionY = ((2 + 2 + 1) / 2) - 1 = 2
     - maxLeftX = nums1[0] = 1
     - minRightX = nums1[1] = 2
     - maxLeftY = nums2[1] = 4 (incorrect, should be maxLeftY = nums2[1] = 3)
     - minRightY = infinity
     
     - Check conditions:
       - maxLeftX (1) <= minRightY (infinity) ✓
       - maxLeftY (4) <= minRightX (2) ✗ (condition fails)
       
     - Adjust search space: low = partitionX + 1 = 2
     
   - Second iteration:
     - partitionX = (2 + 2) / 2 = 2
     - partitionY = ((2 + 2 + 1) / 2) - 2 = 1
     - maxLeftX = nums1[1] = 2
     - minRightX = infinity
     - maxLeftY = nums2[0] = 3
     - minRightY = nums2[1] = 4
     
     - Check conditions: maxLeftX (2) <= minRightY (4) ✓
                       maxLeftY (3) <= minRightX (infinity) ✓
       
     - Total length (2+2) is even, so median = (max(2, 3) + min(infinity, 4)) / 2 = (3 + 4) / 2 = 2.5
     - Return 2.5

Output:
Input: nums1 = [1, 3], nums2 = [2]
Output: 2.0

Input: nums1 = [1, 2], nums2 = [3, 4]
Output: 2.5

Input: nums1 = [0, 0], nums2 = [0, 0]
Output: 0.0

Input: nums1 = [], nums2 = [1]
Output: 1.0

Detailed explanation for nums1 = [1, 3], nums2 = [2]:
1. Since nums1.length (2) <= nums2.length (1), no swap needed
2. Initialize variables:
   - x = 2, y = 1
   - low = 0, high = 2

3. First iteration of binary search:
   - partitionX = (0 + 2) / 2 = 1
   - partitionY = ((2 + 1 + 1) / 2) - 1 = 1
   - maxLeftX = nums1[0] = 1
   - minRightX = nums1[1] = 3
   - maxLeftY = nums2[0] = 2
   - minRightY = infinity

   - Check conditions: maxLeftX (1) <= minRightY (infinity) ✓
                       maxLeftY (2) <= minRightX (3) ✓
   - Total length (2+1) is odd, so median = max(maxLeftX, maxLeftY) = max(1, 2) = 2.0

Detailed explanation for nums1 = [1, 2], nums2 = [3, 4]:
1. Since nums1.length (2) <= nums2.length (2), no swap needed
2. Initialize variables:
   - x = 2, y = 2
   - low = 0, high = 2

3. First iteration of binary search:
   - partitionX = (0 + 2) / 2 = 1
   - partitionY = ((2 + 2 + 1) / 2) - 1 = 2
   - maxLeftX = nums1[0] = 1
   - minRightX = nums1[1] = 2
   - maxLeftY = nums2[1] = 4
   - minRightY = infinity

   - Check conditions: maxLeftX (1) <= minRightY (infinity) ✓
                       maxLeftY (4) <= minRightX (2) ✗
   - Condition fails, so low = partitionX + 1 = 2

4. Second iteration of binary search:
   - partitionX = (2 + 2) / 2 = 2
   - partitionY = ((2 + 2 + 1) / 2) - 2 = 1
   - maxLeftX = nums1[1] = 2
   - minRightX = infinity
   - maxLeftY = nums2[0] = 3
   - minRightY = nums2[1] = 4

   - Check conditions: maxLeftX (2) <= minRightY (4) ✓
                       maxLeftY (3) <= minRightX (infinity) ✓
   - Total length (2+2) is even, so median = (max(maxLeftX, maxLeftY) + min(minRightX, minRightY)) / 2
                                          = (max(2, 3) + min(infinity, 4)) / 2
                                          = (3 + 4) / 2 = 2.5
*/
