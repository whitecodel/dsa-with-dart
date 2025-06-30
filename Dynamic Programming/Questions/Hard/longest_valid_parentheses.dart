// Dynamic Programming: Longest Valid Parentheses
//
// Problem: Given a string containing only '(' and ')', find the length of the
// longest valid (well-formed) parentheses substring.
//
// Example 1:
// Input: s = "(()"
// Output: 2
// Explanation: The longest valid parentheses substring is "()".
//
// Example 2:
// Input: s = ")()())"
// Output: 4
// Explanation: The longest valid parentheses substring is "()()".
//
// Example 3:
// Input: s = ""
// Output: 0
//
// This problem demonstrates advanced dynamic programming with careful state transitions.

// Dynamic Programming solution - O(n) time, O(n) space
int longestValidParentheses(String s) {
  if (s.isEmpty) return 0;

  int n = s.length;
  int maxLength = 0;

  // dp[i] represents the length of the longest valid parentheses ending at index i
  List<int> dp = List.filled(n, 0);

  // Start from the second character
  for (int i = 1; i < n; i++) {
    // We only need to update dp when current character is ')'
    if (s[i] == ')') {
      // Case 1: s[i-1] is '('
      if (s[i - 1] == '(') {
        // Add 2 for the current valid pair
        // If i >= 2, add the length of any valid substring before this pair
        dp[i] = (i >= 2 ? dp[i - 2] : 0) + 2;
      }
      // Case 2: s[i-1] is ')'
      else if (i - dp[i - 1] > 0 && s[i - dp[i - 1] - 1] == '(') {
        // dp[i-1] gives us the length of valid substring ending at i-1
        // If s[i-dp[i-1]-1] is '(', it matches the current ')'
        // Add 2 for the matching pair and add the length of any valid substring before
        dp[i] =
            dp[i - 1] + 2 + (i - dp[i - 1] >= 2 ? dp[i - dp[i - 1] - 2] : 0);
      }

      // Update the maximum length found so far
      maxLength = max(maxLength, dp[i]);
    }
  }

  return maxLength;
}

// Stack-based solution - O(n) time, O(n) space
// This is an alternative approach that is sometimes easier to understand
int longestValidParenthesesStack(String s) {
  if (s.isEmpty) return 0;

  int maxLength = 0;
  List<int> stack = [-1]; // Start with -1 as a base

  for (int i = 0; i < s.length; i++) {
    if (s[i] == '(') {
      // Push the index of '(' onto the stack
      stack.add(i);
    } else {
      // s[i] == ')'
      // Pop the top element
      stack.removeLast();

      if (stack.isEmpty) {
        // If stack is empty, push current index as the new base
        stack.add(i);
      } else {
        // Calculate the length of valid substring
        int currentLength = i - stack.last;
        maxLength = max(maxLength, currentLength);
      }
    }
  }

  return maxLength;
}

// Helper function for max
int max(int a, int b) {
  return (a > b) ? a : b;
}

// Test function
void main() {
  // Test cases
  String s1 = "(()";
  String s2 = ")()())";
  String s3 = "";
  String s4 = "()(()))))";

  print('Input: s = "$s1"');
  print('Output: ${longestValidParentheses(s1)}');
  print('Output (stack): ${longestValidParenthesesStack(s1)}');

  print('\nInput: s = "$s2"');
  print('Output: ${longestValidParentheses(s2)}');
  print('Output (stack): ${longestValidParenthesesStack(s2)}');

  print('\nInput: s = "$s3"');
  print('Output: ${longestValidParentheses(s3)}');
  print('Output (stack): ${longestValidParenthesesStack(s3)}');

  print('\nInput: s = "$s4"');
  print('Output: ${longestValidParentheses(s4)}');
  print('Output (stack): ${longestValidParenthesesStack(s4)}');

  // Detailed explanation for the example
  print('\nDetailed explanation for s = ")()())":');

  print('\nDP Approach:');
  print('1. Initialize dp = [0, 0, 0, 0, 0, 0]');
  print('2. Iterate through the string:');

  print('   - i = 1, s[1] = ")", s[0] = ")"');
  print('     s[0] is not "(", so dp[1] = 0');

  print('   - i = 2, s[2] = ")", s[1] = "("');
  print(
    '     s[1] is "(", so dp[2] = (i >= 2 ? dp[i-2] : 0) + 2 = dp[0] + 2 = 0 + 2 = 2',
  );
  print('     maxLength = max(0, 2) = 2');

  print('   - i = 3, s[3] = ")", s[2] = ")"');
  print('     s[2] is ")", so check if s[i-dp[i-1]-1] is "("');
  print('     i - dp[i-1] - 1 = 3 - 2 - 1 = 0, s[0] is ")", so dp[3] = 0');

  print('   - i = 4, s[4] = ")", s[3] = "("');
  print(
    '     s[3] is "(", so dp[4] = (i >= 2 ? dp[i-2] : 0) + 2 = dp[2] + 2 = 2 + 2 = 4',
  );
  print('     maxLength = max(2, 4) = 4');

  print('   - i = 5, s[5] = ")", s[4] = ")"');
  print('     s[4] is ")", so check if s[i-dp[i-1]-1] is "("');
  print('     i - dp[i-1] - 1 = 5 - 4 - 1 = 0, s[0] is ")", so dp[5] = 0');

  print('3. Final dp array = [0, 0, 2, 0, 4, 0]');
  print('4. Maximum length = 4');

  print('\nStack Approach:');
  print('1. Initialize stack = [-1], maxLength = 0');
  print('2. Iterate through the string:');

  print(
    '   - i = 0, s[0] = ")", pop stack, stack is empty, push 0, stack = [0]',
  );

  print('   - i = 1, s[1] = "(", push 1, stack = [0, 1]');

  print(
    '   - i = 2, s[2] = ")", pop stack, stack = [0], currentLength = 2 - 0 = 2',
  );
  print('     maxLength = max(0, 2) = 2');

  print('   - i = 3, s[3] = "(", push 3, stack = [0, 3]');

  print(
    '   - i = 4, s[4] = ")", pop stack, stack = [0], currentLength = 4 - 0 = 4',
  );
  print('     maxLength = max(2, 4) = 4');

  print(
    '   - i = 5, s[5] = ")", pop stack, stack is empty, push 5, stack = [5]',
  );

  print('3. Final maxLength = 4');
}

