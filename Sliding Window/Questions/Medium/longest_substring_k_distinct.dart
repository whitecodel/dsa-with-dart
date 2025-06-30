// Longest Substring with K Distinct Characters
// Similar to LeetCode 340: Longest Substring with At Most K Distinct Characters

/*
Problem Statement:
Given a string and an integer k, find the length of the longest substring that contains
at most k distinct characters.

Example:
Input: s = "eceba", k = 2
Output: 3
Explanation: The substring "ece" has length 3 with 2 distinct characters ('e' and 'c').
*/

// Time Complexity: O(n) where n is the length of the string
// Space Complexity: O(k) where k is the number of distinct characters

int longestSubstringWithKDistinct(String s, int k) {
  // Step 1: Check for edge cases
  if (s.isEmpty || k <= 0) {
    return 0;
  }

  if (k >= 26) {
    // If k is greater than or equal to alphabet size
    return s.length; // Return the entire string length
  }

  // Step 2: Initialize variables
  int windowStart = 0; // Start of our sliding window
  int maxLength = 0; // To store the maximum length found
  Map<String, int> charFrequency = {}; // Map to track character frequencies

  // Step 3: Iterate through the string using the end pointer
  for (int windowEnd = 0; windowEnd < s.length; windowEnd++) {
    String rightChar = s[windowEnd]; // Current character

    // Add the character to our frequency map
    charFrequency[rightChar] = (charFrequency[rightChar] ?? 0) + 1;

    // Debug: Current window state
    // print('Added $rightChar, window: ${s.substring(windowStart, windowEnd + 1)}, map: $charFrequency');

    // Step 4: Shrink the window if we have more than k distinct characters
    while (charFrequency.length > k) {
      String leftChar = s[windowStart];

      // Decrease frequency of the character going out of the window
      charFrequency[leftChar] = charFrequency[leftChar]! - 1;

      // If the frequency becomes zero, remove the character from the map
      if (charFrequency[leftChar] == 0) {
        charFrequency.remove(leftChar);
      }

      // Move the window's start pointer forward
      windowStart++;

      // Debug: After shrinking
      // print('Removed $leftChar, window: ${s.substring(windowStart, windowEnd + 1)}, map: $charFrequency');
    }

    // Step 5: Update the maximum length if current window is larger
    maxLength = maxLength > (windowEnd - windowStart + 1)
        ? maxLength
        : (windowEnd - windowStart + 1);
    // print('Current max length: $maxLength');
  }

  return maxLength;
}

/*
Execution trace for example "eceba" with k=2:

1. windowEnd = 0, char = 'e':
   - Add 'e' to frequency map → {'e': 1}
   - Window: "e", distinct chars = 1 (≤ k=2)
   - maxLength = 1

2. windowEnd = 1, char = 'c':
   - Add 'c' to frequency map → {'e': 1, 'c': 1}
   - Window: "ec", distinct chars = 2 (= k=2)
   - maxLength = 2

3. windowEnd = 2, char = 'e':
   - Increment 'e' in frequency map → {'e': 2, 'c': 1}
   - Window: "ece", distinct chars = 2 (= k=2)
   - maxLength = 3

4. windowEnd = 3, char = 'b':
   - Add 'b' to frequency map → {'e': 2, 'c': 1, 'b': 1}
   - Window: "eceb", distinct chars = 3 (> k=2)
   - Shrink window:
     - Remove 'e' → {'e': 1, 'c': 1, 'b': 1}
     - Still have 3 distinct chars
     - Remove 'c' → {'e': 1, 'b': 1}
     - Now we have 2 distinct chars
   - Window after shrinking: "eb"
   - maxLength still 3

5. windowEnd = 4, char = 'a':
   - Add 'a' to frequency map → {'e': 1, 'b': 1, 'a': 1}
   - Window: "eba", distinct chars = 3 (> k=2)
   - Shrink window:
     - Remove 'e' → {'b': 1, 'a': 1}
     - Now we have 2 distinct chars
   - Window after shrinking: "ba"
   - maxLength still 3

6. End of string, return maxLength = 3
*/

void main() {
  String test = "eceba";
  int k = 2;

  int result = longestSubstringWithKDistinct(test, k);
  print(
    'Length of the longest substring with $k distinct characters: $result',
  ); // Expected: 3

  // Additional test cases
  test = "aa";
  k = 1;
  result = longestSubstringWithKDistinct(test, k);
  print(
    'Length of the longest substring with $k distinct characters: $result',
  ); // Expected: 2

  test = "araaci";
  k = 2;
  result = longestSubstringWithKDistinct(test, k);
  print(
    'Length of the longest substring with $k distinct characters: $result',
  ); // Expected: 4

  test = "cbbebi";
  k = 3;
  result = longestSubstringWithKDistinct(test, k);
  print(
    'Length of the longest substring with $k distinct characters: $result',
  ); // Expected: 6 (entire string)
}
