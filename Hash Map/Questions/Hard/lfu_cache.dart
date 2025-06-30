// LFU Cache (Least Frequently Used Cache)
// Problem: Design and implement a data structure for a Least Frequently Used (LFU) cache.
//
// Implement the LFUCache class:
// - LFUCache(int capacity) Initializes the object with the capacity of the data structure.
// - int get(int key) Gets the value of the key if the key exists in the cache. Otherwise, returns -1.
// - void put(int key, int value) Update the value of the key if present, or inserts the key if not already present.
//   When the cache reaches its capacity, it should invalidate and remove the least frequently used key before inserting
//   a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency),
//   the least recently used key would be invalidated.
//
// Example:
//   Input:
//   ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
//   [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
//   Output:
//   [null, null, null, 1, null, -1, 3, null, -1, 3, 4]

// LFU Cache using hash maps for O(1) operations
// The implementation uses two hash maps and a double-linked list to achieve O(1) time complexity
class LFUCache {
  // Maximum capacity of the cache
  final int capacity;

  // Current number of items in the cache
  int size = 0;

  // Minimum frequency of any item in the cache
  int minFreq = 0;

  // Maps a key to its corresponding node
  final Map<int, CacheNode> keyToNode = {};

  // Maps a frequency to a doubly linked list of nodes with that frequency
  final Map<int, DoublyLinkedList> freqToList = {};

  // Constructor
  LFUCache(this.capacity);

  // Get the value for a key, or -1 if it doesn't exist
  int get(int key) {
    // If key doesn't exist or capacity is 0
    if (!keyToNode.containsKey(key) || capacity == 0) {
      return -1;
    }

    // Get the node for this key
    CacheNode node = keyToNode[key]!;

    // Update the frequency of the node
    updateNodeFrequency(node);

    return node.value;
  }

  // Insert or update a key-value pair
  void put(int key, int value) {
    // If capacity is 0, do nothing
    if (capacity == 0) {
      return;
    }

    // If key already exists, update its value and frequency
    if (keyToNode.containsKey(key)) {
      CacheNode node = keyToNode[key]!;
      node.value = value;
      updateNodeFrequency(node);
      return;
    }

    // If cache is at capacity, remove the least frequently used item
    if (size == capacity) {
      // Get the list of items with minimum frequency
      DoublyLinkedList minFreqList = freqToList[minFreq]!;

      // Remove the least recently used node from this list (the tail)
      CacheNode nodeToRemove = minFreqList.removeTail();

      // Remove the corresponding key from the keyToNode map
      keyToNode.remove(nodeToRemove.key);

      size--;
    }

    // Add the new node with frequency 1
    minFreq = 1; // Reset minFreq to 1
    CacheNode newNode = CacheNode(key, value);

    // Add to frequency list 1
    if (!freqToList.containsKey(1)) {
      freqToList[1] = DoublyLinkedList();
    }
    freqToList[1]!.addToHead(newNode);

    // Add to key map
    keyToNode[key] = newNode;

    size++;
  }

  // Helper method to update the frequency of a node
  void updateNodeFrequency(CacheNode node) {
    // Get current frequency list
    int oldFreq = node.frequency;
    DoublyLinkedList oldList = freqToList[oldFreq]!;

    // Remove node from current frequency list
    oldList.removeNode(node);

    // Update minFreq if needed
    if (oldFreq == minFreq && oldList.isEmpty()) {
      minFreq++;
    }

    // Update node frequency
    node.frequency++;

    // Add node to the new frequency list
    if (!freqToList.containsKey(node.frequency)) {
      freqToList[node.frequency] = DoublyLinkedList();
    }
    freqToList[node.frequency]!.addToHead(node);
  }
}

// Node class for the cache
class CacheNode {
  // The key for this cache entry
  final int key;

  // The value for this cache entry
  int value;

  // The frequency of access for this node
  int frequency = 1;

  // Previous node in the linked list
  CacheNode? prev;

  // Next node in the linked list
  CacheNode? next;

  // Constructor
  CacheNode(this.key, this.value);
}

// Doubly linked list to store nodes with the same frequency
class DoublyLinkedList {
  // Head sentinel node
  final CacheNode _head = CacheNode(-1, -1);

  // Tail sentinel node
  final CacheNode _tail = CacheNode(-1, -1);

  // Constructor
  DoublyLinkedList() {
    // Connect head and tail
    _head.next = _tail;
    _tail.prev = _head;
  }

  // Add a node to the head of the list (most recently used)
  void addToHead(CacheNode node) {
    // Connect node to its neighbors
    node.next = _head.next;
    node.prev = _head;

    // Connect neighbors to node
    _head.next!.prev = node;
    _head.next = node;
  }

  // Remove a node from the list
  void removeNode(CacheNode node) {
    // Connect the node's neighbors to each other
    node.prev!.next = node.next;
    node.next!.prev = node.prev;
  }

