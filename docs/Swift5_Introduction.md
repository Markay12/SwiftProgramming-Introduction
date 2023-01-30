# Swift 5 Introduction

## Table of Contents

1. [Swift 5: Programming Language Information]()
2. [Swift Data Types]()
3. [Variables and Constants]()
4. [Optionals]()
5. [Data Operations]()
6. [Composite Data Types]()

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

## Arrays

There are many ways to declare an array in Swift 5. An *array* will store values of the same type in an ordered list.

The same value can appear multiple times. This is to say that we can have an array with multiple values of 5.

### Array Type Shorthand Syntax

The type of Swift array is written in full as Array<Element>, where Element is the type of values the array is allowed to store. This type can be written in shorthand form as [Element]. The shorthand form as seen here is what is preferred.

### Creating and Empty Array

This section creates an empty array of a certain type using initializer syntax.

```Swift
var numbers: [Int] = []

print("Numbers is of type [Int] with \(numbers.count) items.")

// This will print what type and the amount of items that are in the array numbers.
```

If the array is already made and filled with values, you can keep the same type but clear the whole array with a new [] operator. This is shown below.

```Swift
numbers = []

// numbers has now been set to a blank array. However, the type of Int has not changed.
```

Arrays can also be created with default values. This includes the value you want to initialize with and how many times it will be repeated. This is done as a part of the initializer and is shown below.

```Swift
var doubles = Array(repreating: 0.0, count: 5)

// This creates an array of type double with five repeated values of 0.0
```

### Combining Arrays

A new array can be created by adding together two existing arrays with the **same** data type. The new data type is inferred when the ararys are combined. 

```Swift
// remember that doubles array is [0.0, 0.0, 0.0, 0.0, 0.0]

var moreDoubles = Array(repeating: 2.5, count: 3)

// combining arrays and output
var combine = moreDoubles + doubles

// this creates the array  of [2.5, 2.5, 2.5, 0.0, 0.0, 0.0, 0.0, 0.0]
```

Arrays can also be created with the array literal. This is another shorthand way to write one or more values as an array collection. An array literal is written as a list of values that are as a pair of brackets.

This example shows an initialized string array that has three values.

```Swift
var baseballTeams: [String] = ["Diamondbacks", "Dodgers", "Red Sox"]

// Swift also has type inference which means we don't need to define String. Swift will pick up on the data type we are using.

var baseball = ["White Sox", "Astros", "Mariners"]
```

This array is declared as an array of string values. Since we have begun defining all values as Strings, this means that we cannot add any integer values to the array. We would need a tuple to have more than strings in this array.



