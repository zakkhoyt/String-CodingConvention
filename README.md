## String+CodingConvention.swift

A regex based Swift string extension for converting strings between coding conventions or from coding convention to a sentance.

Useful for populating UIKit components with JSON keys. 

For example: A UILabel reads "Recognised as an Element By" as poplated from a dictionary key: "recognisedAsAnElementBy"

## Functions

### The fun stuff
````
extension String {
    func camelToSnake() -> String 
    func snakeToCamel() -> String 
    func camelToSentance() -> String 
    func snakeToSentance() -> String 
    func removeParenthesis() -> String 
    func lowerCasePrepisitions() -> String     

}
````
### Helper functions
````
extension String {
    // A block based find/replace function based on regex pattern input
    func regexReplace(pattern: String, replace: RegexReplacement) -> String 
    func substring(nsRange: NSRange) -> String     
    func range(nsRange: NSRange) -> Range<Index>     
    subscript(range: CountableRange<Int>) -> String? 
}
````

## Example Usage

````
// Camel to snake
let foo = "myCamelVariable"
let snake = foo.camelToSnake() // my_camel_variable
````
````
// Camal to sentence
let foo = "myCamelVariableAtDinner"
let sentence = foo.camelToSentance() // My Camel Variable At Dinner
let properSentence = sentence.lowerCasePrepisitions() // My Camel Variable at Dinner
````
````
// Snake to camel
let foo = "my_snake_variable"
let camel = foo.snakeToCamel() // mySnakeVariable
````
````
// Snake to sentence
let foo = "my_camel_variable_at_dinner"
let sentence = foo.snakeToSentance() // My Camel Variable At Dinner
let properSentence = sentence.lowerCasePrepisitions() // My Camel Variable at Dinner

````

