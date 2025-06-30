// Heap: Find Median from Data Stream
//
// Problem: Design a data structure that supports the following operations:
// - addNum(num): Add an integer to the data stream.
// - findMedian(): Return the median of all elements seen so far.
//
// The median is the middle value in an ordered integer list. If the size of the list
// is even, the median is the average of the two middle values.
//
// Example:
// MedianFinder medianFinder = new MedianFinder();
// medianFinder.addNum(1);    // arr = [1]
// medianFinder.findMedian(); // return 1.0
// medianFinder.addNum(2);    // arr = [1, 2]
// medianFinder.findMedian(); // return 1.5 (avg of 1 and 2)
// medianFinder.addNum(3);    // arr = [1, 2, 3]
// medianFinder.findMedian(); // return 2.0
//
// This problem is a perfect application for the two-heap pattern, where we
// maintain two heaps - a max-heap for the smaller half and a min-heap for
// the larger half of the numbers.

// Implementation of a MinHeap
class MinHeap {
  List<int> _heap = [];

  int get size => _heap.length;
  bool get isEmpty => _heap.isEmpty;

  void add(int val) {
    _heap.add(val);
    _siftUp(_heap.length - 1);
  }

  int peek() {
    if (isEmpty) throw Exception("Heap is empty");
    return _heap[0];
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

// Implementation of a MaxHeap (using a MinHeap with negated values)
class MaxHeap {
  MinHeap _minHeap = MinHeap();

  int get size => _minHeap.size;
  bool get isEmpty => _minHeap.isEmpty;

  void add(int val) {
    _minHeap.add(-val); // Negate to convert to max heap
  }

  int peek() {
    return -_minHeap.peek(); // Negate back to get original value
  }

  int remove() {
    return -_minHeap.remove(); // Negate back to get original value
  }
}

// MedianFinder class using two heaps
class MedianFinder {
  // Max heap for the smaller half of the numbers
  final MaxHeap _smallerHalf = MaxHeap();

  // Min heap for the larger half of the numbers
  final MinHeap _largerHalf = MinHeap();

  // Add a number to the data stream
  void addNum(int num) {
    // If both heaps are empty or num is smaller than the max of smaller half,
    // add to the smaller half
    if (_smallerHalf.isEmpty || num <= _smallerHalf.peek()) {
      _smallerHalf.add(num);
    } else {
      // Otherwise, add to the larger half
      _largerHalf.add(num);
    }

    // Balance the heaps to ensure their sizes differ by at most 1
    _rebalance();
  }

  // Rebalance the two heaps to ensure they have similar sizes
  void _rebalance() {
    // If smaller half has more than one element extra, move the largest to larger half
    if (_smallerHalf.size > _largerHalf.size + 1) {
      _largerHalf.add(_smallerHalf.remove());
    }
    // If larger half has more elements, move the smallest to smaller half
    else if (_largerHalf.size > _smallerHalf.size) {
      _smallerHalf.add(_largerHalf.remove());
    }
  }

  // Find the median of the data stream
  double findMedian() {
    // If both heaps have the same size, the median is the average of their tops
    if (_smallerHalf.size == _largerHalf.size) {
      return (_smallerHalf.peek() + _largerHalf.peek()) / 2.0;
    }
    // Otherwise, the median is the top of the smaller half (which has one extra element)
    return _smallerHalf.peek().toDouble();
  }
}

// Test function
void main() {
  // Test cases
  MedianFinder medianFinder = MedianFinder();

  print('Adding 1 to the data stream');
  medianFinder.addNum(1);
  print('Median: ${medianFinder.findMedian()}'); // Expected: 1.0

  print('\nAdding 2 to the data stream');
  medianFinder.addNum(2);
  print('Median: ${medianFinder.findMedian()}'); // Expected: 1.5

  print('\nAdding 3 to the data stream');
  medianFinder.addNum(3);
  print('Median: ${medianFinder.findMedian()}'); // Expected: 2.0

  print('\nAdding 4 to the data stream');
  medianFinder.addNum(4);
  print('Median: ${medianFinder.findMedian()}'); // Expected: 2.5

  print('\nAdding 5 to the data stream');
  medianFinder.addNum(5);
  print('Median: ${medianFinder.findMedian()}'); // Expected: 3.0

  // Detailed explanation
  print('\nDetailed explanation:');

  print(
    '1. Initialize two heaps: smallerHalf (max-heap) and largerHalf (min-heap)',
  );

  print('\n2. Adding 1:');
  print('   - Both heaps are empty, so add 1 to smallerHalf');
  print('   - smallerHalf = [1], largerHalf = []');
  print('   - The median is the top of smallerHalf = 1.0');

  print('\n3. Adding 2:');
  print('   - 2 > smallerHalf.peek() (which is 1), so add 2 to largerHalf');
  print('   - smallerHalf = [1], largerHalf = [2]');
  print('   - Heaps are balanced with equal sizes');
  print('   - The median is the average of tops: (1 + 2) / 2 = 1.5');

  print('\n4. Adding 3:');
  print('   - 3 > smallerHalf.peek() (which is 1), so add 3 to largerHalf');
  print('   - smallerHalf = [1], largerHalf = [2, 3]');
  print('   - Rebalance: move smallest from largerHalf (2) to smallerHalf');
  print('   - After rebalance: smallerHalf = [1, 2], largerHalf = [3]');
  print('   - The median is the top of smallerHalf = 2.0');

  print('\n5. Adding 4:');
  print('   - 4 > smallerHalf.peek() (which is 2), so add 4 to largerHalf');
  print('   - smallerHalf = [1, 2], largerHalf = [3, 4]');
  print('   - Heaps are balanced with equal sizes');
  print('   - The median is the average of tops: (2 + 3) / 2 = 2.5');

  print('\n6. Adding 5:');
  print('   - 5 > smallerHalf.peek() (which is 2), so add 5 to largerHalf');
  print('   - smallerHalf = [1, 2], largerHalf = [3, 4, 5]');
  print('   - Rebalance: move smallest from largerHalf (3) to smallerHalf');
  print('   - After rebalance: smallerHalf = [1, 2, 3], largerHalf = [4, 5]');
  print('   - The median is the top of smallerHalf = 3.0');
}

/* Execution Trace:
1. Initialize MedianFinder:
   - smallerHalf (max-heap) = []
   - largerHalf (min-heap) = []

2. medianFinder.addNum(1):
   - Both heaps are empty, so add 1 to smallerHalf
   - smallerHalf = [1], largerHalf = []
   - Heaps are balanced (smallerHalf has at most one more element)
   - findMedian() returns smallerHalf.peek() = 1.0

3. medianFinder.addNum(2):
   - 2 > smallerHalf.peek() (which is 1), so add 2 to largerHalf
   - smallerHalf = [1], largerHalf = [2]
   - Heaps are balanced with equal sizes
   - findMedian() returns (smallerHalf.peek() + largerHalf.peek()) / 2 = (1 + 2) / 2 = 1.5

4. medianFinder.addNum(3):
   - 3 > smallerHalf.peek() (which is 1), so add 3 to largerHalf
   - smallerHalf = [1], largerHalf = [2, 3]
   - Rebalance: largerHalf has more elements, move smallest from largerHalf to smallerHalf
   - After rebalance: smallerHalf = [1, 2], largerHalf = [3]
   - findMedian() returns smallerHalf.peek() = 2.0

5. medianFinder.addNum(4):
   - 4 > smallerHalf.peek() (which is 2), so add 4 to largerHalf
   - smallerHalf = [1, 2], largerHalf = [3, 4]
   - Heaps are balanced with equal sizes
   - findMedian() returns (smallerHalf.peek() + largerHalf.peek()) / 2 = (2 + 3) / 2 = 2.5

6. medianFinder.addNum(5):
   - 5 > smallerHalf.peek() (which is 2), so add 5 to largerHalf
   - smallerHalf = [1, 2], largerHalf = [3, 4, 5]
   - Rebalance: largerHalf has more elements, move smallest from largerHalf to smallerHalf
   - After rebalance: smallerHalf = [1, 2, 3], largerHalf = [4, 5]
   - findMedian() returns smallerHalf.peek() = 3.0

Output:
Adding 1 to the data stream
Median: 1.0

Adding 2 to the data stream
Median: 1.5

Adding 3 to the data stream
Median: 2.0

Adding 4 to the data stream
Median: 2.5

Adding 5 to the data stream
Median: 3.0

Detailed explanation:
1. Initialize two heaps: smallerHalf (max-heap) and largerHalf (min-heap)

2. Adding 1:
   - Both heaps are empty, so add 1 to smallerHalf
   - smallerHalf = [1], largerHalf = []
   - The median is the top of smallerHalf = 1.0

3. Adding 2:
   - 2 > smallerHalf.peek() (which is 1), so add 2 to largerHalf
   - smallerHalf = [1], largerHalf = [2]
   - Heaps are balanced with equal sizes
   - The median is the average of tops: (1 + 2) / 2 = 1.5

4. Adding 3:
   - 3 > smallerHalf.peek() (which is 1), so add 3 to largerHalf
   - smallerHalf = [1], largerHalf = [2, 3]
   - Rebalance: move smallest from largerHalf (2) to smallerHalf
   - After rebalance: smallerHalf = [1, 2], largerHalf = [3]
   - The median is the top of smallerHalf = 2.0

5. Adding 4:
   - 4 > smallerHalf.peek() (which is 2), so add 4 to largerHalf
   - smallerHalf = [1, 2], largerHalf = [3, 4]
   - Heaps are balanced with equal sizes
   - The median is the average of tops: (2 + 3) / 2 = 2.5

6. Adding 5:
   - 5 > smallerHalf.peek() (which is 2), so add 5 to largerHalf
   - smallerHalf = [1, 2], largerHalf = [3, 4, 5]
   - Rebalance: move smallest from largerHalf (3) to smallerHalf
   - After rebalance: smallerHalf = [1, 2, 3], largerHalf = [4, 5]
   - The median is the top of smallerHalf = 3.0
*/
