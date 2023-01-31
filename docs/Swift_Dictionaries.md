# Swift Dictionaries Documentation

Dictionaries store associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value in a dictionary is associated with its unique key. For instance, Tempe is located in Arizona. This key acts as an identifier for that value within the dictionary. To look up values within a dictionary you need to look up the values based on the identifier. Thus, for the case described above, we would use Arizona to find the city Tempe. 

The type of a Swift dictionary is written as a Dictionary \<Key, Value\>, where key is the type of value that can be used as a dictionary key and Value is the type of value that the dictionary stores for those keys.

A shorthand form for a dictionary is written as [Key: Value]. Although those two forms are identical the Swift 5 documentation recommends using the shorthand form.

# Table of contents

1. [Create an Empty Dictionary]()
2. [Create Dictionary with Dictionary Literal]()
---

## Creating an Empty Dictionary

To create an empty dictionary of a certain type with the initializer we do:

```Swift
// create a dictionary of integers as an empty [Int: String] dictionary

var numbers: [Int: String] = [:]
```

This code will create an empty dictionary type [Int: String] to store human-readable names of integer values. The keys are going to be of the type Int and its stored values are of type String.


## Create a Dictionary with a Dictionary Literal

This definition has similar syntax to what we have seen before. A dictionary literal is a shorthand way to write one of more key-value pairs as a Dictionary collection.

A key-value pair is a combination of a key and a value. In a dicitonary literal, the key and value in each key-value pair are separated by a colon. The key-value pairs are written as a list, separated by commans and surrounded by a pair of square brackets.

`[key1 : value1, key2 : value2, ... , key_n : value_n]`

Once again we will go back to baseball teams but use locations and team names. The location will be the key to the value of the team.

```Swift
var baseballTeamsDict : [String : String] = ["Houston" : "Astros", "Los Angeles" : "Dodgers"]
```

This baseball team dictionary is declared as having a type of [String: String] which means the Keys are Strings as well as the Values.

In the above dictionary there are two key-value pairs.

The same thing with arrays can happen with dictionaries when specifying the types of the data that will be used. We don't need to specify that both of these are strings, Swift 5 can figure that out itself.

```Swift
var baseballTeamsDict = ["Houston" : "Astros", "Los Angeles" : "Dodgers"]
```

All keys in the literal are of the same type and the same with the values. Swift 5 can infer the correct type without us having to specify.
