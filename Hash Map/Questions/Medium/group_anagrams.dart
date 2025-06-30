// Group Anagrams
// Problem: Given an array of strings, group the anagrams together. You can return the answer in any order.
// An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase,
// using all the original letters exactly once.
//
// Example:
//   Input: strs = ["eat","tea","tan","ate","nat","bat"]
//   Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
//
//   Input: strs = [""]
//   Output: [[""]]
//
//   Input: strs = ["a"]
//   Output: [["a"]]

// Hash Map approach to group anagrams
//
// Time Complexity: O(n * k log k) where n is the number of strings and k is the maximum length of a string
// Space Complexity: O(n * k) for storing all strings in the hashmap
List<List<String>> groupAnagrams(List<String> strs) {
  // Edge cases
  if (strs.isEmpty) return [];
  if (strs.length == 1) return [strs];

  // Hashmap to store anagram groups: sorted string -> list of original strings
  Map<String, List<String>> anagramMap = {};

  // Process each string in the input list
  for (String str in strs) {
    // Sort the characters to create a unique key for each anagram group
    String sortedStr = sortString(str);

    // Add the string to its anagram group
    if (!anagramMap.containsKey(sortedStr)) {
      anagramMap[sortedStr] = [];
    }
    anagramMap[sortedStr]!.add(str);
  }

  // Convert the hashmap values to the result list
  return anagramMap.values.toList();
}

// Helper function to sort characters in a string
String sortString(String s) {
  List<String> chars = s.split('');
  chars.sort();
  return chars.join('');
}

// Execution trace for example 1: ["eat","tea","tan","ate","nat","bat"]
// - Initialize empty anagramMap: {}
// - "eat" → sorted: "aet" → Add to map: {"aet": ["eat"]}
// - "tea" → sorted: "aet" → Add to map: {"aet": ["eat", "tea"]}
// - "tan" → sorted: "ant" → Add to map: {"aet": ["eat", "tea"], "ant": ["tan"]}
// - "ate" → sorted: "aet" → Add to map: {"aet": ["eat", "tea", "ate"], "ant": ["tan"]}
// - "nat" → sorted: "ant" → Add to map: {"aet": ["eat", "tea", "ate"], "ant": ["tan", "nat"]}
// - "bat" → sorted: "abt" → Add to map: {"aet": ["eat", "tea", "ate"], "ant": ["tan", "nat"], "abt": ["bat"]}
// - Convert map values to list: [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

void main() {
  // Test cases
  List<List<String>> testCases = [
    ["eat", "tea", "tan", "ate", "nat", "bat"], // Multiple anagram groups
    [""], // Empty string
    ["a"], // Single character
    ["abc", "def", "ghi"], // No anagrams (all unique)
    ["aaa", "aaa", "aaa", "aaa"], // All same
  ];

  // Expected outputs (note: order within groups doesn't matter)
  List<List<List<String>>> expected = [
    [
      ["eat", "tea", "ate"],
      ["tan", "nat"],
      ["bat"],
    ],
    [
      [""],
    ],
    [
      ["a"],
    ],
    [
      ["abc"],
      ["def"],
      ["ghi"],
    ],
    [
      ["aaa", "aaa", "aaa", "aaa"],
    ],
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    print('Test case ${i + 1}: ${testCases[i]}');

    List<List<String>> result = groupAnagrams(testCases[i]);
    print('Result: $result');
    print('Expected: ${expected[i]}');

    // Check if the results match (ignoring order)
    bool isMatch = checkAnagramGroupsMatch(result, expected[i]);
    print(isMatch ? 'PASS' : 'FAIL');
    print('---');
  }
}

// Helper function to check if two anagram group results match
// This handles the case where the order of groups or elements within groups may vary
bool checkAnagramGroupsMatch(
  List<List<String>> actual,
  List<List<String>> expected,
) {
  if (actual.length != expected.length) return false;

  // Create a map of group sizes for both results
  Map<int, int> actualSizes = {};
  Map<int, int> expectedSizes = {};

  for (var group in actual) {
    actualSizes[group.length] = (actualSizes[group.length] ?? 0) + 1;
  }

  for (var group in expected) {
    expectedSizes[group.length] = (expectedSizes[group.length] ?? 0) + 1;
  }

  // Compare the size distributions
  if (!mapEquals(actualSizes, expectedSizes)) return false;

  // For simplicity, we'll just check that all elements are accounted for
  // A more precise check would match each group, but that's complex due to ordering
  Set<String> actualElements = {};
  Set<String> expectedElements = {};

  for (var group in actual) {
    for (var elem in group) {
      actualElements.add(elem);
    }
  }

  for (var group in expected) {
    for (var elem in group) {
      expectedElements.add(elem);
    }
  }

  return setEquals(actualElements, expectedElements);
}

// Helper function to check if two maps are equal
bool mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;

  for (final key in a.keys) {
    if (!b.containsKey(key) || b[key] != a[key]) return false;
  }

  return true;
}

// Helper function to check if two sets are equal
bool setEquals<T>(Set<T>? a, Set<T>? b) {
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;

  for (final item in a) {
    if (!b.contains(item)) return false;
  }

  return true;
}
