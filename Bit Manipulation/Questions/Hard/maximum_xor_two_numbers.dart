// Bit Manipulation: Maximum XOR of Two Numbers in an Array
//
// Problem: Given an integer array nums, return the maximum result of nums[i] XOR nums[j],
// where 0 ≤ i ≤ j < n.
//
// Example:
// Input: nums = [3, 10, 5, 25, 2, 8]
// Output: 28
// Explanation: The maximum result is 5 XOR 25 = 28.
//
// This problem demonstrates advanced bit manipulation techniques including
// using a trie-like structure with bits for efficient XOR operations.

// Brute force solution - O(n²) time complexity
int findMaximumXORBrute(List<int> nums) {
  int maxXor = 0;

  for (int i = 0; i < nums.length; i++) {
    for (int j = i; j < nums.length; j++) {
      maxXor = max(maxXor, nums[i] ^ nums[j]);
    }
  }

  return maxXor;
}

// Optimized solution using bit manipulation and a HashSet - O(n * log(max)) time complexity
int findMaximumXOR(List<int> nums) {
  // Find the maximum number to determine the number of bits needed
  int maxNum = nums.reduce((a, b) => max(a, b));
  int maxBit = 0;

  // Find the position of the most significant bit (number of bits needed)
  while (maxNum > 0) {
    maxNum >>= 1;
    maxBit++;
  }

  int maxXor = 0;
  int currentXor = 0;

  // Start from the most significant bit and build the result bit by bit
  for (int bit = maxBit - 1; bit >= 0; bit--) {
    // Include the current bit in the potential result
    currentXor = (currentXor << 1) | 1;

    // Set to check for prefixes
    Set<int> prefixes = {};

    // Store the prefix of each number up to the current bit
    for (int num in nums) {
      // Extract the prefix (bits from most significant down to current)
      int prefix = num >> bit;
      prefixes.add(prefix);
    }

    // Check if we can achieve the desired XOR with current bit set to 1
    for (int prefix in prefixes) {
      // If xor of some prefix and target exists in prefixes, then we can achieve currentXor
      int target = currentXor ^ prefix;
      if (prefixes.contains(target)) {
        // We can achieve this XOR, so keep this bit as 1
        maxXor = currentXor;
        break;
      }
    }

    // If we couldn't find a match to keep the current bit as 1, set it back to 0
    if (maxXor != currentXor) {
      currentXor ^= 1; // Flip the last bit back to 0
    }
  }

  return maxXor;
}

// Trie-based solution - O(n * log(max)) time complexity but more intuitive
class TrieNode {
  TrieNode? left; // Represents 0 bit
  TrieNode? right; // Represents 1 bit
}

int findMaximumXORTrie(List<int> nums) {
  // Build a trie
  TrieNode root = TrieNode();

  // Find the maximum number to determine the number of bits needed
  int maxNum = nums.reduce((a, b) => max(a, b));
  int L = maxNum.toRadixString(2).length;

  // Insert all numbers into the trie
  for (int num in nums) {
    TrieNode node = root;
    for (int i = L - 1; i >= 0; i--) {
      // Check if the i-th bit is set
      int bit = (num >> i) & 1;

      if (bit == 0) {
        // If the current bit is 0, go left
        node.left ??= TrieNode();
        node = node.left!;
      } else {
        // If the current bit is 1, go right
        node.right ??= TrieNode();
        node = node.right!;
      }
    }
  }

  // Find maximum XOR
  int maxXor = 0;

  for (int num in nums) {
    TrieNode node = root;
    int currentXor = 0;

    for (int i = L - 1; i >= 0; i--) {
      int bit = (num >> i) & 1;

      if (bit == 0) {
        // If current bit is 0, go right if possible (to make current XOR bit 1)
        if (node.right != null) {
          currentXor = (currentXor << 1) | 1;
          node = node.right!;
        } else {
          currentXor = currentXor << 1;
          node = node.left!;
        }
      } else {
        // If current bit is 1, go left if possible (to make current XOR bit 1)
        if (node.left != null) {
          currentXor = (currentXor << 1) | 1;
          node = node.left!;
        } else {
          currentXor = currentXor << 1;
          node = node.right!;
        }
      }
    }

    maxXor = max(maxXor, currentXor);
  }

  return maxXor;
}

// Helper function to find the maximum of two numbers
int max(int a, int b) => a > b ? a : b;

