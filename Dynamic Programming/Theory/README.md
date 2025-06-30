# Dynamic Programming (DP) Algorithm Pattern

## Overview

Dynamic Programming is a powerful optimization technique that solves complex problems by breaking them down into simpler subproblems. It is particularly useful when a problem has overlapping subproblems and optimal substructure.

## Core Principles

### 1. Overlapping Subproblems

- The same subproblems are solved multiple times
- Solutions can be cached (memoized) to avoid redundant calculations

### 2. Optimal Substructure

- An optimal solution to the problem contains optimal solutions to its subproblems
- The global optimal solution can be constructed from local optimal solutions

## Types of Dynamic Programming

### 1. Top-Down Approach (Memoization)

- Start with the original problem
- Break it down into subproblems recursively
- Use a cache (usually a map/array) to store results of subproblems
- Benefits:
  - Easier to understand as it follows natural recursive thinking
  - Only computes needed states
  - Preserves the original problem structure

### 2. Bottom-Up Approach (Tabulation)

- Start with the smallest subproblems
- Build up solutions iteratively
- Store results in a table (usually an array)
- Benefits:
  - More efficient (no recursion overhead)
  - No risk of stack overflow
  - Often more space-efficient

## Common DP Patterns

### 1. Linear Sequences

- 1D array problems: Fibonacci, climbing stairs

### 2. Decision Making

- Include/exclude patterns: knapsack, subset sum

### 3. Interval Problems

- Problems dealing with intervals: matrix chain multiplication

### 4. Two-Dimensional Problems

- Grid traversal, longest common subsequence

### 5. State Machines

- Stock buying/selling, state transitions

### 6. String Problems

- String matching, edit distance, palindromic substrings

## Steps to Solve DP Problems

1. **Identify the problem as DP**: Check for overlapping subproblems and optimal substructure
2. **Define the state**: What variables are needed to define a unique subproblem?
3. **Define the recurrence relation**: How does the current state relate to previous states?
4. **Identify base cases**: What are the simplest cases with known answers?
5. **Decide the approach**: Top-down or bottom-up?
6. **Add memoization or create a table**: Store intermediate results
7. **Solve the original problem**: Use the defined recurrence relation

## Time & Space Complexity

- **Time Complexity**: O(states × time per state)
  - For states, count all possible unique combinations of state variables
  - For time per state, consider operations needed to compute one state
- **Space Complexity**:
  - Top-down: O(states + recursion stack depth)
  - Bottom-up: O(states) or potentially less with space optimization

## Basic DP Templates in Dart

### Top-Down (Memoization)

```dart
// Fibonacci example with memoization
int fib(int n, Map<int, int> memo) {
  // Base cases
  if (n <= 1) return n;

  // Check if result is already cached
  if (memo.containsKey(n)) {
    return memo[n]!;
  }

  // Calculate and cache result
  memo[n] = fib(n - 1, memo) + fib(n - 2, memo);
  return memo[n]!;
}

// Driver
int fibonacci(int n) {
  Map<int, int> memo = {};
  return fib(n, memo);
}
```

### Bottom-Up (Tabulation)

```dart
// Fibonacci example with tabulation
int fibonacci(int n) {
  if (n <= 1) return n;

  // Create table for storing results
  List<int> dp = List<int>.filled(n + 1, 0);

  // Base cases
  dp[0] = 0;
  dp[1] = 1;

  // Fill the table bottom-up
  for (int i = 2; i <= n; i++) {
    dp[i] = dp[i - 1] + dp[i - 2];
  }

  return dp[n];
}
```

### Space-Optimized Bottom-Up

```dart
// Fibonacci with O(1) space
int fibonacci(int n) {
  if (n <= 1) return n;

  int prev2 = 0;  // fib(0)
  int prev1 = 1;  // fib(1)
  int current = 0;

  for (int i = 2; i <= n; i++) {
    current = prev1 + prev2;
    prev2 = prev1;
    prev1 = current;
  }

  return prev1;
}
```

## Common Pitfalls

1. **Not identifying the state properly**: Missing state variables leads to incorrect solutions
2. **Incorrect recurrence relation**: Double-check the recursive formula
3. **Missing base cases**: Leads to infinite recursion or incorrect results
4. **Not handling edge cases**: Special cases that don't fit the general pattern
5. **Excessive memory usage**: Not optimizing space in problems with large constraints

## When to Use Dynamic Programming

- When a problem requires finding an optimal value (max/min)
- When the problem can be broken down into overlapping subproblems
- When there's a recursive solution with exponential time complexity
- When the problem involves choices at each step that affect future steps
- Common examples: optimization problems, counting problems, and some game theory problems

## Real-World Applications

- Resource allocation and scheduling
- Sequence alignment in bioinformatics
- Natural language processing
- Financial modeling and portfolio optimization
- Routing algorithms
- Game AI and decision making
- Image processing algorithms
