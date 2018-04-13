//
//  String+CodingConvention.swift
//
//  Created by Zakk Hoyt on 4/7/18.
//  Copyright © 2018 Zakk Hoyt. All rights reserved.
//

import Foundation

// snake to camel
//  :%s:\(_\)\([a-z]\):\U\2:g
// camel to snake
//  %s:\([a-z]\)\([A-Z]\):\L\1_\2:g
// Snake to sentence (but last work remains lower cased)
//  %s:\([a-z]*\)_:\L\u\1 :g
//  2a. %s:\([a-z]*\):\L\u\1:g
//  2b. %s:_: :g

// Convert coding conventions from one to another or to a sentence suitable for
// presentation in a UI
extension String {
    
    func camelToSnake() -> String {
        return try! self.regexReplace(pattern: "[a-z][A-Z]?", replace: { (index, toReplace) -> String in
            // We now have a lower case letter followed by
            // an upper case letter "lU". Insert a space between
            // them and apply to working copy
            guard let first = toReplace[0..<1],
                let second = toReplace[1..<2] else {
                    return toReplace
            }
            let replaceWith = "\(first)_\(second.lowercased())"
            return replaceWith
        })
    }
    
    func snakeToCamel() -> String {
        return try! self.regexReplace(pattern: "_[a-z]", replace: { (index, toReplace) -> String in
            var replaceWith = toReplace.replacingOccurrences(of: "_", with: "")
            replaceWith = replaceWith.uppercased()
            return replaceWith
        })
    }
    
    func camelToSentance() -> String {
        return try! self.regexReplace(pattern: "[a-z][A-Z]", replace: { (index, toReplace) -> String in
            // We now have a lower case letter followed by
            // an upper case letter "lU". Insert a space between
            // them and apply to working copy
            guard let first = toReplace[0..<1],
                let second = toReplace[1..<2] else {
                    return toReplace
            }
            let replaceWith = "\(first) \(second.uppercased())"
            return replaceWith
        }).capitalized
    }
    
    func snakeToSentance() -> String {
        return try! self.regexReplace(pattern: "_[a-z]", replace: { (index, toReplace) -> String in
            var replaceWith = toReplace.replacingOccurrences(of: "_", with: " ")
            replaceWith = replaceWith.uppercased()
            return replaceWith
        }).capitalized
    }
    
    func removeParenthesis() -> String {
        return try! self.regexReplace(pattern: "\\(.\\)", replace: { (index, toReplace) -> String in
            var replaceWith = toReplace
            replaceWith = replaceWith.replacingOccurrences(of: "(", with: "")
            replaceWith = replaceWith.replacingOccurrences(of: ")", with: "")
            return replaceWith
        })
    }
    
    func lowerCasePrepisitions() -> String {
        return try! self.regexReplace(pattern: " [A-z][a-z] ", replace: { (index, toReplace) -> String in
            let replaceWith = toReplace.lowercased()
            return replaceWith
        })
    }
    
    private typealias Replacement = (range: Range<String.Index>, replaceWith: String)
    
    /// A block based find/replace function.
    /// Input a regex pattern
    /// replace closure may be called multiple times (once for each occurance)
    /// Implementation of replace is responsible for the actual replacement
    typealias RegexReplacement = (_ index: Int, _ toReplace: String) -> String
    func regexReplace(pattern: String, replace: RegexReplacement) throws -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            var replacements: [Replacement] = []
            let matches = regex.matches(in: self, range: NSRange(0..<self.utf16.count))
            for (index, match) in matches.reversed().enumerated() {
                let range = self.range(nsRange: match.range)
                let toReplace = String(self[range])
                let replaceWith = replace(index, toReplace)
                let tuple = Replacement(range, replaceWith)
                replacements.append(tuple)
                
            }
            var working = self
            for replacement in replacements {
                working.replaceSubrange(replacement.range, with: replacement.replaceWith)
            }
            return working
        } catch {
            throw error
        }
    }
    
    typealias RegexCaptureGroup = (_ captureGroupIndex: Int, _ toReplace: String) -> String
    func regexReplace(pattern: String, replaceCaptureGroup: RegexCaptureGroup) throws -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            var replacements: [Replacement] = []
            regex.matches(in: self, range: NSRange(0..<self.utf16.count)).forEach { (match) in
                // Build list in reverse
                for r in stride(from: match.numberOfRanges - 1, to: 0, by: -1) {
                    let nsRange = match.range(at: r)
                    let range = self.range(nsRange: nsRange)
                    let toReplace = String(self[range])
                    let replaceWith = replaceCaptureGroup(r, toReplace)
                    let tuple = Replacement(range, replaceWith)
                    replacements.append(tuple)
                }
            }
            
            var working = self
            for replacement in replacements {
                working.replaceSubrange(replacement.range, with: replacement.replaceWith)
            }
            return working
        } catch {
            throw error
        }
        
    }
}

// Helper functions
extension String {
    func substring(nsRange: NSRange) -> String {
        return String(self[self.range(nsRange: nsRange)])
    }
    
    func range(nsRange: NSRange) -> Range<Index> {
        let start = index(startIndex, offsetBy: nsRange.location)
        let end = index(start, offsetBy: nsRange.length)
        return start..<end
    }
    
    subscript(range: CountableRange<Int>) -> String? {
        if range.lowerBound < 0 { return nil }
        if range.upperBound < 0 { return nil }
        if range.lowerBound > count { return nil }
        if range.upperBound > count { return nil }
        
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[start..<end])
    }
    
    
}
