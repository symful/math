// @type BigInt
// @property {string} numStr
// @property {number} signedNumber
// @property {list<number>} numArray
BigInt = {}
BigInt.numStr = ""
BigInt.signedNumber = false
BigInt.numArray = []

// @param {string} num
// @return {BigInt}
BigInt.create = function(num)
	bigint = new BigInt
	bigint.numStr = num

	if bigint.numStr[0] == "-" then
		bigint.signedNumber = true
	else
		bigint.signedNumber = false
	end if

	bigint.numArray = bigint.numStr.split("")
	i = 0

	for val in bigint.numArray
		if val == "-" then
			bigint.numArray[i] = 0
		else
			bigint.numArray[i] = val.val
		end if

		i += 1
	end for

	if bigint.signedNumber then
		bigint.numArray.pull
	end if

	return bigint
end function

// @param {BigInt} num2
// @return {BigInt}
BigInt.add = function(num2)
	carry = 0
	result = self.clone

	// Check if both numbers have same sign
	bothNegative = self.signedNumber and num2.signedNumber
	bothPositive = not self.signedNumber and not num2.signedNumber

	if bothNegative or bothPositive then
		// Check which number has more digits
		if self.totalNoOfDigits >= num2.totalNoOfDigits then
			num1Index = self.totalNoOfDigits - 1
			num2Index = num2.totalNoOfDigits - 1

			while num1Index >= 0
				sum = carry + self.getIthDigit(num1Index)

				if num2Index >= 0 then
					sum += num2.getIthDigit(num2Index)
				end if

				if sum >= 10 and num1Index != 0 then
					result.setIthDigit num1Index, sum - 10
				else
					result.setIthDigit num1Index, sum
				end if

				if sum >= 10 then
					carry = 1
				else
					carry = 0
				end if

				num1Index -= 1
				num2Index -= 1
			end while
		else
			result = num2.clone
			num1Index = self.totalNoOfDigits - 1
			num2Index = num2.totalNoOfDigits - 1

			while num2Index >= 0
				sum = carry + num2.getIthDigit(num2Index)

				if num1Index >= 0 then
					sum += self.getIthDigit(num1Index)
				end if

				if sum >= 10 and num2Index != 0 then
					result.setIthDigit num2Index, sum - 10
				else
					result.setIthDigit num2Index, sum
				end if

				if sum >= 10 then
					carry = 1
				else
					carry = 0
				end if

				num1Index -= 1
				num2Index -= 1
			end while
		end if

		// Set the sign of the result
		if bothNegative then
			result.signedNumber = true
		else
			result.signedNumber = false
		end if

	else if self.signedNumber and not num2.signedNumber then
		// Case: num1 is negative, num2 is positive
		tempNum1 = self.abs
		tempNum2 = num2.clone
		result = tempNum2.subtract(tempNum1)

	else if not self.signedNumber and num2.signedNumber then
		// Case: num1 is positive, num2 is negative
		tempNum1 = self.clone
		tempNum2 = num2.abs
		result = tempNum1.subtract(tempNum2)
	end if

	result.numStr = result.toString
	return result
end function

// @return {string}
BigInt.toString = function
	numStr = self.numArray.join("")
	if numStr == "0" * numStr.len then return "0"

	// Trim leading zeros
	while numStr.len > 1 and numStr[0] == "0"
		numStr = numStr[1 : ]
	end while

	if self.signedNumber then numStr = "-" + numStr
	return numStr
end function

// @return {BigInt}
BigInt.clone = function
	return BigInt.create(self.numStr)
end function

// @return {BigInt}
BigInt.abs = function
	if self.numStr[0] == "-" then
		return BigInt.create(self.numStr[1 : ])
	else
		return self.clone
	end if
end function

// @return {number}
BigInt.length = function
	return self.numStr.len
end function

// @return {number}
BigInt.totalNoOfDigits = function
	return self.numArray.len
end function

// @return {number}
BigInt.getIthDigit = function(i)
	return self.numArray[i]