/* Execution Trace:
1. longestValidParentheses(")()())") is called:
   - Initialize dp = [0, 0, 0, 0, 0, 0]
   
   - Iterate through the string (starting from i = 1):
     - i = 1, s[1] = "(":
       - Current character is not ")", so skip
       
     - i = 2, s[2] = ")":
       - Current character is ")"
       - Check if s[1] is "(" -> True
       - dp[2] = (2 >= 2 ? dp[0] : 0) + 2 = 0 + 2 = 2
       - maxLength = max(0, 2) = 2
       
     - i = 3, s[3] = "(":
       - Current character is not ")", so skip
       
     - i = 4, s[4] = ")":
       - Current character is ")"
       - Check if s[3] is "(" -> True
       - dp[4] = (4 >= 2 ? dp[2] : 0) + 2 = 2 + 2 = 4
       - maxLength = max(2, 4) = 4
       
     - i = 5, s[5] = ")":
       - Current character is ")"
       - Check if s[4] is "(" -> False
       - Check if i - dp[4] > 0 and s[i - dp[4] - 1] is "("
       - i - dp[4] = 5 - 4 = 1 > 0
       - s[1 - 1] = s[0] = ")" (not "("), so skip
       
   - Return maxLength = 4

2. longestValidParenthesesStack(")()())") is called:
   - Initialize stack = [-1], maxLength = 0
   
   - Iterate through the string:
     - i = 0, s[0] = ")":
       - Pop -1 from stack, stack is empty
       - Push 0 to stack, stack = [0]
       
     - i = 1, s[1] = "(":
       - Push 1 to stack, stack = [0, 1]
       
     - i = 2, s[2] = ")":
       - Pop 1 from stack, stack = [0]
       - Calculate length = 2 - 0 = 2
       - maxLength = max(0, 2) = 2
       
     - i = 3, s[3] = "(":
       - Push 3 to stack, stack = [0, 3]
       
     - i = 4, s[4] = ")":
       - Pop 3 from stack, stack = [0]
       - Calculate length = 4 - 0 = 4
       - maxLength = max(2, 4) = 4
       
     - i = 5, s[5] = ")":
       - Pop 0 from stack, stack is empty
       - Push 5 to stack, stack = [5]
       
   - Return maxLength = 4

Output:
Input: s = "(()"
Output: 2
Output (stack): 2

Input: s = ")()())"
Output: 4
Output (stack): 4

Input: s = ""
Output: 0
Output (stack): 0

Input: s = "()(())))))"
Output: 6
Output (stack): 6

Detailed explanation for s = ")()())":

DP Approach:
1. Initialize dp = [0, 0, 0, 0, 0, 0]
2. Iterate through the string:

   - i = 1, s[1] = ")", s[0] = ")"
     s[0] is not "(", so dp[1] = 0

   - i = 2, s[2] = ")", s[1] = "("
     s[1] is "(", so dp[2] = (i >= 2 ? dp[i-2] : 0) + 2 = dp[0] + 2 = 0 + 2 = 2
     maxLength = max(0, 2) = 2

   - i = 3, s[3] = ")", s[2] = ")"
     s[2] is ")", so check if s[i-dp[i-1]-1] is "("
     i - dp[i-1] - 1 = 3 - 2 - 1 = 0, s[0] is ")", so dp[3] = 0

   - i = 4, s[4] = ")", s[3] = "("
     s[3] is "(", so dp[4] = (i >= 2 ? dp[i-2] : 0) + 2 = dp[2] + 2 = 2 + 2 = 4
     maxLength = max(2, 4) = 4

   - i = 5, s[5] = ")", s[4] = ")"
     s[4] is ")", so check if s[i-dp[i-1]-1] is "("
     i - dp[i-1] - 1 = 5 - 4 - 1 = 0, s[0] is ")", so dp[5] = 0

3. Final dp array = [0, 0, 2, 0, 4, 0]
4. Maximum length = 4

Stack Approach:
1. Initialize stack = [-1], maxLength = 0
2. Iterate through the string:

   - i = 0, s[0] = ")", pop stack, stack is empty, push 0, stack = [0]

   - i = 1, s[1] = "(", push 1, stack = [0, 1]

   - i = 2, s[2] = ")", pop stack, stack = [0], currentLength = 2 - 0 = 2
     maxLength = max(0, 2) = 2

   - i = 3, s[3] = "(", push 3, stack = [0, 3]

   - i = 4, s[4] = ")", pop stack, stack = [0], currentLength = 4 - 0 = 4
     maxLength = max(2, 4) = 4

   - i = 5, s[5] = ")", pop stack, stack is empty, push 5, stack = [5]

3. Final maxLength = 4
*/
