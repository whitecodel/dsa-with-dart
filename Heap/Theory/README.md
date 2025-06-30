# Heap

## Overview

A heap is a specialized tree-based data structure that satisfies the heap property. In a max heap, for any node, the value of the node is greater than or equal to the values of its children. In a min heap, for any node, the value is less than or equal to the values of its children.

Heaps are used to implement priority queues and are fundamental in various algorithms like heap sort, finding the k-th smallest/largest elements, and Dijkstra's algorithm for finding shortest paths.

## Key Concepts

### Heap Properties

1. **Structure Property**: A heap is a complete binary tree. All levels are completely filled except possibly the last level, which is filled from left to right.
2. **Heap Property**:
   - **Max Heap**: For every node `i` other than the root, the value of `i` is less than or equal to the value of its parent.
   - **Min Heap**: For every node `i` other than the root, the value of `i` is greater than or equal to the value of its parent.

### Heap Operations

#### Insertion (O(log n))

1. Add the new element to the end of the heap
2. Bubble up the element to its correct position

#### Extraction (O(log n))

1. Remove the root element (max in max-heap, min in min-heap)
2. Move the last element to the root
3. Bubble down the new root to its correct position

#### Peek (O(1))

1. Return the value of the root without removing it

#### Heapify (O(n))

1. Convert an unsorted array into a heap structure

### Binary Heap Implementation

A binary heap can be efficiently represented using an array:

- For a node at index `i`:
  - Parent: `(i - 1) // 2`
  - Left child: `2 * i + 1`
  - Right child: `2 * i + 2`

## Implementation in Dart

Here's a basic implementation of a min heap in Dart:

```dart
class MinHeap {
  List<int> _heap = [];

  // Get the current size of the heap
  int get size => _heap.length;

  // Check if the heap is empty
  bool get isEmpty => _heap.isEmpty;

  // Get the minimum element without removing it
  int peek() {
    if (isEmpty) throw Exception("Heap is empty");
    return _heap[0];
  }

  // Insert a new value into the heap
  void insert(int value) {
    _heap.add(value);
    _siftUp(_heap.length - 1);
  }

  // Remove and return the minimum element
  int extractMin() {
    if (isEmpty) throw Exception("Heap is empty");

    final min = _heap[0];
    final lastElement = _heap.removeLast();

    if (!isEmpty) {
      _heap[0] = lastElement;
      _siftDown(0);
    }

    return min;
  }

  // Bubble up to maintain heap property
  void _siftUp(int index) {
    final child = _heap[index];

    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      if (_heap[parentIndex] <= child) break;

      _heap[index] = _heap[parentIndex];
      index = parentIndex;
    }

    _heap[index] = child;
  }

  // Bubble down to maintain heap property
  void _siftDown(int index) {
    int length = _heap.length;
    int element = _heap[index];

    while (true) {
      int leftChildIdx = 2 * index + 1;
      int rightChildIdx = 2 * index + 2;
      int smallestIdx = index;

      // Compare with left child
      if (leftChildIdx < length && _heap[leftChildIdx] < _heap[smallestIdx]) {
        smallestIdx = leftChildIdx;
      }

      // Compare with right child
      if (rightChildIdx < length && _heap[rightChildIdx] < _heap[smallestIdx]) {
        smallestIdx = rightChildIdx;
      }

      if (smallestIdx == index) break;

      // Swap with the smallest child
      _heap[index] = _heap[smallestIdx];
      _heap[smallestIdx] = element;
      index = smallestIdx;
    }
  }
}
```

## Applications

1. **Priority Queue**: A heap is the most efficient implementation of a priority queue.
2. **Heap Sort**: An efficient comparison-based sorting algorithm with O(n log n) complexity.
3. **Selection Algorithms**: Finding the k-th smallest/largest element in an array.
4. **Graph Algorithms**: Dijkstra's shortest path, Prim's minimum spanning tree.
5. **Media Streaming**: For buffering data in media applications.
6. **Event-driven Simulation**: Managing events by their scheduled time.

## Common Patterns in Heap Problems

1. **Top-K Pattern**: Finding k largest/smallest elements or frequently occurring elements.
2. **Merge K Sorted Pattern**: Combining multiple sorted arrays into a single sorted array.
3. **Two-Heaps Pattern**: Using two heaps to track median of a stream or similar problems.
4. **Scheduling Pattern**: Task scheduling based on time constraints and priorities.

## Complexity Analysis

- **Space Complexity**: O(n) for storing n elements
- **Time Complexity**:
  - Insert: O(log n)
  - Extract Min/Max: O(log n)
  - Peek: O(1)
  - Heapify: O(n)
  - Building a heap from an array: O(n)

## Dart-Specific Notes

Dart doesn't have a built-in heap implementation in the standard library, but you can:

1. Implement your own as shown above
2. Use packages like `collection` which provide a PriorityQueue implementation (which functions like a heap)

## When to Use Heaps

- When you need to repeatedly find the minimum or maximum element
- When you need to efficiently implement a priority queue
- When you need to process elements in a specific order, but don't need a fully sorted structure
- When you need to find top-k elements in a large dataset
