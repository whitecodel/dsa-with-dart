// Middle of the Linked List
// Problem: Given the head of a singly linked list, return the middle node of the linked list.
// If there are two middle nodes (even length), return the second middle node.
//
// Example:
//   Input: head = [1,2,3,4,5]
//   Output: [3,4,5]
//   Explanation: The middle node of the list is node 3.
//
//   Input: head = [1,2,3,4,5,6]
//   Output: [4,5,6]
//   Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.

// Definition for singly-linked list node
class ListNode {
  int val;
  ListNode? next;

  ListNode(this.val, [this.next]);

  @override
  String toString() {
    List<int> values = [];
    ListNode? current = this;
    while (current != null) {
      values.add(current.val);
      current = current.next;
    }
    return values.toString();
  }
}

// Fast & Slow Pointers solution to find the middle node
//
// Time Complexity: O(n) - Single pass through the list
// Space Complexity: O(1) - Only uses two pointers regardless of input size
ListNode? middleNode(ListNode? head) {
  // Edge case: empty list or single node
  if (head == null || head.next == null) {
    return head;
  }

  // Initialize slow and fast pointers at the head
  ListNode? slow = head;
  ListNode? fast = head;

  // Move slow one step and fast two steps at a time
  // When fast reaches the end, slow will be at the middle
  while (fast != null && fast.next != null) {
    slow = slow!.next; // Move slow pointer one step
    fast = fast.next!.next; // Move fast pointer two steps
  }

  // When the loop ends, slow will be at the middle node
  return slow;
}

// Execution trace for [1,2,3,4,5]:
// - Initialize slow = node 1, fast = node 1
// - Iteration 1: slow moves to node 2, fast moves to node 3
// - Iteration 2: slow moves to node 3, fast moves to node 5
// - Iteration 3: fast.next is null, exit loop
// - Return slow pointing to node 3
//
// Execution trace for [1,2,3,4,5,6]:
// - Initialize slow = node 1, fast = node 1
// - Iteration 1: slow moves to node 2, fast moves to node 3
// - Iteration 2: slow moves to node 3, fast moves to node 5
// - Iteration 3: slow moves to node 4, fast moves to null (fast.next.next)
// - Exit loop, return slow pointing to node 4

void main() {
  // Test Case 1: Odd length list [1,2,3,4,5]
  var head1 = ListNode(1);
  head1.next = ListNode(2);
  head1.next!.next = ListNode(3);
  head1.next!.next!.next = ListNode(4);
  head1.next!.next!.next!.next = ListNode(5);

  // Test Case 2: Even length list [1,2,3,4,5,6]
  var head2 = ListNode(1);
  head2.next = ListNode(2);
  head2.next!.next = ListNode(3);
  head2.next!.next!.next = ListNode(4);
  head2.next!.next!.next!.next = ListNode(5);
  head2.next!.next!.next!.next!.next = ListNode(6);

  // Test Case 3: Single node [1]
  var head3 = ListNode(1);

  // Test Case 4: Two nodes [1,2]
  var head4 = ListNode(1);
  head4.next = ListNode(2);

  // Run test cases
  var testCases = [
    {"list": head1, "expected": 3},
    {"list": head2, "expected": 4},
    {"list": head3, "expected": 1},
    {"list": head4, "expected": 2},
  ];

  for (int i = 0; i < testCases.length; i++) {
    var head = testCases[i]["list"] as ListNode;
    var expected = testCases[i]["expected"] as int;

    print('Test case ${i + 1}: Original List = $head');

    var result = middleNode(head);
    print('Middle node: ${result?.val} (${result.toString()})');
    print('Expected middle node value: $expected');
    print(result?.val == expected ? 'PASS' : 'FAIL');
    print('---');
  }
}
