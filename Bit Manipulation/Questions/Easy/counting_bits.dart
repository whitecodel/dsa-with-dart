// Bit Manipulation: Counting Bits
//
// Problem: Given a non-negative integer n, return an array of the number of 1's in
// the binary representation of each number from 0 to n.
//
// Example:
// Input: n = 5
// Output: [0, 1, 1, 2, 1, 2]
// Explanation:
// - 0 -> 0 (no 1's)
// - 1 -> 1 (one 1)
// - 2 -> 10 (one 1)
// - 3 -> 11 (two 1's)
// - 4 -> 100 (one 1)
// - 5 -> 101 (two 1's)
//
// This is an excellent bit manipulation problem that demonstrates how to count
// bits efficiently.

// O(n) solution with dynamic programming and bit manipulation
List<int> countBits(int n) {
  // Initialize result array with 0's
  List<int> result = List<int>.filled(n + 1, 0);

  // For each number from 1 to n
  for (int i = 1; i <= n; i++) {
    // A key insight: i & (i-1) removes the rightmost set bit of i
    // So result[i] = result[i & (i-1)] + 1

    // For example:
    // i = 3 (11), i-1 = 2 (10), i & (i-1) = 2 (10)
    // result[3] = result[2] + 1 = 1 + 1 = 2

    result[i] = result[i & (i - 1)] + 1;
  }

  return result;
}

// Alternative implementation using direct bit counting
List<int> countBitsAlternative(int n) {
  List<int> result = List<int>.filled(n + 1, 0);

  for (int i = 0; i <= n; i++) {
    int count = 0;
    int num = i;

    // Count each bit
    while (num > 0) {
      // If the least significant bit is 1, increment count
      count += num & 1;

      // Right shift to check the next bit
      num >>= 1;
    }

    result[i] = count;
  }

  return result;
}

// Test function
void main() {
  // Test cases
  int n1 = 5;
  int n2 = 10;

  print('Input: n = $n1');
  print('Output: ${countBits(n1)}');

  print('Input: n = $n2');
  print('Output: ${countBits(n2)}');

  // Explanation for n = 5
  print('\nDetailed explanation for n = 5:');
  print(
    '0 -> ${0.toRadixString(2).padLeft(3, '0')} -> ${countBitsAlternative(5)[0]} bits',
  );
  print(
    '1 -> ${1.toRadixString(2).padLeft(3, '0')} -> ${countBitsAlternative(5)[1]} bits',
  );
  print(
    '2 -> ${2.toRadixString(2).padLeft(3, '0')} -> ${countBitsAlternative(5)[2]} bits',
  );
  print(
    '3 -> ${3.toRadixString(2).padLeft(3, '0')} -> ${countBitsAlternative(5)[3]} bits',
  );
  print(
    '4 -> ${4.toRadixString(2).padLeft(3, '0')} -> ${countBitsAlternative(5)[4]} bits',
  );
  print(
    '5 -> ${5.toRadixString(2).padLeft(3, '0')} -> ${countBitsAlternative(5)[5]} bits',
  );
}

/* Execution Trace:
1. countBits(5) is called:
   - Initialize result = [0, 0, 0, 0, 0, 0]
   
   - i = 1:
     i & (i-1) = 1 & 0 = 0
     result[1] = result[0] + 1 = 0 + 1 = 1
     result = [0, 1, 0, 0, 0, 0]
     
   - i = 2:
     i & (i-1) = 2 & 1 = 0
     result[2] = result[0] + 1 = 0 + 1 = 1
     result = [0, 1, 1, 0, 0, 0]
     
   - i = 3:
     i & (i-1) = 3 & 2 = 2
     result[3] = result[2] + 1 = 1 + 1 = 2
     result = [0, 1, 1, 2, 0, 0]
     
   - i = 4:
     i & (i-1) = 4 & 3 = 0
     result[4] = result[0] + 1 = 0 + 1 = 1
     result = [0, 1, 1, 2, 1, 0]
     
   - i = 5:
     i & (i-1) = 5 & 4 = 4
     result[5] = result[4] + 1 = 1 + 1 = 2
     result = [0, 1, 1, 2, 1, 2]
     
2. Return result = [0, 1, 1, 2, 1, 2]

Output:
Input: n = 5
Output: [0, 1, 1, 2, 1, 2]
Input: n = 10
Output: [0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2]

Detailed explanation for n = 5:
0 -> 000 -> 0 bits
1 -> 001 -> 1 bits
2 -> 010 -> 1 bits
3 -> 011 -> 2 bits
4 -> 100 -> 1 bits
5 -> 101 -> 2 bits
*/
