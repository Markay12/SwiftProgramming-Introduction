# Arrays

There are many ways to declare an array in Swift 5. An *array* will store values of the same type in an ordered list.

The same value can appear multiple times. This is to say that we can have an array with multiple values of 5.

## Array Type Shorthand Syntax

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

## Combining Arrays

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

## Accessing and Modifying an Array

