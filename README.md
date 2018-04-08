## String+CodingConvention.swift

Swift String extension for converting between coding conventions. e.g. snakeToCamel, camelToSnake, snakeToSentence, camelToSentence.

## Functions
````
// The fun stuff
extension String {
    func camelToSnake() -> String 
    func snakeToCamel() -> String 
    func camelToSentance() -> String 
    func snakeToSentance() -> String 
    func removeParenthesis() -> String 
    func lowerCasePrepisitions() -> String     

}

// Helper functions
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
let camel = "myCamelVariable"
let snake = camel.camelToSnake() // my_camel_variable

// Camal to sentence
let camel = "myCamelVariableAtDinner"
let sentence = camel.camelToSentance() // My Camel Variable At Dinner
let properSentence = sentence.lowerCasePrepisitions() // My Camel Variable at Dinner

// Snake to camel
let snake = "my_snake_variable"
let camel = snake.snakeToCamel() // mySnakeVariable

// Snake to sentence
let snake = "my_camel_variable_at_dinner"
let sentence = snake.snakeToSentance()() // My Camel Variable At Dinner
let properSentence = sentence.lowerCasePrepisitions() // My Camel Variable at Dinner
````

