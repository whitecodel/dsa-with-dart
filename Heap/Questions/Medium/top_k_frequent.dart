// Heap: Top K Frequent Elements
//
// Problem: Given an integer array nums and an integer k, return the k most frequent
// elements. You may return the answer in any order.
//
// Example:
// Input: nums = [1, 1, 1, 2, 2, 3], k = 2
// Output: [1, 2]
// Explanation: The elements 1 and 2 appear most frequently (3 times and 2 times, respectively).
//
// This problem demonstrates the use of a heap/priority queue for efficient top-k finding.
// In Dart, we'll implement a min-heap to keep track of the k most frequent elements.

// MinHeap implementation for the priority queue
class MinHeap<E> {
  final List<E> _heap = [];
  final Comparator<E> _comparator;

  MinHeap(this._comparator);

  int get length => _heap.length;
  bool get isEmpty => _heap.isEmpty;
  E? get peek => isEmpty ? null : _heap[0];

  void add(E element) {
    _heap.add(element);
    _siftUp(length - 1);
  }

  E? remove() {
    if (isEmpty) return null;

    final E result = _heap[0];
    final E last = _heap.removeLast();

    if (isNotEmpty) {
      _heap[0] = last;
      _siftDown(0);
    }

    return result;
  }

  void _siftUp(int index) {
    E value = _heap[index];
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      E parent = _heap[parentIndex];

      if (_comparator(value, parent) >= 0) break;

      _heap[index] = parent;
      index = parentIndex;
    }
    _heap[index] = value;
  }

  void _siftDown(int index) {
    int length = _heap.length;
    int half = length ~/ 2;
    E element = _heap[index];

    while (index < half) {
      int childIndex = 2 * index + 1;
      E child = _heap[childIndex];

      int rightIndex = childIndex + 1;
      if (rightIndex < length && _comparator(child, _heap[rightIndex]) > 0) {
        child = _heap[childIndex = rightIndex];
      }

      if (_comparator(element, child) <= 0) break;

      _heap[index] = child;
      index = childIndex;
    }

    _heap[index] = element;
  }

  bool get isNotEmpty => _heap.isNotEmpty;
}

// Function to find the k most frequent elements in the array
List<int> topKFrequent(List<int> nums, int k) {
  // Count frequency of each element
  Map<int, int> frequency = {};
  for (int num in nums) {
    frequency[num] = (frequency[num] ?? 0) + 1;
  }

  // Create a min-heap to maintain the top k frequent elements
  // The heap is sorted by frequency (smaller frequency at the top)
  MinHeap<MapEntry<int, int>> heap = MinHeap<MapEntry<int, int>>(
    (a, b) => a.value.compareTo(b.value),
  );

  // Process each element
  for (var entry in frequency.entries) {
    // Add the entry to the heap
    heap.add(entry);

    // If heap size exceeds k, remove the least frequent element
    if (heap.length > k) {
      heap.remove();
    }
  }

  // Extract the numbers from the heap
  List<int> result = [];
  while (heap.isNotEmpty) {
    result.add(heap.remove()!.key);
  }

  // The result is in ascending frequency order, so reverse it for descending order
  return result.reversed.toList();
}

// Test function
void main() {
  // Test cases
  List<int> nums1 = [1, 1, 1, 2, 2, 3];
  int k1 = 2;

  List<int> nums2 = [1];
  int k2 = 1;

  List<int> nums3 = [3, 0, 1, 0, 1, 1, 2, 3, 4];
  int k3 = 3;

  print('Input: nums = $nums1, k = $k1');
  print('Output: ${topKFrequent(nums1, k1)}');

  print('\nInput: nums = $nums2, k = $k2');
  print('Output: ${topKFrequent(nums2, k2)}');

  print('\nInput: nums = $nums3, k = $k3');
  print('Output: ${topKFrequent(nums3, k3)}');

  // Detailed explanation
  print('\nDetailed explanation for [1, 1, 1, 2, 2, 3] with k = 2:');
  print('1. Count frequencies: {1: 3, 2: 2, 3: 1}');
  print('2. Add elements to min-heap and maintain size k = 2:');
  print('   - Add (1,3) -> Heap: [(1,3)]');
  print('   - Add (2,2) -> Heap: [(2,2), (1,3)]');
  print('   - Add (3,1) -> Heap: [(3,1), (1,3)]');
  print('   - Heap size exceeds k, remove min -> Heap: [(1,3)]');
  print('   - Add (2,2) -> Heap: [(2,2), (1,3)]');
  print('3. Extract results from heap: [2, 1]');
}

/* Execution Trace:
1. topKFrequent([1, 1, 1, 2, 2, 3], 2) is called:
   - Count frequencies: 
     {1: 3, 2: 2, 3: 1}
   
   - Initialize an empty min-heap sorted by frequency
   
   - Process entry (1, 3):
     - Add to heap: [(1,3)]
     - Heap size = 1, which is <= k, so continue
     
   - Process entry (2, 2):
     - Add to heap: [(2,2), (1,3)]
     - Heap size = 2, which is <= k, so continue
     
   - Process entry (3, 1):
     - Add to heap: [(3,1), (1,3), (2,2)]
     - Heap size = 3, which is > k, so remove min frequency element
     - After removal: [(2,2), (1,3)]
     
   - Extract elements from heap: [2, 1]
   - Reverse for descending order: [1, 2]
   
   - Return [1, 2]

2. The elements 1 and 2 appear most frequently (3 times and 2 times, respectively).

Output:
Input: nums = [1, 1, 1, 2, 2, 3], k = 2
Output: [1, 2]

Input: nums = [1], k = 1
Output: [1]

Input: nums = [3, 0, 1, 0, 1, 1, 2, 3, 4], k = 3
Output: [1, 0, 3]

Detailed explanation for [1, 1, 1, 2, 2, 3] with k = 2:
1. Count frequencies: {1: 3, 2: 2, 3: 1}
2. Add elements to min-heap and maintain size k = 2:
   - Add (1,3) -> Heap: [(1,3)]
   - Add (2,2) -> Heap: [(2,2), (1,3)]
   - Add (3,1) -> Heap: [(3,1), (1,3)]
   - Heap size exceeds k, remove min -> Heap: [(1,3)]
   - Add (2,2) -> Heap: [(2,2), (1,3)]
3. Extract results from heap: [2, 1]
*/
