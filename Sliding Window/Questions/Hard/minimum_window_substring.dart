// Minimum Window Substring
// LeetCode 76: Minimum Window Substring

/*
Problem Statement:
Given two strings s and t, return the minimum window in s which will contain all the
characters in t. If there is no such window in s that covers all characters in t, return the empty string.

Example:
Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"
Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
*/

// Time Complexity: O(n + m) where n is the length of s and m is the length of t
// Space Complexity: O(m) where m is the number of distinct characters in t

String minWindowSubstring(String s, String t) {
  // Step 1: Handle edge cases
  if (s.isEmpty || t.isEmpty || s.length < t.length) {
    return "";
  }

  // Step 2: Initialize variables
  Map<String, int> requiredChars = {}; // Characters needed from t
  Map<String, int> windowChars = {}; // Characters in current window

  // Count characters required in t
  for (int i = 0; i < t.length; i++) {
    String char = t[i];
    requiredChars[char] = (requiredChars[char] ?? 0) + 1;
  }

  int required = requiredChars.length; // Number of unique characters needed
  int formed = 0; // Number of unique characters formed in window

  int windowStart = 0; // Start of sliding window

  int minLen =
      s.length +
      1; // Length of minimum window found (using s.length+1 instead of infinity)
  int resultStart = 0; // Start index of minimum window

  // Step 3: Process the main string with sliding window
  for (int windowEnd = 0; windowEnd < s.length; windowEnd++) {
    String rightChar = s[windowEnd];

    // Add the current character to the window
    windowChars[rightChar] = (windowChars[rightChar] ?? 0) + 1;

    // Debug: Current window state
    // print('Added $rightChar, window: ${s.substring(windowStart, windowEnd + 1)}, map: $windowChars');

    // Check if this character helps fulfill requirements
    if (requiredChars.containsKey(rightChar) &&
        windowChars[rightChar] == requiredChars[rightChar]) {
      formed++;
      // print('Formed: $formed / $required');
    }

    // Step 4: Try to minimize the window by moving start pointer
    while (windowStart <= windowEnd && formed == required) {
      rightChar = s[windowEnd];

      // Update result if current window is smaller
      if (windowEnd - windowStart + 1 < minLen) {
        minLen = windowEnd - windowStart + 1;
        resultStart = windowStart;
        // print('New minimum window: ${s.substring(resultStart, resultStart + minLen)}');
      }

      // Remove the leftmost character
      String leftChar = s[windowStart];
      windowChars[leftChar] = windowChars[leftChar]! - 1;

      // If this causes a required character to go below required count
      if (requiredChars.containsKey(leftChar) &&
          windowChars[leftChar]! < requiredChars[leftChar]!) {
        formed--;
        // print('Formed decreased: $formed / $required');
      }

      // Move the window's start pointer forward
      windowStart++;

      // Debug: After shrinking
      // print('After shrinking - window: ${s.substring(windowStart, windowEnd + 1)}, formed: $formed');
    }
  }

  // Step 5: Return the minimum window substring, or empty if none found
  return minLen > s.length
      ? ""
      : s.substring(resultStart, resultStart + minLen);
}

/*
Execution trace for example "ADOBECODEBANC" with t = "ABC":

1. First, we count characters in t:
   - requiredChars = {'A': 1, 'B': 1, 'C': 1}
   - required = 3 (unique characters)

2. Process s:
   - windowEnd = 0, char = 'A':
     - Add 'A' to windowChars → {'A': 1}
     - formed = 1 (matches requirement for 'A')
     - Cannot shrink yet, formed (1) < required (3)

   - windowEnd = 1, char = 'D':
     - Add 'D' to windowChars → {'A': 1, 'D': 1}
     - D is not in requiredChars, formed still 1
     - Cannot shrink yet

   - windowEnd = 2, char = 'O':
     - Add 'O' to windowChars → {'A': 1, 'D': 1, 'O': 1}
     - formed still 1
     - Cannot shrink yet

   - windowEnd = 3, char = 'B':
     - Add 'B' to windowChars → {'A': 1, 'D': 1, 'O': 1, 'B': 1}
     - formed = 2 (matches requirements for 'A' and 'B')
     - Cannot shrink yet

   - windowEnd = 4, char = 'E':
     - Add 'E' to windowChars → {'A': 1, 'D': 1, 'O': 1, 'B': 1, 'E': 1}
     - formed still 2
     - Cannot shrink yet

   - windowEnd = 5, char = 'C':
     - Add 'C' to windowChars → {'A': 1, 'D': 1, 'O': 1, 'B': 1, 'E': 1, 'C': 1}
     - formed = 3 (matches all requirements)
     - Window: "ADOBEC", length = 6
     - Try to shrink:
       - Remove 'A', formed = 2, stop shrinking
       - Current minimum = "ADOBEC"

   - windowEnd = 6, char = 'O':
     - Add 'O' to windowChars → {'A': 0, 'D': 1, 'O': 2, 'B': 1, 'E': 1, 'C': 1}
     - formed still 2
     - Cannot shrink yet

   ... (continuing similarly)

   - Eventually, we reach windowEnd = 12, char = 'C':
     - Add 'C' to windowChars → {'A': 1, 'B': 1, 'C': 1, ...}
     - formed = 3 (matches all requirements)
     - Window: "BANC", length = 4
     - This is smaller than our previous minimum of 6
     - Update minimum to "BANC"

3. Return minimum window = "BANC" with length 4
*/

void main() {
  String s = "ADOBECODEBANC";
  String t = "ABC";

  String result = minWindowSubstring(s, t);
  print('Minimum window substring: $result'); // Expected: "BANC"

  // Additional test cases
  s = "a";
  t = "a";
  result = minWindowSubstring(s, t);
  print('Minimum window substring: $result'); // Expected: "a"

  s = "a";
  t = "aa";
  result = minWindowSubstring(s, t);
  print('Minimum window substring: $result'); // Expected: ""

  s = "ab";
  t = "b";
  result = minWindowSubstring(s, t);
  print('Minimum window substring: $result'); // Expected: "b"
}
