## String+CodingConvention.swift

A regex powered string extension for converting strings from one coding conventions to another, or converting from coding convention to a sentance/title.

This extension is wseful for populating UIKit components with JSON keys. 

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
    func regexReplace(pattern: String, replace: RegexReplacement) throws -> String {
    func regexReplace(pattern: String, replaceCaptureGroup: RegexCaptureGroup) throws -> String {
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

## Other useful utilities

### Closure based regex find/replace based on pattern
````
let text = "another_long_work_day_and_one_more_until_weekend"
let pattern = "a[a-z]"
print("*** Testing regexReplace:pattern:regexReplacement with pattern: \(pattern)")
do {
    let converted = try property.regexReplacePattern(pattern: pattern, replace: { (index, toReplace) -> String in
        let output = "(" + toReplace.uppercased() + ")"
        return output
    })
    print("\t\(property)\n\t\(converted)")
} catch {
    print("caught error: " + error.localizedDescription)
}
// (AN)other_long_work_d(AY)_(AN)d_one_more_until_weekend
````

### Closure based regex find/replace based on capture groups (stuff inside parenthesis)
````
let text = "another_long_work_day_and_one_more_until_weekend"
let pattern = "(a[a-z]+)_.*(d[a-z]+)_.*(u[a-z]+)_"
do {
    let converted = try text.regexReplaceCaptureGroups(pattern: pattern, replace: { (index, toReplace) -> String in
        if index % 2 == 0 {
            return "(" + "<redacted>" + ")"
        } else {
            return "(" + toReplace.uppercased() + ")"
        }
    })
    print("\t\(property)\n\t\(converted)")
} catch {
    print("caught error: " + error.localizedDescription)
}
// (ANOTHER)_long_work_(<redacted>)_and_one_more_(UNTIL)_weekend
````