end function

// @param {number} i
// @param {number} digit
BigInt.setIthDigit = function(i, digit)
	self.numArray[i] = digit
end function

// @return {number}
BigInt.isZero = function
	for digit in self.numArray
		if digit != "0" then return false
	end for
	return true
end function

// @param {number} start
// @param {number} endv
// @return {BigInt}
BigInt.slice = function(start, endv)
	sliced = self.numArray[start : endv].join("")
	return BigInt.create(sliced)
end function

// @param {number} n
// @return {BigInt}
BigInt.paddZerosAtStart = function(n)
	zeros = "0" * n
	return BigInt.create(zeros + self.numStr)
end function

// @param {number} n
// @return {BigInt}
BigInt.paddZerosAtEnd = function(n)
	zeros = "0" * n
	return BigInt.create(self.numStr + zeros)
end function

// @param {BigInt} num2
// @return {number}
BigInt.lessThan = function(num2)
	if not self.signedNumber and not num2.signedNumber then
		if self.totalNoOfDigits < num2.totalNoOfDigits then return true
		if self.totalNoOfDigits > num2.totalNoOfDigits then return false

		for i in range(0, self.totalNoOfDigits - 1)
			d1 = self.getIthDigit(i)
			d2 = num2.getIthDigit(i)
			if d1 < d2 then return true
			if d1 > d2 then return false
		end for
	else if self.signedNumber and num2.signedNumber then
		if self.totalNoOfDigits > num2.totalNoOfDigits then return true
		if self.totalNoOfDigits < num2.totalNoOfDigits then return false

		for i in range(0, self.totalNoOfDigits - 1)
			d1 = self.getIthDigit(i)
			d2 = num2.getIthDigit(i)
			if d1 > d2 then return true
			if d1 < d2 then return false
		end for
	else if not self.signedNumber and num2.signedNumber then
		return false
	else
		return true
	end if
	return false
end function

// @param {BigInt} num2
// @return {number}
BigInt.lessThanEqual = function(num2)
	// Case 1: Both numbers are positive
	if not self.signedNumber and not num2.signedNumber then
		if self.length < num2.length then
			return true
		else if self.length > num2.length then
			return false
		else
			if self.numStr == num2.numStr then
				return true
			else
				// Compare digits one by one
				for i in range(0, self.length - 1)
					selfDigit = self.getIthDigit(i)
					num2Digit = num2.getIthDigit(i)

					if selfDigit < num2Digit then
						return true
					else if selfDigit > num2Digit then
						return false
					end if
				end for
			end if
		end if

		// Case 2: Both numbers are negative
	else if self.signedNumber and num2.signedNumber then
		if self.length > num2.length then
			return true
		else if self.length < num2.length then
			return false
		else
			if self.numStr == num2.numStr then
				return true
			else
				// Compare digits one by one (reverse logic for negatives)
				for i in range(0, self.length - 1)
					selfDigit = self.getIthDigit(i)
					num2Digit = num2.getIthDigit(i)

					if selfDigit > num2Digit then
						return true
					else if selfDigit < num2Digit then
						return false
					end if
				end for
			end if
		end if

		// Case 3: self is positive, num2 is negative
	else if not self.signedNumber and num2.signedNumber then
		return false

		// Case 4: self is negative, num2 is positive
	else
		return true
	end if

	// If all digits were equal
	return true
end function

// @param {BigInt} num2
// @return {number}
BigInt.greaterThan = function(num2)
	if not self.signedNumber and not num2.signedNumber then
		if self.totalNoOfDigits > num2.totalNoOfDigits then return true
		if self.totalNoOfDigits < num2.totalNoOfDigits then return false

		for i in range(0, self.totalNoOfDigits - 1)
			d1 = self.getIthDigit(i)
			d2 = num2.getIthDigit(i)
			if d1 > d2 then return true
			if d1 < d2 then return false
		end for
	else if self.signedNumber and num2.signedNumber then
		if self.totalNoOfDigits < num2.totalNoOfDigits then return true
		if self.totalNoOfDigits > num2.totalNoOfDigits then return false

		for i in range(0, self.totalNoOfDigits - 1)
			d1 = self.getIthDigit(i)
			d2 = num2.getIthDigit(i)
			if d1 < d2 then return true
			if d1 > d2 then return false
		end for
	else if not self.signedNumber and num2.signedNumber then
		return true
	else
		return false
	end if
	return false
