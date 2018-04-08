//
//  StringConventionTests.swift
//
//  Created by Zakk Hoyt on 4/7/18.
//  Copyright © 2018 Zakk Hoyt. All rights reserved.
//

import Foundation

func test() {
    do {
        print("*** Testing camelToSentence")
        let properties: [String] = [
            "anotherLongWord",
            "testingAtCamel",
            "someValue",
            "attKK",
            "aLongURL"
        ]
        
        //for i in 0..<properties.count {
        for property in properties {
            print("\t\(property): \(property.camelToSentance())")
        }
    }
    
    do {
        print("*** Testing snakeToCamel")
        let properties: [String] = [
            "another_long_work_day",
            "some_value",
            "testing_at_camel",
            "att_k_(k)",
            ]
        
        
        for property in properties {
            print("\t\(property) \(property.snakeToCamel())")
        }
    }
    
    do {
        print("*** Testing snakeToSentence")
        let properties: [String] = [
            "another_long_day_at_work",
            "some_value",
            "testing_at_camel",
            "att_k_(k)",
            ]
        
        
        for property in properties {
            print("\t\(property): \(property.snakeToSentance())")
        }
    }
    
    do {
        print("*** Testing lowerCasePrepisitions")
        let properties: [String] = [
            "Another Long Day At Work",
            "Some Value",
            "Test At Camel Attribue",
            "Att K K",
            ]
        
        
        for property in properties {
            print("\t\(property) \(property.lowerCasePrepisitions())")
        }
    }
    
    do {
        print("*** Testing removeParenthesis")
        let properties: [String] = [
            "att_k_(k)",
            ]
        
        
        for property in properties {
            print("\t\(property) \(property.removeParenthesis())")
        }
    }
    
    do {
        print("*** Testing camelToSnake")
        let properties: [String] = [
            "anotherLongWord",
            "testingAtCamel",
            "someValue",
            "attKK",
            ]
        
        
        for property in properties {
            print("\t\(property) \(property.camelToSnake())")
        }
    }
    
    

    
}
