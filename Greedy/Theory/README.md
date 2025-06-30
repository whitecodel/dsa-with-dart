# Greedy Algorithm Pattern

## Overview

Greedy algorithms make locally optimal choices at each step with the hope of finding a global optimum. These algorithms choose the best option at the current stage without considering the bigger picture, making them efficient but not always correct for all problems.

## How Greedy Algorithms Work

1. Make the optimal choice at each step based on a specific criterion
2. Reduce the problem to a smaller subproblem
3. Repeat until the problem is solved

## Properties of Greedy Algorithms

### Advantages

- Simple and intuitive
- Usually efficient with good time complexity
- Often easier to implement than other approaches
- Works well for many optimization problems

### Limitations

- Does not guarantee globally optimal solutions for all problems
- Requires proof of correctness for each specific problem
- Not applicable to problems with complex constraints or dependencies

## When to Use Greedy Algorithms

Greedy algorithms are suitable when:

1. The problem has **optimal substructure** (optimal solution contains optimal solutions to subproblems)
2. The problem has the **greedy choice property** (locally optimal choices lead to a globally optimal solution)
3. Local decisions can be made without reconsidering previous choices

## Common Greedy Problem Patterns

### 1. Selection Problems

- Select items based on a specific criterion (largest, smallest, ratio, etc.)
- Examples: Activity selection, job scheduling

### 2. Optimization Problems

- Minimize or maximize a value
- Examples: Huffman coding, Prim's and Kruskal's algorithms

### 3. Constructive Algorithms

- Build a solution piece by piece
- Examples: Fractional knapsack, coin change with unlimited denominations

### 4. Graph Algorithms

- Many graph algorithms use greedy strategies
- Examples: Dijkstra's algorithm, minimum spanning trees

## Time & Space Complexity

- **Time Complexity**: Usually O(n log n) due to sorting, or O(n) if sorting isn't needed
- **Space Complexity**: Usually O(n) or O(1), depending on implementation

## Basic Greedy Template in Dart

```dart
// Generic greedy algorithm template
List<Item> greedySelection(List<Item> items, Function comparator) {
  // 1. Sort items based on the greedy criterion
  items.sort(comparator);

  List<Item> result = [];

  // 2. Iterate through sorted items
  for (Item item in items) {
    // 3. Apply selection logic
    if (isValid(item)) {
      result.add(item);
      // 4. Update state if necessary
      updateState(item);
    }
  }

  return result;
}
```

## Example: Fractional Knapsack

```dart
class Item {
  double weight;
  double value;
  double valuePerWeight;

  Item(this.weight, this.value) {
    valuePerWeight = value / weight;
  }
}

double fractionalKnapsack(List<Item> items, double capacity) {
  // Sort items by value per weight in descending order
  items.sort((a, b) => b.valuePerWeight.compareTo(a.valuePerWeight));

  double totalValue = 0.0;
  double currentWeight = 0.0;

  for (Item item in items) {
    if (currentWeight + item.weight <= capacity) {
      // Take the whole item
      currentWeight += item.weight;
      totalValue += item.value;
    } else {
      // Take a fraction of the item
      double remainingCapacity = capacity - currentWeight;
      totalValue += item.valuePerWeight * remainingCapacity;
      break; // Knapsack is full
    }
  }

  return totalValue;
}
```

## Common Greedy Problems

1. **Activity Selection**: Select maximum activities that don't overlap
2. **Fractional Knapsack**: Fill knapsack with items to maximize value
3. **Huffman Coding**: Optimal prefix codes for data compression
4. **Minimum Coin Change**: Make change with minimum number of coins
5. **Job Sequencing with Deadlines**: Schedule jobs to maximize profit
6. **Minimum Spanning Trees**: Prim's and Kruskal's algorithms
7. **Dijkstra's Shortest Path**: Find shortest path in a weighted graph

## Proving Greedy Algorithms

To prove a greedy algorithm is correct:

1. **Greedy choice property**: Show that making the greedy choice is always safe
2. **Optimal substructure**: Show that the subproblem after making the greedy choice leads to an optimal solution

## Common Pitfalls

1. **Incorrectly assuming greedy works**: Not all problems with optimal substructure can be solved greedily
2. **Wrong greedy criterion**: Choosing the wrong metric for optimization
3. **Not handling edge cases**: Special cases that break the greedy approach
4. **Ties in greedy criterion**: Not specifying how to break ties between equal choices

## Real-World Applications

- Network routing algorithms
- Scheduling systems
- Resource allocation
- Data compression
- Machine learning feature selection
- Financial algorithms (e.g., portfolio optimization)
- Load balancing in distributed systems

## When Greedy Fails

Greedy algorithms may not work for problems like:

1. **0/1 Knapsack**: Items must be taken completely or not at all
2. **Traveling Salesman Problem**: Finding the shortest route visiting all cities
3. **General Shortest Path with Negative Edges**: Dijkstra's algorithm fails
4. **Subset Sum**: Finding a subset that sums to a specific value

For these problems, techniques like dynamic programming, backtracking, or branch and bound are more appropriate.