end function

// @param {BigInt} num2
// @return {number}
BigInt.greaterThanEqual = function(num2)
	if not self.signedNumber and not num2.signedNumber then
		if self.length > num2.length then
			return true
		else if self.length < num2.length then
			return false
		else
			if self.numStr == num2.numStr then
				return true
			else
				// Compare digits one by one
				for i in range(0, self.length - 1)
					d1 = self.getIthDigit(i)
					d2 = num2.getIthDigit(i)
					if d1 > d2 then
						return true
					else if d1 == d2 then
						continue
					else
						return false
					end if
				end for
			end if
		end if
	else if self.signedNumber and num2.signedNumber then
		if self.length < num2.length then
			return true
		else if self.length > num2.length then
			return false
		else
			if self.numStr == num2.numStr then
				return true
			else
				// Compare digits one by one (reverse logic for negative numbers)
				for i in range(0, self.length - 1)
					d1 = self.getIthDigit(i)
					d2 = num2.getIthDigit(i)
					if d1 < d2 then
						return true
					else if d1 == d2 then
						continue
					else
						return false
					end if
				end for
			end if
		end if
	else if not self.signedNumber and num2.signedNumber then
		// Positive is always greater than negative
		return true
	else
		// Negative is never greater than positive
		return false
	end if

	return false
end function

// @param {BigInt} num2
// @return {number}
BigInt.equal = function(num2)
	return self.numStr == num2.numStr
end function

// @param {BigInt} num2
// @return {BigInt}
BigInt.subtract = function(num2)
	borrow = 0
	num1Clone = self.clone
	num2Clone = num2.clone
	result = self.clone

	if (not num1Clone.signedNumber and not num2Clone.signedNumber) or (num1Clone.signedNumber and num2Clone.signedNumber) then

		tempNum1 = self.abs
		tempNum2 = num2.abs

		if tempNum1.greaterThanEqual(tempNum2) then
			num1Index = num1Clone.totalNoOfDigits - 1
			num2Index = num2Clone.totalNoOfDigits - 1

			while num1Index >= 0
				if num2Index >= 0 then
					if num1Clone.getIthDigit(num1Index) >= num2Clone.getIthDigit(num2Index) then
						diff = num1Clone.getIthDigit(num1Index) - num2Clone.getIthDigit(num2Index)
					else
						// Find the borrow
						iNum1Index = num1Index - 1
						while iNum1Index >= 0
							if num1Clone.getIthDigit(iNum1Index) > 0 then
								num1Clone.setIthDigit iNum1Index, num1Clone.getIthDigit(iNum1Index) - 1
								borrow = num1Clone.getIthDigit(num1Index) + 10
								break
							end if
							iNum1Index -= 1
						end while

						// Set zeros to 9 between num1Index and iNum1Index
						for i in range(num1Index - 1, iNum1Index + 1)
							num1Clone.setIthDigit i, 9
						end for

						diff = borrow - num2Clone.getIthDigit(num2Index)
					end if
				else
					diff = num1Clone.getIthDigit(num1Index)
				end if

				result.setIthDigit num1Index, diff
				num1Index -= 1
				num2Index -= 1
			end while
		else
			result = num2Clone.clone
			num1Index = num1Clone.totalNoOfDigits - 1
			num2Index = num2Clone.totalNoOfDigits - 1

			while num2Index >= 0
				if num1Index >= 0 then
					if num2Clone.getIthDigit(num2Index) >= num1Clone.getIthDigit(num1Index) then
						diff = num2Clone.getIthDigit(num2Index) - num1Clone.getIthDigit(num1Index)
					else
						// Find the borrow
						iNum2Index = num2Index - 1
						while iNum2Index >= 0
							if num2Clone.getIthDigit(iNum2Index) > 0 then
								num2Clone.setIthDigit iNum2Index, num2Clone.getIthDigit(iNum2Index) - 1
								borrow = num2Clone.getIthDigit(num2Index) + 10
								break
							end if
							iNum2Index -= 1
						end while

						// Set zeros to 9 between num2Index and iNum2Index
						for i in range(num2Index - 1, iNum2Index + 1)
							num2Clone.setIthDigit i, 9
						end for

						diff = borrow - num1Clone.getIthDigit(num1Index)
					end if
				else
					diff = num2Clone.getIthDigit(num2Index)
				end if

				result.setIthDigit num2Index, diff
				num1Index -= 1
				num2Index -= 1
			end while
		end if

		if num1Clone.signedNumber and num2Clone.signedNumber then
			result.signedNumber = tempNum1.greaterThan(tempNum2)
		else
			result.signedNumber = tempNum1.lessThan(tempNum2)
		end if
	else if not num1Clone.signedNumber and num2Clone.signedNumber then
		num2Clone.signedNumber = false
		result = self.add(num2Clone)
		num2Clone.signedNumber = true
	else if num1Clone.signedNumber and not num2Clone.signedNumber then
		num2Clone.signedNumber = true
		result = self.add(num2Clone)
		num2Clone.signedNumber = false
	end if

	result.numStr = result.toString
	return result