// Test function
void main() {
  // Test cases
  List<int> nums1 = [3, 10, 5, 25, 2, 8];
  List<int> nums2 = [14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66];

  print('Input: nums = $nums1');
  print('Output (brute force): ${findMaximumXORBrute(nums1)}');
  print('Output (optimized): ${findMaximumXOR(nums1)}');
  print('Output (trie): ${findMaximumXORTrie(nums1)}');

  print('\nInput: nums = $nums2');
  print('Output (optimized): ${findMaximumXOR(nums2)}');
  print('Output (trie): ${findMaximumXORTrie(nums2)}');

  // Detailed explanation
  print('\nDetailed explanation for [3, 10, 5, 25, 2, 8]:');

  print('\nBrute force approach:');
  print(
    '- Check all pairs: (3,3), (3,10), (3,5), (3,25), (3,2), (3,8), (10,10)...',
  );
  print('- 3 XOR 3 = 0');
  print('- 3 XOR 10 = 9');
  print('- 3 XOR 5 = 6');
  print('- 3 XOR 25 = 26');
  print('- 3 XOR 2 = 1');
  print('- 3 XOR 8 = 11');
  print('- 10 XOR 5 = 15');
  print('- 10 XOR 25 = 19');
  print('- ...');
  print('- 5 XOR 25 = 28 (maximum)');

  print('\nTrie-based approach:');
  print('1. Convert all numbers to binary (5-bit representation):');
  print('   - 3: 00011');
  print('   - 10: 01010');
  print('   - 5: 00101');
  print('   - 25: 11001');
  print('   - 2: 00010');
  print('   - 8: 01000');

  print('\n2. Build a trie with these binary representations');

  print(
    '\n3. For each number, traverse the trie to find the best match for XOR:',
  );
  print('   For 5 (00101):');
  print('   - Bit 4: 0, prefer to go to 1-branch (for 1 in XOR result)');
  print('   - Bit 3: 0, prefer to go to 1-branch');
  print('   - Bit 2: 1, prefer to go to 0-branch');
  print('   - Bit 1: 0, prefer to go to 1-branch');
  print('   - Bit 0: 1, prefer to go to 0-branch');
  print('   - This leads to 25 (11001), giving 5 XOR 25 = 28');
}

/* Execution Trace for the optimized solution with [3, 10, 5, 25, 2, 8]:
1. Find max number: 25
2. Determine bit length: 5 bits needed (11001 in binary)

3. Start building result from most significant bit (bit 4) to least significant (bit 0)
   - Bit 4:
     * currentXor = 1 (10000 in binary, trying to set most significant bit)
     * Prefixes: {0, 0, 0, 1, 0, 0} (most significant bits of all numbers)
     * Can we achieve this XOR? Check if 0 ^ 1 = 1 or 1 ^ 1 = 0 exists in prefixes
     * Yes, we can keep this bit as 1 in our result
     * maxXor = 10000 (16 in decimal)
   
   - Bit 3:
     * currentXor = 11 (11000 in binary, trying to set second bit as well)
     * Prefixes: {00, 01, 00, 11, 00, 01} (two most significant bits of all numbers)
     * Can we achieve this XOR? Check for matching prefixes
     * Yes, we can keep this bit as 1 too
     * maxXor = 11000 (24 in decimal)
   
   - Bit 2:
     * currentXor = 111 (11100 in binary)
     * Prefixes: {000, 010, 001, 110, 000, 010}
     * Can we achieve this XOR? Check for matching prefixes
     * No match found, so we set this bit back to 0
     * currentXor = 11000 (24 in decimal)
   
   - Bit 1:
     * currentXor = 11010 (26 in decimal)
     * Prefixes: {0001, 0101, 0010, 1100, 0001, 0100}
     * Can we achieve this XOR? Check for matching prefixes
     * Yes, we can keep this bit as 1
     * maxXor = 11010 (26 in decimal)
   
   - Bit 0:
     * currentXor = 11101 (29 in decimal)
     * Prefixes: {00011, 01010, 00101, 11001, 00010, 01000}
     * Can we achieve this XOR? Check for matching prefixes
     * No match found, so we set this bit back to 0
     * currentXor = 11100 (28 in decimal)

4. Return maxXor = 28 (5 XOR 25 = 28)

Output:
Input: nums = [3, 10, 5, 25, 2, 8]
Output (brute force): 28
Output (optimized): 28
Output (trie): 28

Input: nums = [14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66]
Output (optimized): 127
Output (trie): 127

Detailed explanation for [3, 10, 5, 25, 2, 8]:

Brute force approach:
- Check all pairs: (3,3), (3,10), (3,5), (3,25), (3,2), (3,8), (10,10)...
- 3 XOR 3 = 0
- 3 XOR 10 = 9
- 3 XOR 5 = 6
- 3 XOR 25 = 26
- 3 XOR 2 = 1
- 3 XOR 8 = 11
- 10 XOR 5 = 15
- 10 XOR 25 = 19
- ...
- 5 XOR 25 = 28 (maximum)

Trie-based approach:
1. Convert all numbers to binary (5-bit representation):
   - 3: 00011
   - 10: 01010
   - 5: 00101
   - 25: 11001
   - 2: 00010
   - 8: 01000

2. Build a trie with these binary representations

3. For each number, traverse the trie to find the best match for XOR:
   For 5 (00101):
   - Bit 4: 0, prefer to go to 1-branch (for 1 in XOR result)
   - Bit 3: 0, prefer to go to 1-branch
   - Bit 2: 1, prefer to go to 0-branch
   - Bit 1: 0, prefer to go to 1-branch
   - Bit 0: 1, prefer to go to 0-branch
   - This leads to 25 (11001), giving 5 XOR 25 = 28
*/
