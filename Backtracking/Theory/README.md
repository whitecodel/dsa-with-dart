# Backtracking Algorithm Pattern

## Overview

Backtracking is an algorithmic technique for solving problems recursively by trying to build a solution incrementally, one piece at a time, removing solutions that fail to satisfy the constraints of the problem at any point.

## How Backtracking Works

1. Choose: Select a candidate for the solution
2. Constraint: Check if the candidate violates any constraints
3. Goal: Check if the current state is a valid solution
4. Backtrack: If constraints are violated or the goal is not reached, undo the choice and try alternatives

## Key Components of Backtracking

### 1. State Space Tree

- Represents all possible states of the solution
- Each node is a state in the solution construction
- Paths from root to leaves represent complete candidate solutions

### 2. Decision Space

- The set of choices available at each step
- Choices are filtered by constraints

### 3. Constraints

- Implicit: Derived from the problem structure
- Explicit: Directly specified in the problem statement

### 4. Pruning

- Eliminating branches that cannot lead to valid solutions
- Significantly improves efficiency by avoiding exploring unnecessary paths

## Types of Backtracking Problems

### 1. Decision Problems

- Determine if a solution exists
- Example: N-Queens Problem, Sudoku

### 2. Optimization Problems

- Find the best solution according to some criterion
- Example: Traveling Salesman Problem

### 3. Enumeration Problems

- Find all solutions that satisfy constraints
- Example: Permutations, Combinations, Subsets

## Time & Space Complexity

- **Time Complexity**: O(b^d) where b is the branching factor and d is the maximum depth
  - Can be significantly reduced with effective pruning
- **Space Complexity**: O(d) where d is the maximum recursion depth
  - Represents the stack space used for recursion

## Basic Backtracking Template in Dart

```dart
void backtrack(State currentState) {
  // Base case: Check if we've reached a goal state
  if (isGoalState(currentState)) {
    processSolution(currentState);
    return;
  }

  // Get all candidates for the next choice
  List<Choice> candidates = generateCandidates(currentState);

  // Try each candidate
  for (Choice candidate in candidates) {
    // Check if this candidate is valid
    if (isValid(currentState, candidate)) {
      // Make the choice - update the state
      applyChoice(currentState, candidate);

      // Recurse with the new state
      backtrack(currentState);

      // Undo the choice - backtrack
      undoChoice(currentState, candidate);
    }
  }
}
```

## Example: Generating All Subsets

```dart
void generateSubsets(List<int> nums) {
  List<int> currentSubset = [];
  backtrack(nums, 0, currentSubset);
}

void backtrack(List<int> nums, int index, List<int> currentSubset) {
  // Print current subset (includes empty set)
  print(currentSubset);

  // Try including each remaining number
  for (int i = index; i < nums.length; i++) {
    // Include the current number
    currentSubset.add(nums[i]);

    // Recurse to the next position
    backtrack(nums, i + 1, currentSubset);

    // Backtrack - remove the number to try other possibilities
    currentSubset.removeLast();
  }
}
```

## Common Backtracking Problems

1. **Permutations and Combinations**: Generate all permutations or combinations of a set
2. **Subset Sum**: Find subsets that sum to a specific value
3. **N-Queens Problem**: Place N queens on an NxN chessboard without attacking each other
4. **Sudoku Solver**: Fill a 9x9 grid with digits according to Sudoku rules
5. **Word Search**: Find a word in a 2D grid of characters
6. **Graph Coloring**: Assign colors to vertices such that no adjacent vertices have the same color
7. **Hamiltonian Path/Cycle**: Find a path that visits every vertex exactly once

## Optimization Techniques

### 1. Early Pruning

- Detect invalid paths as early as possible
- Avoid unnecessary recursive calls

### 2. Ordering Heuristics

- Process more promising candidates first
- Example: MRV (Minimum Remaining Values) in constraint satisfaction problems

### 3. Forward Checking

- Look ahead to see if a choice will lead to constraints being violated later

### 4. Problem-Specific Constraints

- Use domain knowledge to add additional constraints
- Reduces the search space significantly

## Common Pitfalls

1. **Inefficient State Representation**: Choose data structures carefully
2. **Missing Base Cases**: Leads to infinite recursion
3. **Improper Backtracking**: Not restoring the state correctly after exploring a path
4. **Ineffective Pruning**: Not eliminating enough invalid paths
5. **Excessive Copying**: Creating new state objects instead of modifying in-place

## When to Use Backtracking

- When you need to find all (or some) solutions to a problem
- When a problem requires trying all possibilities to find the optimal solution
- When the problem can be broken down into a sequence of decisions
- When other techniques like greedy algorithms or dynamic programming don't apply

## Real-World Applications

- Constraint satisfaction problems (scheduling, planning)
- Game playing algorithms (chess, tic-tac-toe)
- Puzzle solving (Sudoku, crosswords)
- Circuit design
- Robot path planning
- Pattern matching
- Machine learning (decision trees)
