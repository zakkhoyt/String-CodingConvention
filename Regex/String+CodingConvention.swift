//
//  String+CodingConvention.swift
//
//  Created by Zakk Hoyt on 4/7/18.
//  Copyright © 2018 Zakk Hoyt. All rights reserved.
//

import Foundation

// Convert coding conventions from one to another or to a sentence suitable for
// presentation in a UI
extension String {

    func camelToSnake() -> String {
        return self.regexReplace(pattern: "[a-z][A-Z]?", replace: { (toReplace) -> String in
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
        return self.regexReplace(pattern: "_[a-z]", replace: { (toReplace) -> String in
            var replaceWith = toReplace.replacingOccurrences(of: "_", with: "")
            replaceWith = replaceWith.uppercased()
            return replaceWith
        })
    }

    func camelToSentance() -> String {
        return self.regexReplace(pattern: "[a-z][A-Z]", replace: { (toReplace) -> String in
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
        return self.regexReplace(pattern: "_[a-z]", replace: { (toReplace) -> String in
            var replaceWith = toReplace.replacingOccurrences(of: "_", with: " ")
            replaceWith = replaceWith.uppercased()
            return replaceWith
        }).capitalized
    }

    func removeParenthesis() -> String {
        return self.regexReplace(pattern: "\\(.\\)", replace: { (toReplace) -> String in
            var replaceWith = toReplace
            replaceWith = replaceWith.replacingOccurrences(of: "(", with: "")
            replaceWith = replaceWith.replacingOccurrences(of: ")", with: "")
            return replaceWith
        })
    }

    func lowerCasePrepisitions() -> String {
        return self.regexReplace(pattern: " [A-z][a-z] ", replace: { (toReplace) -> String in
            let replaceWith = toReplace.lowercased()
            return replaceWith
        })
    }
    
    typealias RegexReplacement = (String) -> String
    /// A block based find/replace function.
    /// Input a regex pattern
    /// replace closure may be called multiple times (once for each occurance)
    /// Implementation of replace is responsible for the actual replacement
    func regexReplace(pattern: String, replace: RegexReplacement) -> String {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(0..<self.utf16.count))
        var working = self
        for _ in 0..<matches.count {
            let matches = regex.matches(in: working, range: NSRange(0..<working.utf16.count))
            guard let match = matches.first else {
                continue
            }
            let range = working.range(nsRange: match.range)
            let toReplace = String(working[range])
            
            let replaceWith = replace(toReplace)
            working.replaceSubrange(range, with: replaceWith)
        }
        return working
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
