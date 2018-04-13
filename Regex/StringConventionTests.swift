//
//  StringConventionTests.swift
//
//  Created by Zakk Hoyt on 4/7/18.
//  Copyright © 2018 Zakk Hoyt. All rights reserved.
//

import Foundation

func test() {
    let snakeStrings: [String] = [
        "another_long_work_day_and_one_more_until_weekend",
        "some_value",
        "testing_at_camel",
        "att_k_(k)",
        ]
    
    let camelStrings: [String] = [
        "anotherLongWord",
        "testingAtCamel",
        "someValue",
        "attKK",
        "aLongURL"
    ]
    
    let sentences: [String] = [
        "Another Long Day At Work",
        "Some Value",
        "Test At Camel Attribue",
        "Att K K",
        ]

    do {
        print("*** Testing camelToSentence")
        for property in camelStrings {
            print("\t\(property)\n\t\(property.camelToSentance())")
        }
    }
    
    do {
        print("*** Testing snakeToCamel")
        for property in snakeStrings {
            print("\t\(property)\n\t\(property.snakeToCamel())")
        }
    }
    
    do {
        print("*** Testing snakeToSentence")
        for property in snakeStrings {
            print("\t\(property)\n\t\(property.snakeToSentance())")
        }
    }
    
    do {
        print("*** Testing lowerCasePrepisitions")
        for property in sentences {
            print("\t\(property)\n\t\(property.lowerCasePrepisitions())")
        }
    }
    
    do {
        print("*** Testing removeParenthesis")
        for property in snakeStrings {
            print("\t\(property)\n\t\(property.removeParenthesis())")
        }
    }
    
    do {
        print("*** Testing camelToSnake")
        for property in camelStrings {
            print("\t\(property)\n\t\(property.camelToSnake())")
        }
    }
    
    do {
        let pattern = "a[a-z]"
        print("*** Testing regexReplace:pattern:regexReplacement with pattern: \(pattern)")
        for property in snakeStrings {
            do {
                let converted = try property.regexReplacePattern(pattern: pattern, replace: { (index, toReplace) -> String in
                    let output = "(" + toReplace.uppercased() + ")"
                    return output
                })
                print("\t\(property)\n\t\(converted)")
            } catch {
                print("caught error: " + error.localizedDescription)
            }
        }
    }
    
    do {
        let pattern = "(a[a-z]+)_.*(d[a-z]+)_.*(u[a-z]+)_"
        print("*** Testing regexReplace:pattern:regexCaptureGroup with pattern: \(pattern)")
        for property in snakeStrings {
            do {
                let converted = try property.regexReplaceCaptureGroups(pattern: pattern, replaceCaptureGroup: { (index, toReplace) -> String in
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
        }
    }
    

}
