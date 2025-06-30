// Binary Tree Level Order Traversal
// Similar to LeetCode 102: Binary Tree Level Order Traversal

/*
Problem Statement:
Given the root of a binary tree, return the level order traversal of its nodes' values.
(i.e., from left to right, level by level).

Example:
Input: root = [3,9,20,null,null,15,7]
    3
   / \
  9  20
    /  \
   15   7
Output: [[3],[9,20],[15,7]]
*/

// Definition for a binary tree node
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.val, [this.left, this.right]);

  @override
  String toString() {
    return 'TreeNode($val)';
  }
}

// Time Complexity: O(n) where n is the number of nodes in the tree
// Space Complexity: O(n) in the worst case for the queue

List<List<int>> levelOrder(TreeNode? root) {
  // Step 1: Handle edge case - empty tree
  if (root == null) {
    return [];
  }

  // Step 2: Initialize result list and queue
  List<List<int>> result = [];
  List<TreeNode> queue = [root]; // Use List as a queue

  // Step 3: Process each level using BFS
  while (queue.isNotEmpty) {
    // Get the number of nodes at the current level
    int levelSize = queue.length;

    // Create a list to store the values at this level
    List<int> currentLevel = [];

    // Process all nodes at the current level
    for (int i = 0; i < levelSize; i++) {
      // Remove the first node from the queue
      TreeNode node = queue.removeAt(0);

      // Add the node's value to the current level
      currentLevel.add(node.val);

      // Add the node's children to the queue for next level processing
      if (node.left != null) {
        queue.add(node.left!);
      }

      if (node.right != null) {
        queue.add(node.right!);
      }

      // Debug: Print current state of processing
      // print('Processed: ${node.val}, Current Level: $currentLevel, Queue: ${queue.map((n) => n.val).toList()}');
    }

    // Add the completed level to the result
    result.add(currentLevel);

    // Debug: Print after processing a level
    // print('Added level: $currentLevel, Result so far: $result');
  }

  return result;
}

/*
Execution trace for the example tree:
    3
   / \
  9  20
    /  \
   15   7

1. Initialize:
   - result = []
   - queue = [Node(3)]

2. First level processing:
   - levelSize = 1 (one node at this level)
   - currentLevel = []
   - Process Node(3):
     - Add 3 to currentLevel => [3]
     - Add children to queue => queue = [Node(9), Node(20)]
   - Add currentLevel to result => result = [[3]]

3. Second level processing:
   - levelSize = 2 (two nodes at this level)
   - currentLevel = []
   - Process Node(9):
     - Add 9 to currentLevel => [9]
     - No children to add
   - Process Node(20):
     - Add 20 to currentLevel => [9, 20]
     - Add children to queue => queue = [Node(15), Node(7)]
   - Add currentLevel to result => result = [[3], [9, 20]]

4. Third level processing:
   - levelSize = 2 (two nodes at this level)
   - currentLevel = []
   - Process Node(15):
     - Add 15 to currentLevel => [15]
     - No children to add
   - Process Node(7):
     - Add 7 to currentLevel => [15, 7]
     - No children to add
   - Add currentLevel to result => result = [[3], [9, 20], [15, 7]]

5. Queue is empty, so we're done.
   - Return result = [[3], [9, 20], [15, 7]]
*/

// Helper function to build a tree from a list representation
// null values in the list represent missing nodes
TreeNode? buildTree(List<int?> values) {
  if (values.isEmpty || values[0] == null) {
    return null;
  }

  TreeNode root = TreeNode(values[0]!);
  List<TreeNode?> nodes = [root];
  int i = 1;

  while (i < values.length) {
    TreeNode? current = nodes.removeAt(0);

    if (current != null) {
      // Left child
      if (i < values.length && values[i] != null) {
        current.left = TreeNode(values[i]!);
      }
      nodes.add(current.left);
      i++;

      // Right child
      if (i < values.length && values[i] != null) {
        current.right = TreeNode(values[i]!);
      }
      nodes.add(current.right);
      i++;
    }
  }

  return root;
}

void main() {
  // Example 1: The tree from the problem statement
  List<int?> values1 = [3, 9, 20, null, null, 15, 7];
  TreeNode? root1 = buildTree(values1);

  print('Tree 1 Level Order Traversal:');
  print(levelOrder(root1)); // Expected: [[3], [9, 20], [15, 7]]

  // Example 2: A more complex tree
  List<int?> values2 = [1, 2, 3, 4, 5, null, 7, null, null, 10, 11];
  TreeNode? root2 = buildTree(values2);

  print('\nTree 2 Level Order Traversal:');
  print(levelOrder(root2)); // Expected: [[1], [2, 3], [4, 5, 7], [10, 11]]

  // Example 3: Single node tree
  List<int?> values3 = [1];
  TreeNode? root3 = buildTree(values3);

  print('\nTree 3 Level Order Traversal:');
  print(levelOrder(root3)); // Expected: [[1]]

  // Example 4: Empty tree
  TreeNode? root4 = null;

  print('\nTree 4 Level Order Traversal:');
  print(levelOrder(root4)); // Expected: []

  // Bonus: DFS Pre-order traversal implementation
  print('\nBonus - Pre-order traversal of Tree 1:');
  print(preOrderTraversal(root1)); // Expected: [3, 9, 20, 15, 7]
}

// Bonus: Depth-First Search (Pre-order) implementation for comparison
List<int> preOrderTraversal(TreeNode? root) {
  List<int> result = [];
  _preOrder(root, result);
  return result;
}

void _preOrder(TreeNode? node, List<int> result) {
  if (node == null) {
    return;
  }

  // Process current node first (pre-order: Node -> Left -> Right)
  result.add(node.val);

  // Process left subtree
  _preOrder(node.left, result);

  // Process right subtree
  _preOrder(node.right, result);
}
