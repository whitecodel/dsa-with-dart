// Coin Change
// Problem: You are given an integer array coins representing coins of different
// denominations and an integer amount representing a total amount of money.
// Return the fewest number of coins that you need to make up that amount.
// If that amount of money cannot be made up by any combination of the coins, return -1.
//
// Example:
//   Input: coins = [1,2,5], amount = 11
//   Output: 3
//   Explanation: 11 = 5 + 5 + 1
//
//   Input: coins = [2], amount = 3
//   Output: -1
//   Explanation: It's impossible to make 3 with given coins
//
//   Input: coins = [1], amount = 0
//   Output: 0
//   Explanation: No coins needed for amount 0

// Dynamic Programming solution for the Coin Change problem
//
// Time Complexity: O(amount * coins.length)
// Space Complexity: O(amount) for the DP array
int coinChange(List<int> coins, int amount) {
  // Edge case: amount is 0
  if (amount == 0) return 0;

  // DP array to store the minimum number of coins needed for each amount
  // Initialize with amount + 1 (which is larger than the max possible answer)
  List<int> dp = List<int>.filled(amount + 1, amount + 1);

  // Base case: 0 coins needed to make amount 0
  dp[0] = 0;

  // Fill the dp array bottom-up
  for (int i = 1; i <= amount; i++) {
    // Try each coin
    for (int coin in coins) {
      // If the coin value is less than or equal to the current amount
      if (coin <= i) {
        // Take the minimum of current dp value or 1 + dp[i - coin]
        dp[i] = min(dp[i], 1 + dp[i - coin]);
      }
    }
  }

  // If dp[amount] is still amount+1, it means the amount cannot be made
  return dp[amount] > amount ? -1 : dp[amount];
}

// Helper function to get the minimum of two integers
int min(int a, int b) {
  return a < b ? a : b;
}

// Execution trace for coins = [1,2,5], amount = 11:
//
// Initialize dp = [0, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12]
//
// For i = 1:
//   For coin = 1: dp[1] = min(12, 1 + dp[0]) = min(12, 1 + 0) = 1
//   For coin = 2: Skipped (coin > i)
//   For coin = 5: Skipped (coin > i)
//   dp[1] = 1
//
// For i = 2:
//   For coin = 1: dp[2] = min(12, 1 + dp[1]) = min(12, 1 + 1) = 2
//   For coin = 2: dp[2] = min(2, 1 + dp[0]) = min(2, 1 + 0) = 1
//   For coin = 5: Skipped (coin > i)
//   dp[2] = 1
//
// For i = 3:
//   For coin = 1: dp[3] = min(12, 1 + dp[2]) = min(12, 1 + 1) = 2
//   For coin = 2: dp[3] = min(2, 1 + dp[1]) = min(2, 1 + 1) = 2
//   For coin = 5: Skipped (coin > i)
//   dp[3] = 2
//
// For i = 4:
//   For coin = 1: dp[4] = min(12, 1 + dp[3]) = min(12, 1 + 2) = 3
//   For coin = 2: dp[4] = min(3, 1 + dp[2]) = min(3, 1 + 1) = 2
//   For coin = 5: Skipped (coin > i)
//   dp[4] = 2
//
// For i = 5:
//   For coin = 1: dp[5] = min(12, 1 + dp[4]) = min(12, 1 + 2) = 3
//   For coin = 2: dp[5] = min(3, 1 + dp[3]) = min(3, 1 + 2) = 3
//   For coin = 5: dp[5] = min(3, 1 + dp[0]) = min(3, 1 + 0) = 1
//   dp[5] = 1
//
// ... (continuing the pattern)
//
// For i = 11:
//   For coin = 1: dp[11] = min(12, 1 + dp[10]) = min(12, 1 + 2) = 3
//   For coin = 2: dp[11] = min(3, 1 + dp[9]) = min(3, 1 + 3) = 3
//   For coin = 5: dp[11] = min(3, 1 + dp[6]) = min(3, 1 + 2) = 3
//   dp[11] = 3
//
// Result: dp[11] = 3
// So the minimum number of coins needed is 3 (5 + 5 + 1)

void main() {
  // Test cases
  List<Map<String, dynamic>> testCases = [
    {
      'coins': [1, 2, 5],
      'amount': 11,
      'expected': 3,
    }, // 11 = 5 + 5 + 1
    {
      'coins': [2],
      'amount': 3,
      'expected': -1,
    }, // Impossible
    {
      'coins': [1],
      'amount': 0,
      'expected': 0,
    }, // No coins needed
    {
      'coins': [1, 5, 10, 25],
      'amount': 30,
      'expected': 3,
    }, // 30 = 25 + 5
    {
      'coins': [2, 5, 10],
      'amount': 3,
      'expected': -1,
    }, // Impossible
    {
      'coins': [1, 2, 5],
      'amount': 100,
      'expected': 20,
    }, // Larger amount
    {
      'coins': [186, 419, 83, 408],
      'amount': 6249,
      'expected': 20,
    }, // Larger coins
    {
      'coins': [3, 7, 405, 436],
      'amount': 8839,
      'expected': 25,
    }, // Complex case
  ];

  // Run test cases
  for (int i = 0; i < testCases.length; i++) {
    var testCase = testCases[i];
    List<int> coins = testCase['coins'] as List<int>;
    int amount = testCase['amount'] as int;
    int expected = testCase['expected'] as int;

    print('Test case ${i + 1}:');
    print('Coins: $coins, Amount: $amount');

    int result = coinChange(coins, amount);
    print('Result: $result');
    print('Expected: $expected');
    print(result == expected ? 'PASS' : 'FAIL');
    print('---');
  }

  // Demonstration of the dynamic programming table for a simple case
  print('Dynamic Programming Table Demonstration:');
  print('Coins: [1, 2, 5], Amount: 11\n');

  List<int> coins = [1, 2, 5];
  int amount = 11;
  List<int> dp = List<int>.filled(amount + 1, amount + 1);
  dp[0] = 0;

  print('Initial DP array: $dp');

  for (int i = 1; i <= amount; i++) {
    for (int coin in coins) {
      if (coin <= i) {
        dp[i] = min(dp[i], 1 + dp[i - coin]);
      }
    }
    print('After processing amount $i: $dp');
  }

  print('\nFinal DP array: $dp');
  print('Minimum coins needed for amount $amount: ${dp[amount]}');

  // Reconstruct the solution to show which coins were used
  print('\nCoins used:');
  int remainingAmount = amount;
  while (remainingAmount > 0) {
    for (int coin in coins) {
      if (coin <= remainingAmount &&
          dp[remainingAmount] == dp[remainingAmount - coin] + 1) {
        print('Used coin: $coin');
        remainingAmount -= coin;
        break;
      }
    }
  }
}
