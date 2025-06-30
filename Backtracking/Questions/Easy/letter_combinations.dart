// Letter Combinations of a Phone Number
// Problem: Given a string containing digits from 2-9 inclusive, return all possible
// letter combinations that the number could represent. Return the answer in any order.
//
// A mapping of digits to letters (just like on telephone buttons) is given below:
// 2 -> abc    3 -> def    4 -> ghi
// 5 -> jkl    6 -> mno    7 -> pqrs
// 8 -> tuv    9 -> wxyz
//
// Example:
//   Input: digits = "23"
//   Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
//
//   Input: digits = ""
//   Output: []
//
//   Input: digits = "2"
//   Output: ["a","b","c"]

// Backtracking solution for letter combinations of a phone number
//
// Time Complexity: O(4^n) where n is the number of digits in the input
// Space Complexity: O(n) for the recursion stack, plus O(4^n) for the output
List<String> letterCombinations(String digits) {
  // Result list to store all combinations
  List<String> result = [];

  // Edge case: empty input
  if (digits.isEmpty) {
    return result;
  }

  // Mapping of digits to letters
  Map<String, String> digitToLetters = {
    '2': 'abc',
    '3': 'def',
    '4': 'ghi',
    '5': 'jkl',
    '6': 'mno',
    '7': 'pqrs',
    '8': 'tuv',
    '9': 'wxyz',
  };

  // Recursive backtracking function
  void backtrack(int index, String current) {
    // Base case: we've processed all digits
    if (index == digits.length) {
      result.add(current);
      return;
    }

    // Get the letters corresponding to the current digit
    String letters = digitToLetters[digits[index]]!;

    // Try each letter
    for (int i = 0; i < letters.length; i++) {
      // Add the letter to our current combination
      String newCombination = current + letters[i];

      // Recursively process the next digit
      backtrack(index + 1, newCombination);
    }
  }

  // Start backtracking from the first digit with empty string
  backtrack(0, '');

  return result;
}

// Execution trace for "23":
// 1. Start with index=0, current=""
//
// 2. For digit '2' at index 0, letters = "abc":
//    - Try letter 'a': newCombination = "a", call backtrack(1, "a")
//      - For digit '3' at index 1, letters = "def":
//        - Try letter 'd': newCombination = "ad", call backtrack(2, "ad")
//          - index == digits.length, add "ad" to result
//        - Try letter 'e': newCombination = "ae", call backtrack(2, "ae")
//          - index == digits.length, add "ae" to result
//        - Try letter 'f': newCombination = "af", call backtrack(2, "af")
//          - index == digits.length, add "af" to result
//
//    - Try letter 'b': newCombination = "b", call backtrack(1, "b")
//      - For digit '3' at index 1, letters = "def":
//        - Try letter 'd': newCombination = "bd", call backtrack(2, "bd")
//          - index == digits.length, add "bd" to result
//        - Try letter 'e': newCombination = "be", call backtrack(2, "be")
//          - index == digits.length, add "be" to result
//        - Try letter 'f': newCombination = "bf", call backtrack(2, "bf")
//          - index == digits.length, add "bf" to result
//
//    - Try letter 'c': newCombination = "c", call backtrack(1, "c")
//      - For digit '3' at index 1, letters = "def":
//        - Try letter 'd': newCombination = "cd", call backtrack(2, "cd")
//          - index == digits.length, add "cd" to result
//        - Try letter 'e': newCombination = "ce", call backtrack(2, "ce")
//          - index == digits.length, add "ce" to result
//        - Try letter 'f': newCombination = "cf", call backtrack(2, "cf")
//          - index == digits.length, add "cf" to result
//
// 3. Result = ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]

void main() {
  // Test cases
  List<String> testCases = [
    "23", // Standard case
    "", // Empty input
    "2", // Single digit
    "234", // Three digits
    "7", // Digit with 4 letters
    "79", // Multiple digits with 4 letters each
    "999", // Repeated digits
  ];

  // Expected outputs
  List<List<String>> expected = [
    ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"],
    [],
    ["a", "b", "c"],
    [
      "adg",
      "adh",
      "adi",
      "aeg",
      "aeh",
      "aei",
      "afg",
      "afh",
      "afi",
      "bdg",
      "bdh",
      "bdi",
      "beg",
      "beh",
      "bei",
      "bfg",
      "bfh",
      "bfi",
      "cdg",
      "cdh",
      "cdi",
      "ceg",
      "ceh",
      "cei",
      "cfg",
      "cfh",
      "cfi",
    ],
    ["p", "q", "r", "s"],
    [
      "wp",
      "wq",
      "wr",
      "ws",
      "xp",
      "xq",
      "xr",
      "xs",
      "yp",
      "yq",
      "yr",
      "ys",
      "zp",
      "zq",
      "zr",
      "zs",
    ],
    [
      "www",
      "wwx",
      "wwy",
      "wwz",
      "wxw",
      "wxx",
      "wxy",
      "wxz",
      "wyw",
      "wyx",
      "wyy",
      "wyz",
      "wzw",
      "wzx",
      "wzy",
      "wzz",
      "xww",
      "xwx",
      "xwy",
      "xwz",
      "xxw",
      "xxx",
      "xxy",
      "xxz",
      "xyw",
      "xyx",
      "xyy",
      "xyz",
      "xzw",
      "xzx",
      "xzy",
      "xzz",
      "yww",
      "ywx",
      "ywy",
      "ywz",
      "yxw",
      "yxx",
      "yxy",
      "yxz",
      "yyw",
      "yyx",
      "yyy",
      "yyz",
      "yzw",
      "yzx",
      "yzy",
      "yzz",
      "zww",
      "zwx",
      "zwy",
      "zwz",
      "zxw",
      "zxx",
      "zxy",
      "zxz",
      "zyw",
      "zyx",
      "zyy",
      "zyz",
      "zzw",
      "zzx",
      "zzy",
      "zzz",
    ],
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    String digits = testCases[i];
    print('Test case ${i + 1}: "$digits"');

    List<String> result = letterCombinations(digits);

    print('Result: $result');
    print(
      'Expected length: ${expected[i].length}, Actual length: ${result.length}',
    );

    // Check results - for longer outputs, just check the length and a few samples
    bool isCorrect = false;

    if (result.length == expected[i].length) {
      if (result.isEmpty) {
        isCorrect = true;
      } else if (result.length <= 10) {
        // For small results, check the whole list
        isCorrect =
            result.every((element) => expected[i].contains(element)) &&
            expected[i].every((element) => result.contains(element));
      } else {
        // For large results, check a few samples
        isCorrect =
            result.length == expected[i].length &&
            result.take(3).every((element) => expected[i].contains(element));
      }
    }

    print(isCorrect ? 'PASS' : 'FAIL');
    print('---');
  }
}
