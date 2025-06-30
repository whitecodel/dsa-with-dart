// Fibonacci Number
// Similar to LeetCode 509: Fibonacci Number

/*
Problem Statement:
The Fibonacci numbers, commonly denoted F(n), form a sequence such that each number
is the sum of the two preceding ones, starting from 0 and 1. That is:
F(0) = 0, F(1) = 1
F(n) = F(n-1) + F(n-2), for n > 1

Given n, calculate F(n).

Example 1:
Input: n = 2
Output: 1
Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.

Example 2:
Input: n = 3
Output: 2
Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.
*/

// ============== Approach 1: Recursive (Naive) ==============
// Time Complexity: O(2^n) - exponential due to repeated calculations
// Space Complexity: O(n) - recursion stack depth

int fibRecursive(int n) {
  // Base cases
  if (n == 0) return 0;
  if (n == 1) return 1;

  // Recursive case: Fibonacci definition
  return fibRecursive(n - 1) + fibRecursive(n - 2);
}

/*
Execution trace for fibRecursive(5):

                      fib(5)
                    /      \
                fib(4)     fib(3)
               /    \      /    \
          fib(3)  fib(2) fib(2) fib(1)=1
          /    \   /   \  /   \
     fib(2) fib(1) f(1) f(0) f(1) f(0)
     /   \
  f(1) f(0)

Notice how fib(3), fib(2), fib(1), and fib(0) are calculated multiple times.
This redundancy makes the algorithm inefficient.
*/

// ============== Approach 2: Dynamic Programming (Top-Down/Memoization) ==============
// Time Complexity: O(n) - each subproblem is solved once
// Space Complexity: O(n) - memo table + recursion stack

int fibMemo(int n, Map<int, int> memo) {
  // Base cases
  if (n == 0) return 0;
  if (n == 1) return 1;

  // Check if we've already computed this value
  if (memo.containsKey(n)) {
    return memo[n]!;
  }

  // Compute and store the result
  memo[n] = fibMemo(n - 1, memo) + fibMemo(n - 2, memo);

  // Return the stored result
  return memo[n]!;
}

int fibTopDown(int n) {
  Map<int, int> memo = {};
  return fibMemo(n, memo);
}

/*
Execution trace for fibTopDown(5) with memoization:

1. Call fibMemo(5, {})
   - Not in memo, compute fibMemo(4, {}) + fibMemo(3, {})
   
2. Call fibMemo(4, {})
   - Not in memo, compute fibMemo(3, {}) + fibMemo(2, {})
   
3. Call fibMemo(3, {})
   - Not in memo, compute fibMemo(2, {}) + fibMemo(1, {})
   
4. Call fibMemo(2, {})
   - Not in memo, compute fibMemo(1, {}) + fibMemo(0, {})
   
5. Call fibMemo(1, {})
   - Base case, return 1
   
6. Call fibMemo(0, {})
   - Base case, return 0
   
7. fibMemo(2, {}) = 1 + 0 = 1
   - Store memo[2] = 1
   
8. Call fibMemo(1, {})
   - Base case, return 1
   
9. fibMemo(3, {}) = 1 + 1 = 2
   - Store memo[3] = 2
   
10. Call fibMemo(2, {})
    - Already in memo, return memo[2] = 1
    
11. fibMemo(4, {}) = 2 + 1 = 3
    - Store memo[4] = 3
    
12. Call fibMemo(3, {})
    - Already in memo, return memo[3] = 2
    
13. fibMemo(5, {}) = 3 + 2 = 5
    - Store memo[5] = 5
    
14. Return memo[5] = 5

Note how each subproblem is solved only once.
*/

// ============== Approach 3: Dynamic Programming (Bottom-Up/Tabulation) ==============
// Time Complexity: O(n) - iterate from 2 to n
// Space Complexity: O(n) - dp array

