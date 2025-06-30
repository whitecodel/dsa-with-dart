// Heap: K-th Largest Element in an Array
//
// Problem: Find the kth largest element in an unsorted array.
//
// Example:
// Input: [3, 2, 1, 5, 6, 4], k = 2
// Output: 5
// Explanation: The 2nd largest element is 5.
//
// This problem demonstrates using a min-heap to efficiently find the kth largest element.
// The key insight is to maintain a heap of size k with the smallest element on top.

// Implementation of a simple MinHeap
class MinHeap {
  List<int> _heap = [];

  MinHeap();

  int get length => _heap.length;

  bool get isEmpty => _heap.isEmpty;

  int peek() {
    if (isEmpty) throw Exception("Heap is empty");
    return _heap[0];
  }

  void add(int value) {
    _heap.add(value);
    _siftUp(_heap.length - 1);
  }

  int remove() {
    if (isEmpty) throw Exception("Heap is empty");

    int result = _heap[0];
    int last = _heap.removeLast();

    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _siftDown(0);
    }

    return result;
  }

  void _siftUp(int index) {
    int value = _heap[index];

    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      int parent = _heap[parentIndex];

      if (parent <= value) break;

      _heap[index] = parent;
      index = parentIndex;
    }

    _heap[index] = value;
  }

  void _siftDown(int index) {
    int length = _heap.length;
    int element = _heap[index];

    while (true) {
      int leftChildIdx = 2 * index + 1;
      int rightChildIdx = 2 * index + 2;
      int smallestIdx = index;

      if (leftChildIdx < length && _heap[leftChildIdx] < _heap[smallestIdx]) {
        smallestIdx = leftChildIdx;
      }

      if (rightChildIdx < length && _heap[rightChildIdx] < _heap[smallestIdx]) {
        smallestIdx = rightChildIdx;
      }

      if (smallestIdx == index) break;

      _heap[index] = _heap[smallestIdx];
      _heap[smallestIdx] = element;
      index = smallestIdx;
    }
  }
}

// Function to find the kth largest element in an array
int findKthLargest(List<int> nums, int k) {
  // Create a min-heap to maintain the k largest elements
  MinHeap heap = MinHeap();

  // Process each element in the array
  for (int num in nums) {
    // Add the element to the heap
    heap.add(num);

    // If heap size exceeds k, remove the smallest element
    if (heap.length > k) {
      heap.remove();
    }
  }

  // The root of the heap is the kth largest element
  return heap.peek();
}

// Test function
void main() {
  // Test cases
  List<int> nums1 = [3, 2, 1, 5, 6, 4];
  int k1 = 2;

  List<int> nums2 = [3, 2, 3, 1, 2, 4, 5, 5, 6];
  int k2 = 4;

  print('Input: nums = $nums1, k = $k1');
  print('Output: ${findKthLargest(nums1, k1)}');

  print('\nInput: nums = $nums2, k = $k2');
  print('Output: ${findKthLargest(nums2, k2)}');

  // Detailed explanation
  print('\nDetailed explanation for [3, 2, 1, 5, 6, 4] with k = 2:');
  print('1. Process nums[0] = 3:');
  print('   - Add 3 to heap -> Heap: [3]');
  print('   - Heap size = 1 <= k, so continue');

  print('\n2. Process nums[1] = 2:');
  print('   - Add 2 to heap -> Heap: [2, 3]');
  print('   - Heap size = 2 <= k, so continue');

  print('\n3. Process nums[2] = 1:');
  print('   - Add 1 to heap -> Heap: [1, 3, 2]');
  print('   - Heap size = 3 > k, so remove min (1) -> Heap: [2, 3]');

  print('\n4. Process nums[3] = 5:');
  print('   - Add 5 to heap -> Heap: [2, 3, 5]');
  print('   - Heap size = 3 > k, so remove min (2) -> Heap: [3, 5]');

  print('\n5. Process nums[4] = 6:');
  print('   - Add 6 to heap -> Heap: [3, 5, 6]');
  print('   - Heap size = 3 > k, so remove min (3) -> Heap: [5, 6]');

  print('\n6. Process nums[5] = 4:');
  print('   - Add 4 to heap -> Heap: [4, 6, 5]');
  print('   - Heap size = 3 > k, so remove min (4) -> Heap: [5, 6]');

  print('\n7. Final heap: [5, 6]');
  print('   - The 2nd largest element is the root of the heap: 5');
}

/* Execution Trace:
1. findKthLargest([3, 2, 1, 5, 6, 4], 2) is called:
   - Initialize an empty min-heap
   
   - Process nums[0] = 3:
     - Add 3 to heap -> Heap: [3]
     - Heap size = 1 <= k, so continue
     
   - Process nums[1] = 2:
     - Add 2 to heap -> Heap: [2, 3] (min-heap property ensures smaller value at root)
     - Heap size = 2 <= k, so continue
     
   - Process nums[2] = 1:
     - Add 1 to heap -> Heap: [1, 2, 3]
     - Heap size = 3 > k, so remove min (1) -> Heap: [2, 3]
     
   - Process nums[3] = 5:
     - Add 5 to heap -> Heap: [2, 3, 5]
     - Heap size = 3 > k, so remove min (2) -> Heap: [3, 5]
     
   - Process nums[4] = 6:
     - Add 6 to heap -> Heap: [3, 5, 6]
     - Heap size = 3 > k, so remove min (3) -> Heap: [5, 6]
     
   - Process nums[5] = 4:
     - Add 4 to heap -> Heap: [4, 5, 6]
     - Heap size = 3 > k, so remove min (4) -> Heap: [5, 6]
     
   - Return the root of the heap: 5
   
2. The 2nd largest element in [3, 2, 1, 5, 6, 4] is 5.

Output:
Input: nums = [3, 2, 1, 5, 6, 4], k = 2
Output: 5

Input: nums = [3, 2, 3, 1, 2, 4, 5, 5, 6], k = 4
Output: 4

Detailed explanation for [3, 2, 1, 5, 6, 4] with k = 2:
1. Process nums[0] = 3:
   - Add 3 to heap -> Heap: [3]
   - Heap size = 1 <= k, so continue

2. Process nums[1] = 2:
   - Add 2 to heap -> Heap: [2, 3]
   - Heap size = 2 <= k, so continue

3. Process nums[2] = 1:
   - Add 1 to heap -> Heap: [1, 3, 2]
   - Heap size = 3 > k, so remove min (1) -> Heap: [2, 3]

4. Process nums[3] = 5:
   - Add 5 to heap -> Heap: [2, 3, 5]
   - Heap size = 3 > k, so remove min (2) -> Heap: [3, 5]

5. Process nums[4] = 6:
   - Add 6 to heap -> Heap: [3, 5, 6]
   - Heap size = 3 > k, so remove min (3) -> Heap: [5, 6]

6. Process nums[5] = 4:
   - Add 4 to heap -> Heap: [4, 6, 5]
   - Heap size = 3 > k, so remove min (4) -> Heap: [5, 6]

7. Final heap: [5, 6]
   - The 2nd largest element is the root of the heap: 5
*/
