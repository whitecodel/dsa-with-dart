// Topological Sort: Course Schedule
//
// Problem: There are a total of numCourses courses you have to take, labeled from 0 to
// numCourses-1. Some courses may have prerequisites, for example, to take course 0 you
// have to first take course 1, which is expressed as a pair: [0,1]. Given the total
// number of courses and a list of prerequisite pairs, determine if it is possible for
// you to finish all courses.
//
// Example 1:
// Input: numCourses = 2, prerequisites = [[1,0]]
// Output: true
// Explanation: There are 2 courses to take. To take course 1 you should have finished course 0.
//
// Example 2:
// Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
// Output: false
// Explanation: There are 2 courses to take. To take course 1 you should have finished course 0,
// and to take course 0 you should have finished course 1. This is impossible.
//
// This problem demonstrates the application of topological sort to detect cycles in a directed graph.

// Function to check if it is possible to finish all courses
bool canFinish(int numCourses, List<List<int>> prerequisites) {
  // Create adjacency list to represent the graph
  List<List<int>> graph = List.generate(numCourses, (_) => []);

  // Create in-degree array for each node
  List<int> inDegree = List.filled(numCourses, 0);

  // Build the graph from prerequisites
  for (List<int> prerequisite in prerequisites) {
    int course = prerequisite[0]; // The course to take
    int prereq = prerequisite[1]; // Its prerequisite

    // Add an edge from prereq to course
    graph[prereq].add(course);

    // Increment in-degree of the course
    inDegree[course]++;
  }

  // Queue for topological sort (start with all nodes having in-degree 0)
  List<int> queue = [];
  for (int i = 0; i < numCourses; i++) {
    if (inDegree[i] == 0) {
      queue.add(i);
    }
  }

  // Counter for visited nodes
  int visited = 0;

  // Process nodes with in-degree 0
  while (queue.isNotEmpty) {
    int current = queue.removeAt(0);
    visited++;

    // Decrease in-degree of all adjacent nodes
    for (int neighbor in graph[current]) {
      inDegree[neighbor]--;

      // If in-degree becomes 0, add to queue
      if (inDegree[neighbor] == 0) {
        queue.add(neighbor);
      }
    }
  }

  // If all nodes are visited, then there is no cycle and courses can be completed
  return visited == numCourses;
}

// Test function
void main() {
  // Test cases
  int numCourses1 = 2;
  List<List<int>> prerequisites1 = [
    [1, 0],
  ];

  int numCourses2 = 2;
  List<List<int>> prerequisites2 = [
    [1, 0],
    [0, 1],
  ];

  int numCourses3 = 4;
  List<List<int>> prerequisites3 = [
    [1, 0],
    [2, 1],
    [3, 2],
  ];

  print('Input: numCourses = $numCourses1, prerequisites = $prerequisites1');
  print('Output: ${canFinish(numCourses1, prerequisites1)}');

  print('\nInput: numCourses = $numCourses2, prerequisites = $prerequisites2');
  print('Output: ${canFinish(numCourses2, prerequisites2)}');

  print('\nInput: numCourses = $numCourses3, prerequisites = $prerequisites3');
  print('Output: ${canFinish(numCourses3, prerequisites3)}');

  // Detailed explanation
  print('\nDetailed explanation for numCourses = 2, prerequisites = [[1,0]]:');
  print('1. Build graph:');
  print('   - Adjacency list: [[1], []]  (0 -> 1)');
  print('   - In-degree: [0, 1]');

  print('\n2. Initialize queue with nodes having in-degree 0:');
  print('   - Queue: [0]');

  print('\n3. Start topological sort:');
  print('   - Process node 0:');
  print('     * Visited = 1');
  print('     * Decrease in-degree of neighbors: in-degree[1] = 0');
  print('     * Add node 1 to queue: Queue = [1]');

  print('   - Process node 1:');
  print('     * Visited = 2');
  print('     * No neighbors to process');

  print('\n4. Visited = 2 equals numCourses = 2, so return true');

  print(
    '\nDetailed explanation for numCourses = 2, prerequisites = [[1,0],[0,1]]:',
  );
  print('1. Build graph:');
  print('   - Adjacency list: [[1], [0]]  (0 -> 1, 1 -> 0)');
  print('   - In-degree: [1, 1]');

  print('\n2. Initialize queue with nodes having in-degree 0:');
  print('   - Queue: []  (No nodes have in-degree 0, indicating a cycle)');

  print('\n3. Queue is empty, so visited = 0');
  print('\n4. Visited = 0 is not equal to numCourses = 2, so return false');
}

/* Execution Trace:
1. canFinish(2, [[1,0]]) is called:
   - Build graph:
     - Adjacency list: [[1], []]  (0 -> 1)
     - In-degree: [0, 1]
   
   - Initialize queue with nodes having in-degree 0:
     - Queue: [0]
   
   - Start topological sort:
     - Process node 0:
       * Visited = 1
       * Decrease in-degree of neighbors: in-degree[1] = 0
       * Add node 1 to queue: Queue = [1]
     
     - Process node 1:
       * Visited = 2
       * No neighbors to process
   
   - Visited = 2 equals numCourses = 2, so return true

2. canFinish(2, [[1,0],[0,1]]) is called:
   - Build graph:
     - Adjacency list: [[1], [0]]  (0 -> 1, 1 -> 0)
     - In-degree: [1, 1]
   
   - Initialize queue with nodes having in-degree 0:
     - Queue: []  (No nodes have in-degree 0, indicating a cycle)
   
   - Queue is empty, so visited = 0
   
   - Visited = 0 is not equal to numCourses = 2, so return false

3. The second case has a cycle (0 depends on 1, and 1 depends on 0), 
   making it impossible to complete all courses.

Output:
Input: numCourses = 2, prerequisites = [[1, 0]]
Output: true

Input: numCourses = 2, prerequisites = [[1, 0], [0, 1]]
Output: false

Input: numCourses = 4, prerequisites = [[1, 0], [2, 1], [3, 2]]
Output: true

Detailed explanation for numCourses = 2, prerequisites = [[1,0]]:
1. Build graph:
   - Adjacency list: [[1], []]  (0 -> 1)
   - In-degree: [0, 1]

2. Initialize queue with nodes having in-degree 0:
   - Queue: [0]

3. Start topological sort:
   - Process node 0:
     * Visited = 1
     * Decrease in-degree of neighbors: in-degree[1] = 0
     * Add node 1 to queue: Queue = [1]
   - Process node 1:
     * Visited = 2
     * No neighbors to process

4. Visited = 2 equals numCourses = 2, so return true

Detailed explanation for numCourses = 2, prerequisites = [[1,0],[0,1]]:
1. Build graph:
   - Adjacency list: [[1], [0]]  (0 -> 1, 1 -> 0)
   - In-degree: [1, 1]

2. Initialize queue with nodes having in-degree 0:
   - Queue: []  (No nodes have in-degree 0, indicating a cycle)

3. Queue is empty, so visited = 0

4. Visited = 0 is not equal to numCourses = 2, so return false
*/