end function

// @param {BigInt} num2
// @return {BigInt}
BigInt.multiply = function(num2)
	if not self.isZero and not num2.isZero then
		result = self.karatsuba(num2)
	else
		return BigInt.create("0")
	end if

	// Set the sign bit
	result.signedNumber = not ((self.signedNumber and num2.signedNumber) or (not self.signedNumber and not num2.signedNumber) or self.isZero or num2.isZero)

	result.numStr = result.toString
	return result
end function

// @param {BigInt} num2
// @return {BigInt}
BigInt.karatsuba = function(num2)
	num1Clone = self.abs
	num2Clone = num2.abs

	// Pad zeros to make lengths equal
	if num1Clone.totalNoOfDigits > num2Clone.totalNoOfDigits then
		num2Clone = num2Clone.paddZerosAtStart(num1Clone.totalNoOfDigits - num2Clone.totalNoOfDigits)
	else if num1Clone.totalNoOfDigits < num2Clone.totalNoOfDigits then
		num1Clone = num1Clone.paddZerosAtStart(num2Clone.totalNoOfDigits - num1Clone.totalNoOfDigits)
	end if

	n = num1Clone.length

	// Base case
	if n == 1 then
		product = num1Clone.getIthDigit(0) * num2Clone.getIthDigit(0)
		return BigInt.create(str(product))
	end if

	// Make sure n is even
	if n % 2 != 0 then
		num1Clone = num1Clone.paddZerosAtStart(1)
		num2Clone = num2Clone.paddZerosAtStart(1)
		n += 1
	end if

	// Split numbers
	a = num1Clone.slice(0, n / 2)
	b = num1Clone.slice(n / 2, n)
	c = num2Clone.slice(0, n / 2)
	d = num2Clone.slice(n / 2, n)

	// Recursive steps
	ac = a.karatsuba(c)
	bd = b.karatsuba(d)
	aPlusB = a.add(b)
	cPlusD = c.add(d)
	adPlusBd = aPlusB.karatsuba(cPlusD)

	// Gauss trick
	adPlusBd = adPlusBd.subtract(ac).subtract(bd)

	// Pad with zeros
	ac = ac.paddZerosAtEnd(n)
	adPlusBd = adPlusBd.paddZerosAtEnd(floor(n / 2))

	return ac.add(adPlusBd.add(bd))
end function



