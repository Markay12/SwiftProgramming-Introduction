# Swift 5 Introduction

## Table of Contents

1. [Swift 5: Programming Language Information]()
2. [Swift Data Types]()
3. [Variables and Constants]()
4. [Optionals]()
5. [Data Operations]()

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

1. Operator `*` 
	- Desctiption: Multiplication
