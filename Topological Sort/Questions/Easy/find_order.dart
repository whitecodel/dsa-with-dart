// Find Order (Course Schedule II)
// Problem: There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1.
// You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take
// course bi first if you want to take course ai.
//
// Return the ordering of courses you should take to finish all courses. If there are many valid answers,
// return any of them. If it is impossible to finish all courses, return an empty array.
//
// Example:
//   Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
//   Output: [0,1,2,3] or [0,2,1,3]
//   Explanation: There are a total of 4 courses to take. To take course 3, you need to finish courses 1 and 2.
//   Both courses 1 and 2 should be taken after course 0. So one correct course order is [0,1,2,3].
//   Another correct ordering is [0,2,1,3].
//
//   Input: numCourses = 2, prerequisites = [[1,0]]
//   Output: [0,1]
//   Explanation: There are a total of 2 courses to take. To take course 1, you need to finish course 0.
//
//   Input: numCourses = 1, prerequisites = []
//   Output: [0]

// Topological Sort solution to find the order of courses
//
// Time Complexity: O(V+E) where V is the number of vertices (courses) and E is the number of edges (prerequisites)
// Space Complexity: O(V+E) for the adjacency list and visited arrays
List<int> findOrder(int numCourses, List<List<int>> prerequisites) {
  // Result list to store the topological ordering
  List<int> result = [];

  // Create an adjacency list to represent the graph
  List<List<int>> graph = List.generate(numCourses, (_) => []);

  // Fill the adjacency list
  for (var prereq in prerequisites) {
    int course = prereq[0];
    int prerequisite = prereq[1];
    graph[prerequisite].add(course); // Prerequisite -> Course
  }

  // Track visited nodes (0: unvisited, 1: visiting, 2: visited)
  List<int> visited = List.filled(numCourses, 0);

  // DFS function to detect cycles and build topological sort
  bool hasCycle(int node) {
    // If we're currently visiting this node, we found a cycle
    if (visited[node] == 1) {
      return true;
    }

    // If already processed, skip
    if (visited[node] == 2) {
      return false;
    }

    // Mark as currently visiting
    visited[node] = 1;

    // Visit all neighbors
    for (int neighbor in graph[node]) {
      if (hasCycle(neighbor)) {
        return true;
      }
    }

    // Mark as fully visited
    visited[node] = 2;

    // Add to result (after all dependencies are processed)
    result.add(node);

    return false;
  }

  // Visit all nodes
  for (int i = 0; i < numCourses; i++) {
    if (visited[i] == 0) {
      if (hasCycle(i)) {
        // If a cycle is detected, it's impossible to finish all courses
        return [];
      }
    }
  }

  // Reverse the result for correct topological order
  return result.reversed.toList();
}

// Execution trace for numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]:
//
// 1. Create graph:
//    - graph[0] = [1, 2]  (Course 0 is a prerequisite for courses 1 and 2)
//    - graph[1] = [3]     (Course 1 is a prerequisite for course 3)
//    - graph[2] = [3]     (Course 2 is a prerequisite for course 3)
//    - graph[3] = []      (Course 3 has no dependent courses)
//
// 2. Initialize visited = [0, 0, 0, 0] and result = []
//
// 3. Start DFS with course 0:
//    - Mark visited[0] = 1 (currently visiting)
//    - Visit neighbors of 0:
//      - Neighbor 1:
//        - Mark visited[1] = 1 (currently visiting)
//        - Visit neighbors of 1:
//          - Neighbor 3:
//            - Mark visited[3] = 1 (currently visiting)
//            - No neighbors of 3
//            - Mark visited[3] = 2 (fully visited)
//            - Add 3 to result: result = [3]
//        - Mark visited[1] = 2 (fully visited)
//        - Add 1 to result: result = [3, 1]
//      - Neighbor 2:
//        - Mark visited[2] = 1 (currently visiting)
//        - Visit neighbors of 2:
//          - Neighbor 3 (already visited, skip)
//        - Mark visited[2] = 2 (fully visited)
//        - Add 2 to result: result = [3, 1, 2]
//    - Mark visited[0] = 2 (fully visited)
//    - Add 0 to result: result = [3, 1, 2, 0]
//
// 4. All nodes visited, no cycles found
//
// 5. Reverse result: [0, 2, 1, 3]
//
// Note: Another valid output could be [0, 1, 2, 3] depending on the order of traversal.

void main() {
  // Test cases
  List<Map<String, dynamic>> testCases = [
    {
      'numCourses': 4,
      'prerequisites': [
        [1, 0],
        [2, 0],
        [3, 1],
        [3, 2],
      ],
      'expected': true, // Has valid ordering
    },
    {
      'numCourses': 2,
      'prerequisites': [
        [1, 0],
      ],
      'expected': true, // Has valid ordering
    },
    {
      'numCourses': 1,
      'prerequisites': [],
      'expected': true, // Has valid ordering
    },
    {
      'numCourses': 2,
      'prerequisites': [
        [1, 0],
        [0, 1],
      ],
      'expected': false, // Has cycle, no valid ordering
    },
    {
      'numCourses': 5,
      'prerequisites': [
        [1, 0],
        [2, 1],
        [3, 2],
        [4, 3],
      ],
      'expected': true, // Linear prerequisites
    },
    {
      'numCourses': 6,
      'prerequisites': [
        [1, 0],
        [2, 1],
        [3, 0],
        [4, 3],
        [5, 4],
      ],
      'expected': true, // Tree structure
    },
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    Map<String, dynamic> testCase = testCases[i];
    int numCourses = testCase['numCourses'];
    List<List<int>> prerequisites = List<List<int>>.from(
      testCase['prerequisites'],
    );

    print('Test case ${i + 1}:');
    print('numCourses: $numCourses');
    print('prerequisites: $prerequisites');

    List<int> result = findOrder(numCourses, prerequisites);

    print('Result: $result');
    print(
      'Expected: ${testCase['expected'] ? "Valid ordering" : "No valid ordering"}',
    );

    if (testCase['expected']) {
      print(result.isNotEmpty ? 'PASS' : 'FAIL');

      // Verify if the ordering is valid
      if (result.isNotEmpty) {
        bool isValid = isValidOrdering(result, numCourses, prerequisites);
        print('Valid ordering: ${isValid ? "Yes" : "No"}');
      }
    } else {
      print(result.isEmpty ? 'PASS' : 'FAIL');
    }

    print('---');
  }
}

// Check if the ordering is valid given the prerequisites
bool isValidOrdering(
  List<int> order,
  int numCourses,
  List<List<int>> prerequisites,
) {
  // Check if all courses are included
  if (order.length != numCourses) {
    return false;
  }

  // Track the position of each course in the order
  Map<int, int> positionMap = {};
  for (int i = 0; i < order.length; i++) {
    positionMap[order[i]] = i;
  }

  // Check if all prerequisites are satisfied
  for (var prereq in prerequisites) {
    int course = prereq[0];
    int prerequisite = prereq[1];

    // The prerequisite should come before the course
    if (positionMap[prerequisite]! >= positionMap[course]!) {
      return false;
    }
  }

  return true;
}