if 0 == 1 then
	// Testing Framework
	Test = {}
	Test.totalTests = 0
	Test.passedTests = 0
	Test.failedTests = 0
	Test.currentDescribe = ""

	// @param {string} description
	Test.describe = function(description)
		self.currentDescribe = description
		print "DESCRIBE: " + description
	end function

	// @param {string} description
	Test.it = function(description)
		print "  IT: " + description
	end function

	// @type Expect
	// @property {any} actual
	Expect = {}
	Expect.actual = null

	Expect.toBe = function(expected)
		Test.totalTests += 1
		if self.actual == expected then
			Test.passedTests += 1
			print "    ✅ PASS: Expected " + self.actual + " to be " + expected
		else
			Test.failedTests += 1
			print "    ❌ FAIL: Expected " + self.actual + " to be " + expected
		end if
	end function
	Expect.toEqual = function(expected)
		Test.totalTests += 1
		if self.actual == expected then
			Test.passedTests += 1
			print "    ✅ PASS: Expected " + self.actual + " to equal " + expected
		else
			Test.failedTests += 1
			print "    ❌ FAIL: Expected " + self.actual + " to equal " + expected
		end if
	end function
	Expect.toNotEqual = function(expected)
		Test.totalTests += 1
		if self.actual != expected then
			Test.passedTests += 1
			print "    ✅ PASS: Expected " + self.actual + " to not equal " + expected
		else
			Test.failedTests += 1
			print "    ❌ FAIL: Expected " + self.actual + " to not equal " + expected
		end if
	end function
	// @return {Expect}
	Expect.create = function(actual)
		expect = new Expect
		expect.actual = actual

		return expect
	end function

	Test.expect = function(actual)
		return Expect.create(actual)
	end function

	Test.summary = function
		print
		print "TEST SUMMARY:"
		print "  Total:  " + self.totalTests
		print "  Passed: " + self.passedTests
		print "  Failed: " + self.failedTests
		print
		if self.failedTests == 0 then
			print "🎉 All tests passed!"
		else
			print "⚠️  Some tests failed"
		end if
	end function
	Test.describe "num1 === num2"
	num1 = BigInt.create("2413641")
	num2 = BigInt.create("2413641")

	Test.it "Adding num1 + num2"
	Test.expect(num1.add(num2).toString).toBe "4827282"

	Test.it "Subtracting num1 - num2"
	Test.expect(num1.subtract(num2).toString).toBe "0"

	Test.it "Reverse Subtracting num2 - num1"
	Test.expect(num2.subtract(num1).toString).toBe "0"

	Test.it "Multiplying num1 * num2"
	Test.expect(num1.multiply(num2).toString).toBe "5825662876881"

	Test.it "LessThan num1 < num2"
	Test.expect(num1.lessThan(num2)).toBe false

	Test.it "LessThanEqual num1 <= num2"
	Test.expect(num1.lessThanEqual(num2)).toBe true

	Test.it "GreaterThan num1 > num2"
	Test.expect(num1.greaterThan(num2)).toBe false

	Test.it "GreaterThanEqual num1 >= num2"
	Test.expect(num1.greaterThanEqual(num2)).toBe true

	Test.it "Equal num1 == num2"
	Test.expect(num1.equal(num2)).toBe true


	Test.describe "num1 < 0 && num2 < 0"
	num1 = BigInt.create("-2552359")
	num2 = BigInt.create("-2538458")

	Test.it "Adding num1 + num2"
	Test.expect(num1.add(num2).toString).toBe "-5090817"

	Test.it "Subtracting num1 - num2"
	Test.expect(num1.subtract(num2).toString).toBe "-13901"

	Test.it "Reverse Subtracting num2 - num1"
	Test.expect(num2.subtract(num1).toString).toBe "13901"

	Test.it "Multiplying num1 * num2"
	Test.expect(num1.multiply(num2).toString).toBe "6479056122422"

	Test.it "LessThan num1 < num2"
	Test.expect(num1.lessThan(num2)).toBe true

	Test.it "LessThanEqual num1 <= num2"
	Test.expect(num1.lessThanEqual(num2)).toBe true

	Test.it "GreaterThan num1 > num2"
	Test.expect(num1.greaterThan(num2)).toBe false

	Test.it "GreaterThanEqual num1 >= num2"
	Test.expect(num1.greaterThanEqual(num2)).toBe false

	Test.it "Equal num1 == num2"
	Test.expect(num1.equal(num2)).toBe false


	Test.describe "num1 < 0 && num2 > 0"
	num1 = BigInt.create("-2552359")
	num2 = BigInt.create("2538458")

	Test.it "Adding num1 + num2"
	Test.expect(num1.add(num2).toString).toBe "-13901"

	Test.it "Subtracting num1 - num2"
	Test.expect(num1.subtract(num2).toString).toBe "-5090817"

	Test.it "Reverse Subtracting num2 - num1"
	Test.expect(num2.subtract(num1).toString).toBe "5090817"

	Test.it "Multiplying num1 * num2"
	Test.expect(num1.multiply(num2).toString).toBe "-6479056122422"

	Test.it "LessThan num1 < num2"
	Test.expect(num1.lessThan(num2)).toBe true

	Test.it "LessThanEqual num1 <= num2"
	Test.expect(num1.lessThanEqual(num2)).toBe true

	Test.it "GreaterThan num1 > num2"
	Test.expect(num1.greaterThan(num2)).toBe false

	Test.it "GreaterThanEqual num1 >= num2"
	Test.expect(num1.greaterThanEqual(num2)).toBe false

	Test.it "Equal num1 == num2"
	Test.expect(num1.equal(num2)).toBe false


	Test.describe "num1 > 0 && num2 < 0"
	num1 = BigInt.create("2552359")
	num2 = BigInt.create("-2538458")

	Test.it "Adding num1 + num2"
	Test.expect(num1.add(num2).toString).toBe "13901"

	Test.it "Subtracting num1 - num2"
	Test.expect(num1.subtract(num2).toString).toBe "5090817"

	Test.it "Reverse Subtracting num2 - num1"
	Test.expect(num2.subtract(num1).toString).toBe "-5090817"

	Test.it "Multiplying num1 * num2"
	Test.expect(num1.multiply(num2).toString).toBe "-6479056122422"

	Test.it "LessThan num1 < num2"
	Test.expect(num1.lessThan(num2)).toBe false

	Test.it "LessThanEqual num1 <= num2"
	Test.expect(num1.lessThanEqual(num2)).toBe false

	Test.it "GreaterThan num1 > num2"
	Test.expect(num1.greaterThan(num2)).toBe true

	Test.it "GreaterThanEqual num1 >= num2"
	Test.expect(num1.greaterThanEqual(num2)).toBe true

	Test.it "Equal num1 == num2"
	Test.expect(num1.equal(num2)).toBe false


	Test.describe "num1 > 0 && num2 > 0"
	num1 = BigInt.create("2552359")
	num2 = BigInt.create("2538458")

	Test.it "Adding num1 + num2"
	Test.expect(num1.add(num2).toString).toBe "5090817"

	Test.it "Subtracting num1 - num2"
	Test.expect(num1.subtract(num2).toString).toBe "13901"

	Test.it "Reverse Subtracting num2 - num1"
	Test.expect(num2.subtract(num1).toString).toBe "-13901"

	Test.it "Multiplying num1 * num2"
	Test.expect(num1.multiply(num2).toString).toBe "6479056122422"

	Test.it "LessThan num1 < num2"
	Test.expect(num1.lessThan(num2)).toBe false

	Test.it "LessThanEqual num1 <= num2"
	Test.expect(num1.lessThanEqual(num2)).toBe false

	Test.it "GreaterThan num1 > num2"
	Test.expect(num1.greaterThan(num2)).toBe true

	Test.it "GreaterThanEqual num1 >= num2"
	Test.expect(num1.greaterThanEqual(num2)).toBe true

	Test.it "Equal num1 == num2"
	Test.expect(num1.equal(num2)).toBe false

	Test.summary
end if