// Linked List Cycle Detection
// Similar to LeetCode 141: Linked List Cycle

/*
Problem Statement:
Given the head of a linked list, determine if the linked list has a cycle in it.
There is a cycle in a linked list if there is some node in the list that can be 
reached again by continuously following the next pointer.

Example:
Input: head = [3,2,0,-4], where -4 points back to 2
Visual representation: 3 -> 2 -> 0 -> -4
                           ^         |
                           |_________|
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).
*/

// Define a basic LinkedList Node class
class ListNode {
  int val;
  ListNode? next;

  ListNode(this.val, [this.next]);

  // Helper to create string representation
  @override
  String toString() {
    return 'Node($val)';
  }
}

// Time Complexity: O(n) where n is the number of nodes in the linked list
// Space Complexity: O(1) as we only use two pointers regardless of input size

bool hasCycle(ListNode? head) {
  // Step 1: Handle edge cases
  if (head == null || head.next == null) {
    // An empty list or a list with only one node cannot have a cycle
    return false;
  }

  // Step 2: Initialize the slow and fast pointers
  ListNode? slow = head; // Tortoise - moves 1 step at a time
  ListNode? fast = head; // Hare - moves 2 steps at a time

  // Step 3: Move pointers until they meet or fast reaches the end
  // The fast pointer will reach the end if there's no cycle
  while (fast != null && fast.next != null) {
    // Move slow pointer one step forward
    slow = slow!.next;

    // Move fast pointer two steps forward
    fast = fast.next!.next;

    // Debug: Show current positions
    // print('Slow pointer at: ${slow}, Fast pointer at: ${fast}');

    // Step 4: Check if pointers meet, indicating a cycle
    if (slow == fast) {
      // print('Cycle detected! Pointers met at ${slow}');
      return true;
    }
  }

  // Step 5: If fast pointer reached null, there's no cycle
  // print('No cycle detected. Fast pointer reached the end of list');
  return false;
}

/*
Execution trace for a linked list with a cycle:
Consider the list: 3 -> 2 -> 0 -> -4 -> (back to 2)

1. Initialize:
   - slow = Node(3)
   - fast = Node(3)

2. Iteration 1:
   - slow moves to Node(2)
   - fast moves to Node(0)
   - slow != fast, continue

3. Iteration 2:
   - slow moves to Node(0)
   - fast moves to Node(2) (after moving from -4 back to 2 due to the cycle)
   - slow != fast, continue

4. Iteration 3:
   - slow moves to Node(-4)
   - fast moves to Node(0) (after moving from 2 to 0)
   - slow != fast, continue

5. Iteration 4:
   - slow moves to Node(2) (completes one trip around the cycle)
   - fast moves to Node(-4) (completes two trips around the cycle)
   - slow != fast, continue

6. Iteration 5:
   - slow moves to Node(0)
   - fast moves to Node(2)
   - slow != fast, continue

7. Iteration 6:
   - slow moves to Node(-4)
   - fast moves to Node(0)
   - slow != fast, continue

8. Iteration 7:
   - slow moves to Node(2)
   - fast moves to Node(-4)
   - slow != fast, continue

9. Iteration 8:
   - slow moves to Node(0)
   - fast moves to Node(2)
   - slow != fast, continue

10. Eventually, the pointers will meet. The exact iteration depends on the starting positions
    and the length of the cycle, but they are guaranteed to meet if a cycle exists.

Result: true (a cycle exists)
*/

// Function to create a test linked list with a cycle
ListNode createLinkedListWithCycle() {
  ListNode node1 = ListNode(3);
  ListNode node2 = ListNode(2);
  ListNode node3 = ListNode(0);
  ListNode node4 = ListNode(-4);

  node1.next = node2;
  node2.next = node3;
  node3.next = node4;
  node4.next = node2; // Creates a cycle back to node2

  return node1;
}

// Function to create a test linked list without a cycle
ListNode createLinkedListWithoutCycle() {
  ListNode node1 = ListNode(1);
  ListNode node2 = ListNode(2);
  ListNode node3 = ListNode(3);
  ListNode node4 = ListNode(4);

  node1.next = node2;
  node2.next = node3;
  node3.next = node4;

  return node1;
}

void main() {
  // Test case 1: List with a cycle
  ListNode head1 = createLinkedListWithCycle();
  print('List with cycle: ${hasCycle(head1)}'); // Expected: true

  // Test case 2: List without a cycle
  ListNode head2 = createLinkedListWithoutCycle();
  print('List without cycle: ${hasCycle(head2)}'); // Expected: false

  // Test case 3: Single node with self-cycle
  ListNode head3 = ListNode(1);
  head3.next = head3; // Points to itself
  print('Single node with self-cycle: ${hasCycle(head3)}'); // Expected: true

  // Test case 4: Single node without cycle
  ListNode head4 = ListNode(1);
  print('Single node without cycle: ${hasCycle(head4)}'); // Expected: false

  // Test case 5: Empty list
  print('Empty list: ${hasCycle(null)}'); // Expected: false
}
