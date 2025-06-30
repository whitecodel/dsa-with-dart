# Fast & Slow Pointers (Tortoise & Hare) Algorithm Pattern

## Overview

The Fast & Slow Pointers pattern (also known as the Tortoise and Hare algorithm) involves using two pointers that move through a data structure at different speeds. This technique is particularly useful for solving problems related to cycles or finding middle elements in linear data structures like linked lists or arrays.

## How It Works

1. Initialize two pointers (slow and fast) at the start of the data structure
2. Move the slow pointer one step at a time and the fast pointer two steps at a time
3. If there's a cycle, the fast pointer will eventually meet the slow pointer
4. If there's no cycle, the fast pointer will reach the end of the structure

## Common Applications

### 1. Cycle Detection

The most famous application of the Fast & Slow Pointers pattern is detecting cycles in a linked list. When both pointers meet inside the cycle, it confirms the presence of a cycle.

### 2. Finding the Start of a Cycle

After detecting a cycle, we can find its starting point by:

- Resetting the slow pointer to the beginning
- Moving both pointers one step at a time
- The meeting point is the start of the cycle

### 3. Finding the Middle Element

By moving the fast pointer twice as fast as the slow pointer, when the fast pointer reaches the end, the slow pointer will be at the middle.

### 4. Finding Kth Element from the End

By giving the fast pointer a head start of k nodes, when it reaches the end, the slow pointer will be at the kth element from the end.

### 5. Palindrome Linked List

Using the fast pointer to find the middle, then reversing the second half and comparing with the first half.

## Time & Space Complexity

- **Time Complexity**: O(n) where n is the size of the data structure
- **Space Complexity**: O(1) as we only use two pointer variables regardless of input size

## When to Use Fast & Slow Pointers

- When dealing with cyclic linked lists or arrays
- When you need to find the middle element in a single pass
- When you need to determine the length of a cycle
- When you want to detect if a linked list has a cycle
- When you need to find a node that fulfills certain positional criteria

## Basic Fast & Slow Pointers Template (Dart)

```dart
// Example for cycle detection in a linked list
bool hasCycle(ListNode head) {
  if (head == null || head.next == null) {
    return false;
  }

  ListNode slow = head;
  ListNode fast = head;

  while (fast != null && fast.next != null) {
    slow = slow.next;         // Move slow pointer by 1 step
    fast = fast.next.next;    // Move fast pointer by 2 steps

    // If slow and fast pointers meet, there is a cycle
    if (slow == fast) {
      return true;
    }
  }

  // If fast reaches end (null), no cycle exists
  return false;
}

// Example for finding middle of a linked list
ListNode findMiddle(ListNode head) {
  if (head == null) {
    return null;
  }

  ListNode slow = head;
  ListNode fast = head;

  // When fast reaches the end, slow will be at the middle
  while (fast != null && fast.next != null) {
    slow = slow.next;
    fast = fast.next.next;
  }

  return slow; // This is the middle node
}
```

## Common Pitfalls

1. **Not handling edge cases**: Empty lists, single-element lists
2. **Off-by-one errors**: Incorrect initialization of pointers or termination conditions
3. **Infinite loops**: Not ensuring progress in each iteration
4. **Incorrect speed ratio**: The typical ratio is 1:2, but some problems might require different ratios

## Mathematical Proof of Cycle Detection

When a cycle exists, the fast pointer will move 2 steps for every 1 step of the slow pointer. If we consider the distance between them, the gap closes by 1 step in each iteration. Eventually, the fast pointer will catch up to the slow pointer.

If the cycle length is L:

- The slow pointer moves at 1 step per iteration
- The fast pointer moves at 2 steps per iteration
- The relative speed is 1 step per iteration
- Therefore, they will meet after at most L iterations within the cycle

## Variations

### 1. Different Speed Ratios

Instead of moving at speeds of 1 and 2, you can use different ratios like 1 and 3 or 2 and 3, depending on the problem requirements.

### 2. Three-Pointer Technique

Some problems might require using three pointers moving at different speeds.

### 3. Detecting Starting Point of a Cycle

After finding a cycle, place the slow pointer back at the start and move both pointers at the same speed. The meeting point is the start of the cycle.

## Real-World Applications

- Cycle detection in data structures
- Optimizing algorithms that would otherwise require multiple passes through a data structure
- Memory leak detection
- Finding duplicates in arrays where elements are in a specific range
- Infinite loop detection in state machines
