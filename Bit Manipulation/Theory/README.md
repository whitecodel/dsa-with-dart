# Bit Manipulation

## Overview

Bit Manipulation involves directly manipulating bits of binary numbers using bitwise operations. It's an essential technique in computer programming that allows for highly optimized code in various applications like cryptography, compression algorithms, embedded systems programming, and competitive programming problems.

## Key Concepts

### Binary Representation

In computers, all data is stored in binary format (0s and 1s). For example:

- Decimal 5 = Binary 101
- Decimal 10 = Binary 1010
- Decimal 15 = Binary 1111

### Basic Bitwise Operations

#### AND (&)

- Returns 1 if both corresponding bits are 1, otherwise returns 0
- Example: 5 & 3 = 101 & 011 = 001 = 1

#### OR (|)

- Returns 1 if at least one of the corresponding bits is 1, otherwise returns 0
- Example: 5 | 3 = 101 | 011 = 111 = 7

#### XOR (^)

- Returns 1 if exactly one of the corresponding bits is 1 (they are different), otherwise returns 0
- Example: 5 ^ 3 = 101 ^ 011 = 110 = 6
- XOR has the special property: a ^ a = 0 and a ^ 0 = a

#### NOT (~)

- Flips all the bits (0 becomes 1, 1 becomes 0)
- Example: ~5 = ~(101) = 010 (ignoring sign bit for simplicity)
- In Dart, ~n = -(n+1) due to two's complement representation

#### Left Shift (<<)

- Shifts all bits to the left by specified positions
- Example: 5 << 1 = 101 << 1 = 1010 = 10
- Left shift by n is equivalent to multiplication by 2ⁿ

#### Right Shift (>>)

- Shifts all bits to the right by specified positions
- Example: 5 >> 1 = 101 >> 1 = 10 = 2
- Right shift by n is equivalent to integer division by 2ⁿ

### Common Bit Manipulation Techniques

#### Check if a bit is set

```dart
bool isBitSet(int num, int position) {
  return ((num & (1 << position)) != 0);
}
```

#### Set a bit

```dart
int setBit(int num, int position) {
  return num | (1 << position);
}
```

#### Clear a bit

```dart
int clearBit(int num, int position) {
  return num & ~(1 << position);
}
```

#### Toggle a bit

```dart
int toggleBit(int num, int position) {
  return num ^ (1 << position);
}
```

#### Count set bits (Hamming Weight)

```dart
int countSetBits(int num) {
  int count = 0;
  while (num > 0) {
    count += num & 1;
    num >>= 1;
  }
  return count;
}
```

### Advanced Techniques

#### Isolating the rightmost set bit

```dart
int isolateRightmostSetBit(int num) {
  return num & -num;  // or: num & (~num + 1)
}
```

#### Remove the rightmost set bit

```dart
int removeRightmostSetBit(int num) {
  return num & (num - 1);
}
```

#### Check if number is a power of 2

```dart
bool isPowerOfTwo(int num) {
  return num > 0 && (num & (num - 1)) == 0;
}
```

## Applications

1. **Optimization**: Bit manipulation can optimize code that would otherwise require more complex operations
2. **Flags and Attributes**: Using bits to store boolean attributes (like permissions)
3. **Data Compression**: Efficient storage of data
4. **Cryptography**: For encryption and hashing algorithms
5. **Low-level Hardware Interaction**: In embedded systems and device drivers

## Common Pitfalls

1. **Readability**: Bit manipulation code can be hard to read and maintain
2. **Platform Dependency**: Behavior may vary across languages and systems
3. **Operator Precedence**: Be careful with operator precedence in complex expressions
4. **Sign Extension**: Be aware of sign extension in right shifts

## Time and Space Complexity

Most bit operations (AND, OR, XOR, NOT, shifts) have O(1) time complexity as they are native CPU operations. Space complexity is also typically O(1) as they operate directly on the bits.

## When to Use

Consider bit manipulation when:

- Working with binary data or flags
- Optimizing for space efficiency
- Solving problems involving binary patterns or masks
- Working on systems with limited resources
- Implementing mathematical algorithms that map well to bitwise operations

## Dart-Specific Notes

- Dart uses fixed-width 64-bit integers by default
- Bitwise operations work as expected on integers in Dart
- The `~` operator in Dart performs a bitwise negation (NOT)
- Dart provides functions like `toRadixString(2)` to convert numbers to binary strings
