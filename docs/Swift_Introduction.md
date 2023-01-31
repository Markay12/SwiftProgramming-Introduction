# Swift 5 Introduction

## Table of Contents

1. [Swift 5: Programming Language Information](https://github.com/Markay12/SwiftProgramming-Introduction/blob/main/docs/Swift5_Introduction.md#swift-5-programming-language-information)
2. [Swift Data Types](https://github.com/Markay12/SwiftProgramming-Introduction/blob/main/docs/Swift5_Introduction.md#swift-data-types)
3. [Variables and Constants](https://github.com/Markay12/SwiftProgramming-Introduction/blob/main/docs/Swift5_Introduction.md#variables-and-constants)
4. [Optionals](https://github.com/Markay12/SwiftProgramming-Introduction/blob/main/docs/Swift5_Introduction.md#optionals)
5. [Data Operations](https://github.com/Markay12/SwiftProgramming-Introduction/blob/main/docs/Swift5_Introduction.md#data-operations)
6. [Composite Data Types](https://github.com/Markay12/SwiftProgramming-Introduction/blob/main/docs/Swift5_Introduction.md#composite-data-types)

---

## Swift 5: Programming Language Information

- Swift is the primary language that is used for iOS development in 2023. However, some applications will still use Objective-C as we may see. A combination of these two lanagues can be used. 

- Swift programming can be used for iOS, MacOS, watchOS and tvOS applications.

## Swift Data Types 

All basic data types are supported (ones that you would find in other languages).

- Integers (Int, Int8, Int16, Int32, Int64, UInt32): All of which define the amount of bits the integer stores and can be defined as signed or unsigned integers.

- Float: 32bit decimal values.

- Double: 64bit decimal values.

- Boolean (Bool): Boolean value used to set *true* or *false*

- Character: Single character literal. Something to keep in mind for Swift 5 is that even single character literals will use double quotes around them.

- String: Collection of characters. Strings will also use double quotes.

## Variables and Constants

The `var` keyword is used to create variables and `let` is used for constants.

```Swift
// Variables
var x = 10
var name:String = "Mark"
var weight:Double = 155.4

// Constants
let const:Int = 21
let const2 = 22.75
```

## Optionals

Optionals are required if we want to assign a value of nil (equivalent to NULL) to a varibale. Variables that are not optional will not be able to be set to the value of nil.

```Swift
// Declaring Optionals
var name:String?
name = "Mark"
print(name)  // will print the name Mark

print(name!) // this will unwrap the optional value
name = nil   // set name value to nil
print(name)  // observed the output
```

Error checking can also be done with optionals. 

```Swift
var name:String?

name = "Mark"

if let check = name 
{

	print(check)

} 
else
{

	print("Name is null") 

}

var string : String!

// doing print(string) will throw an error

if let check = string
{

	print(check)

}
else
{

	print("String is null")

}
```

## Data Operations

1. Operator: `*` 
	- Desctiption: Multiplication
2. Operator: `/`
	- Description: Division
3. Operator: `+`
	- Description: Addition
4. Operator: `-`
	- Description: Subtraction
5. Operator`%`
	- Desctription: Modulo
6. Operator: `x == y`
	- Description: Returns true if x is equal to y.
7. Operator: `x > y`
	- Description: Returns true if x is greater than y.
8. Operator: `x >= y`
	- Description: Returns true if x is greater than or equal to y.
9. Operator: `x < y`
	- Description: Returns true if x is less than y.
10. Operator: `x <= y`
	- Description: Returns true if x is less than or equal to y.
11. Operator: `x != y`
	- Description: Returns true if x is not equal to y.
12. Operator: `x += y`
	- Description: Add x to value y and place the result in value x.
13. Operator: `x -= y`
	- Description: Subtract value x from value y and place the result in value x.
14. Operator: `x *= y`
	- Description: Multiply value x to value y and place the result in value x.
15. Operator: `x /= y`
	- Description: Divide x by the value y and place the result in x.
16. Operator: `x %= y`
	- Description: Perform modulo operation on x and y and place the result in x.`

## Composite Data Types

Tuples: A data structure that is capable of storing more than one type in a single variable. This is especially useful when a method returns multiple values.

**Tuple Operations**
`let x = (21, 155.2, "Mark")` and to acces information we would use the index. Therefore, x.0 would be equal to 27.

We can also define each individual variable within the structure.

`let y = (age: 21, weight: 155.2, name="Mark")` 

and to access this information we use the name of the data. y.weight = 155.2

To copy over information we can use `let (l, m, n) = x`. This will copy the information into variables l, m and n. 


## Document Summary

This document is a good intitial look into the operator values and data types that are used with Swift programming. 

Further documentation attempts to explain and dive further into the innerworkings of Swift programming.


