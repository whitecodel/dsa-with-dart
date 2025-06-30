// Valid Anagram
// LeetCode 242: Valid Anagram

/*
Problem Statement:
Given two strings s and t, return true if t is an anagram of s, and false otherwise.
An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase,
typically using all the original letters exactly once.

Example:
Input: s = "anagram", t = "nagaram"
Output: true

Input: s = "rat", t = "car"
Output: false
*/

// Time Complexity: O(n) where n is the length of the strings
// Space Complexity: O(k) where k is the number of unique characters

bool isAnagram(String s, String t) {
  // Step 1: Check if lengths are different (quick early termination)
  if (s.length != t.length) {
    return false;
  }

  // Step 2: Create a frequency map for the first string
  Map<String, int> charCount = {};

  // Step 3: Count frequencies in the first string 's'
  for (int i = 0; i < s.length; i++) {
    String char = s[i];
    // Increment count in map (or initialize to 1 if not present)
    charCount[char] = (charCount[char] ?? 0) + 1;

    // Debug: Show current state of the map
    // print('After adding ${char}: $charCount');
  }

  // Step 4: Check characters in the second string 't'
  for (int i = 0; i < t.length; i++) {
    String char = t[i];

    // If the character doesn't exist in map or its count is 0,
    // then it's not an anagram
    if (charCount[char] == null || charCount[char] == 0) {
      return false;
    }

    // Decrement the frequency since we found this character
    charCount[char] = charCount[char]! - 1;

    // Debug: Show current state after decrement
    // print('After processing ${char} from t: $charCount');
  }

  // Step 5: If we processed all characters and the counts match, it's an anagram
  return true;
}

/*
Execution trace for "anagram" and "nagaram":

1. First check: both strings have length 7, so we continue.

2. Build frequency map for "anagram":
   - 'a': Add 'a' → Map: {'a': 1}
   - 'n': Add 'n' → Map: {'a': 1, 'n': 1}
   - 'a': Increment 'a' → Map: {'a': 2, 'n': 1}
   - 'g': Add 'g' → Map: {'a': 2, 'n': 1, 'g': 1}
   - 'r': Add 'r' → Map: {'a': 2, 'n': 1, 'g': 1, 'r': 1}
   - 'a': Increment 'a' → Map: {'a': 3, 'n': 1, 'g': 1, 'r': 1}
   - 'm': Add 'm' → Map: {'a': 3, 'n': 1, 'g': 1, 'r': 1, 'm': 1}

3. Check frequencies for "nagaram":
   - 'n': Found in map, decrement → Map: {'a': 3, 'n': 0, 'g': 1, 'r': 1, 'm': 1}
   - 'a': Found in map, decrement → Map: {'a': 2, 'n': 0, 'g': 1, 'r': 1, 'm': 1}
   - 'g': Found in map, decrement → Map: {'a': 2, 'n': 0, 'g': 0, 'r': 1, 'm': 1}
   - 'a': Found in map, decrement → Map: {'a': 1, 'n': 0, 'g': 0, 'r': 1, 'm': 1}
   - 'r': Found in map, decrement → Map: {'a': 1, 'n': 0, 'g': 0, 'r': 0, 'm': 1}
   - 'a': Found in map, decrement → Map: {'a': 0, 'n': 0, 'g': 0, 'r': 0, 'm': 1}
   - 'm': Found in map, decrement → Map: {'a': 0, 'n': 0, 'g': 0, 'r': 0, 'm': 0}

4. All characters were found in correct quantities, so return true.

Result: true
*/

// Another approach using sorted strings (less optimal but simpler)
bool isAnagramWithSorting(String s, String t) {
  // Edge case: different lengths cannot be anagrams
  if (s.length != t.length) {
    return false;
  }

  // Convert strings to character lists
  List<String> sList = s.split('');
  List<String> tList = t.split('');

  // Sort both lists
  sList.sort();
  tList.sort();

  // Convert back to strings and compare
  return sList.join() == tList.join();
}

void main() {
  String s1 = "anagram";
  String t1 = "nagaram";

  print('Is "$t1" an anagram of "$s1"? ${isAnagram(s1, t1)}'); // Expected: true

  String s2 = "rat";
  String t2 = "car";

  print(
    'Is "$t2" an anagram of "$s2"? ${isAnagram(s2, t2)}',
  ); // Expected: false

  // Additional test cases
  String s3 = "aacc";
  String t3 = "ccac";

  print(
    'Is "$t3" an anagram of "$s3"? ${isAnagram(s3, t3)}',
  ); // Expected: false

  String s4 = "";
  String t4 = "";

  print('Is "$t4" an anagram of "$s4"? ${isAnagram(s4, t4)}'); // Expected: true

  // Test the alternate sorting approach
  print(
    'Using sorting - Is "$t1" an anagram of "$s1"? ${isAnagramWithSorting(s1, t1)}',
  ); // Expected: true
  print(
    'Using sorting - Is "$t2" an anagram of "$s2"? ${isAnagramWithSorting(s2, t2)}',
  ); // Expected: false
}