int fibBottomUp(int n) {
  // Handle base cases
  if (n == 0) return 0;
  if (n == 1) return 1;

  // Create dp table
  List<int> dp = List<int>.filled(n + 1, 0);

  // Set base values
  dp[0] = 0;
  dp[1] = 1;

  // Fill the dp table bottom-up
  for (int i = 2; i <= n; i++) {
    dp[i] = dp[i - 1] + dp[i - 2];

    // Debug: Print current state of dp table
    // print('dp[$i] = ${dp[i - 1]} + ${dp[i - 2]} = ${dp[i]}');
  }

  return dp[n];
}

/*
Execution trace for fibBottomUp(5):

1. Initialize dp = [0, 1, 0, 0, 0, 0]

2. i = 2:
   - dp[2] = dp[1] + dp[0] = 1 + 0 = 1
   - dp = [0, 1, 1, 0, 0, 0]

3. i = 3:
   - dp[3] = dp[2] + dp[1] = 1 + 1 = 2
   - dp = [0, 1, 1, 2, 0, 0]

4. i = 4:
   - dp[4] = dp[3] + dp[2] = 2 + 1 = 3
   - dp = [0, 1, 1, 2, 3, 0]

5. i = 5:
   - dp[5] = dp[4] + dp[3] = 3 + 2 = 5
   - dp = [0, 1, 1, 2, 3, 5]

6. Return dp[5] = 5
*/

// ============== Approach 4: Space-Optimized DP ==============
// Time Complexity: O(n) - iterate from 2 to n
// Space Complexity: O(1) - only using three variables

int fibOptimized(int n) {
  // Handle base cases
  if (n == 0) return 0;
  if (n == 1) return 1;

  // Initialize first two Fibonacci numbers
  int prev2 = 0; // F(0)
  int prev1 = 1; // F(1)
  int current = 0;

  // Calculate Fibonacci number iteratively
  for (int i = 2; i <= n; i++) {
    current = prev1 + prev2;

    // Debug: Print current state
    // print('F($i) = ${prev1} + ${prev2} = ${current}');

    // Update for next iteration
    prev2 = prev1;
    prev1 = current;
  }

  return current;
}

/*
Execution trace for fibOptimized(5):

1. Initialize prev2 = 0, prev1 = 1, current = 0

2. i = 2:
   - current = prev1 + prev2 = 1 + 0 = 1
   - prev2 = 1, prev1 = 1

3. i = 3:
   - current = prev1 + prev2 = 1 + 1 = 2
   - prev2 = 1, prev1 = 2

4. i = 4:
   - current = prev1 + prev2 = 2 + 1 = 3
   - prev2 = 2, prev1 = 3

5. i = 5:
   - current = prev1 + prev2 = 3 + 2 = 5
   - prev2 = 3, prev1 = 5

6. Return current = 5
*/

void main() {
  int n = 10;

  // Test all four approaches
  print('Recursive approach: F($n) = ${fibRecursive(n)}');
  print('Top-Down DP approach: F($n) = ${fibTopDown(n)}');
  print('Bottom-Up DP approach: F($n) = ${fibBottomUp(n)}');
  print('Space-Optimized approach: F($n) = ${fibOptimized(n)}');

  // Performance comparison
  n = 30; // A higher value to demonstrate performance differences

  // Top-Down DP (memoization)
  Stopwatch watch = Stopwatch()..start();
  int result = fibTopDown(n);
  watch.stop();
  print('\nTop-Down DP: F($n) = $result, Time: ${watch.elapsedMilliseconds}ms');

  // Bottom-Up DP (tabulation)
  watch = Stopwatch()..start();
  result = fibBottomUp(n);
  watch.stop();
  print('Bottom-Up DP: F($n) = $result, Time: ${watch.elapsedMilliseconds}ms');

  // Space-Optimized DP
  watch = Stopwatch()..start();
  result = fibOptimized(n);
  watch.stop();
  print(
    'Space-Optimized: F($n) = $result, Time: ${watch.elapsedMilliseconds}ms',
  );

  // The naive recursive approach would take too long for n=30, so skipping it
}
