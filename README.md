# Math
Some functionalities to extend math operations in MiniScript.

# Status
## bigint.ms
```
DESCRIBE: num1 === num2
  IT: Adding num1 + num2
    ✅ PASS: Expected 4827282 to be 4827282
  IT: Subtracting num1 - num2
    ✅ PASS: Expected 0 to be 0
  IT: Reverse Subtracting num2 - num1
    ✅ PASS: Expected 0 to be 0
  IT: Multiplying num1 * num2
    ❌ FAIL: Expected 10766960737681 to be 5825662876881
  IT: LessThan num1 < num2
    ✅ PASS: Expected 0 to be 0
  IT: LessThanEqual num1 <= num2
    ✅ PASS: Expected 1 to be 1
  IT: GreaterThan num1 > num2
    ✅ PASS: Expected 0 to be 0
  IT: GreaterThanEqual num1 >= num2
    ✅ PASS: Expected 1 to be 1
  IT: Equal num1 == num2
    ✅ PASS: Expected 1 to be 1
DESCRIBE: num1 < 0 && num2 < 0
  IT: Adding num1 + num2
    ✅ PASS: Expected -5090817 to be -5090817
  IT: Subtracting num1 - num2
    ❌ FAIL: Expected -21901 to be -13901
  IT: Reverse Subtracting num2 - num1
    ❌ FAIL: Expected 21901 to be 13901
  IT: Multiplying num1 * num2
    ❌ FAIL: Expected 10309420006822 to be 6479056122422
  IT: LessThan num1 < num2
    ✅ PASS: Expected 1 to be 1
  IT: LessThanEqual num1 <= num2
    ✅ PASS: Expected 1 to be 1
  IT: GreaterThan num1 > num2
    ✅ PASS: Expected 0 to be 0
  IT: GreaterThanEqual num1 >= num2
    ✅ PASS: Expected 0 to be 0
  IT: Equal num1 == num2
    ✅ PASS: Expected 0 to be 0
DESCRIBE: num1 < 0 && num2 > 0
  IT: Adding num1 + num2
    ❌ FAIL: Expected -21901 to be -13901
  IT: Subtracting num1 - num2
    ✅ PASS: Expected -5090817 to be -5090817
  IT: Reverse Subtracting num2 - num1
    ✅ PASS: Expected 5090817 to be 5090817
  IT: Multiplying num1 * num2
    ❌ FAIL: Expected -10309420006822 to be -6479056122422
  IT: LessThan num1 < num2
    ✅ PASS: Expected 1 to be 1
  IT: LessThanEqual num1 <= num2
    ✅ PASS: Expected 1 to be 1
  IT: GreaterThan num1 > num2
    ✅ PASS: Expected 0 to be 0
  IT: GreaterThanEqual num1 >= num2
    ✅ PASS: Expected 0 to be 0
  IT: Equal num1 == num2
    ✅ PASS: Expected 0 to be 0
DESCRIBE: num1 > 0 && num2 < 0
  IT: Adding num1 + num2
    ❌ FAIL: Expected 21901 to be 13901
  IT: Subtracting num1 - num2
    ✅ PASS: Expected 5090817 to be 5090817
  IT: Reverse Subtracting num2 - num1
    ✅ PASS: Expected -5090817 to be -5090817
  IT: Multiplying num1 * num2
    ❌ FAIL: Expected -10309420006822 to be -6479056122422
  IT: LessThan num1 < num2
    ✅ PASS: Expected 0 to be 0
  IT: LessThanEqual num1 <= num2
    ✅ PASS: Expected 0 to be 0
  IT: GreaterThan num1 > num2
    ✅ PASS: Expected 1 to be 1
  IT: GreaterThanEqual num1 >= num2
    ✅ PASS: Expected 1 to be 1
  IT: Equal num1 == num2
    ✅ PASS: Expected 0 to be 0
DESCRIBE: num1 > 0 && num2 > 0
  IT: Adding num1 + num2
    ✅ PASS: Expected 5090817 to be 5090817
  IT: Subtracting num1 - num2
    ❌ FAIL: Expected 21901 to be 13901
  IT: Reverse Subtracting num2 - num1
    ❌ FAIL: Expected -21901 to be -13901
  IT: Multiplying num1 * num2
    ❌ FAIL: Expected 10309420006822 to be 6479056122422
  IT: LessThan num1 < num2
    ✅ PASS: Expected 0 to be 0
  IT: LessThanEqual num1 <= num2
    ✅ PASS: Expected 0 to be 0
  IT: GreaterThan num1 > num2
    ✅ PASS: Expected 1 to be 1
  IT: GreaterThanEqual num1 >= num2
    ✅ PASS: Expected 1 to be 1
  IT: Equal num1 == num2
    ✅ PASS: Expected 0 to be 0

TEST SUMMARY:
  Total:  45
  Passed: 34
  Failed: 11

⚠️  Some tests failed
```