  // Remove the tail node (least recently used) and return it
  CacheNode removeTail() {
    CacheNode nodeToRemove = _tail.prev!;
    removeNode(nodeToRemove);
    return nodeToRemove;
  }

  // Check if the list is empty
  bool isEmpty() {
    return _head.next == _tail;
  }
}

// Execution trace for the example:
//
// 1. LFUCache(2): Create cache with capacity 2
//    - capacity = 2
//    - size = 0
//    - minFreq = 0
//    - keyToNode = {}
//    - freqToList = {}
//
// 2. put(1, 1):
//    - Add new node with key=1, value=1, freq=1
//    - minFreq = 1
//    - keyToNode = {1: Node(1,1)}
//    - freqToList = {1: List with Node(1,1)}
//    - size = 1
//
// 3. put(2, 2):
//    - Add new node with key=2, value=2, freq=1
//    - minFreq = 1
//    - keyToNode = {1: Node(1,1), 2: Node(2,2)}
//    - freqToList = {1: List with Node(2,2) -> Node(1,1)}
//    - size = 2
//
// 4. get(1): Return 1
//    - Increase freq of Node(1,1) to 2
//    - minFreq = 1 (since Node(2,2) still has freq=1)
//    - keyToNode = {1: Node(1,1,freq=2), 2: Node(2,2)}
//    - freqToList = {1: List with Node(2,2), 2: List with Node(1,1)}
//
// 5. put(3, 3):
//    - Cache is full, remove LFU item
//    - minFreq = 1, so remove Node(2,2)
//    - Add new node with key=3, value=3, freq=1
//    - minFreq = 1
//    - keyToNode = {1: Node(1,1,freq=2), 3: Node(3,3)}
//    - freqToList = {1: List with Node(3,3), 2: List with Node(1,1)}
//    - size = 2
//
// 6. get(2): Return -1 (not found)
//
// 7. get(3): Return 3
//    - Increase freq of Node(3,3) to 2
//    - minFreq = 2 (since no nodes with freq=1 left)
//    - keyToNode = {1: Node(1,1,freq=2), 3: Node(3,3,freq=2)}
//    - freqToList = {2: List with Node(3,3) -> Node(1,1)}
//
// 8. put(4, 4):
//    - Cache is full, remove LFU item
//    - minFreq = 2, and both have same freq, so remove LRU = Node(1,1)
//    - Add new node with key=4, value=4, freq=1
//    - minFreq = 1
//    - keyToNode = {3: Node(3,3,freq=2), 4: Node(4,4)}
//    - freqToList = {1: List with Node(4,4), 2: List with Node(3,3)}
//    - size = 2
//
// 9. get(1): Return -1 (not found)
//
// 10. get(3): Return 3
//     - Increase freq of Node(3,3) to 3
//     - minFreq = 1 (Node(4,4) still has freq=1)
//     - keyToNode = {3: Node(3,3,freq=3), 4: Node(4,4)}
//     - freqToList = {1: List with Node(4,4), 3: List with Node(3,3)}
//
// 11. get(4): Return 4
//     - Increase freq of Node(4,4) to 2
//     - minFreq = 2 (no nodes with freq=1 left)
//     - keyToNode = {3: Node(3,3,freq=3), 4: Node(4,4,freq=2)}
//     - freqToList = {2: List with Node(4,4), 3: List with Node(3,3)}

void main() {
  print('Test case 1: Basic operations');
  var lfu = LFUCache(2);

  lfu.put(1, 1);
  lfu.put(2, 2);
  print('get(1): ${lfu.get(1)}'); // return 1

  lfu.put(3, 3); // evicts key 2
  print('get(2): ${lfu.get(2)}'); // return -1 (not found)
  print('get(3): ${lfu.get(3)}'); // return 3

  lfu.put(4, 4); // evicts key 1
  print('get(1): ${lfu.get(1)}'); // return -1 (not found)
  print('get(3): ${lfu.get(3)}'); // return 3
  print('get(4): ${lfu.get(4)}'); // return 4

  print('\nTest case 2: Zero capacity');
  var lfu2 = LFUCache(0);

  lfu2.put(0, 0);
  print('get(0): ${lfu2.get(0)}'); // return -1 (capacity is 0)

  print('\nTest case 3: Update existing key');
  var lfu3 = LFUCache(2);

  lfu3.put(1, 1);
  lfu3.put(2, 2);
  print('get(1): ${lfu3.get(1)}'); // return 1

  lfu3.put(1, 10); // update key 1
  print('get(1): ${lfu3.get(1)}'); // return 10
  print('get(2): ${lfu3.get(2)}'); // return 2

  lfu3.put(3, 3); // evicts key 2 (freq tie, but 2 is LRU)
  print('get(2): ${lfu3.get(2)}'); // return -1
  print('get(1): ${lfu3.get(1)}'); // return 10
  print('get(3): ${lfu3.get(3)}'); // return 3
}
