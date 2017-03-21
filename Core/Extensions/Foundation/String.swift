//
//  String.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension String {
    
    /**
     Returns a localized representation of the string.
     
     - parameter bundle: Bundle were to search for localization.
     - parameter arguments: Formatting arguments.
     */
    public func localized(withArguments arguments: CVarArg..., bundle: Bundle = Bundle.main) -> String {
        let localized = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        if arguments.count > 0 {
            return String(format: localized, arguments: arguments)
        }
        return localized
    }
    
    /**
     Returns the length of the string.
     
     - Complexity: O(1) if String's `Index` conforms to `RandomAccessIndexType`;
     O(N) otherwise.
     - note: It is a function and not a property because possible O(N) computation cost.
     - seealso: CharacterView.count
     */
    public func length() -> Int {
        return characters.count
    }
    
    /**
     Builds an NSURL from a string.
     */
    public var url: URL? {
        return URL(string: self)
    }
    
    /**
     Checks if the string has spaces or not.
     */
    public var hasSpaces: Bool {
        let whitespace = CharacterSet.whitespaces
        let range = rangeOfCharacter(from: whitespace)
        return range != .none
    }
    
    /**
     Checks if a string is a valid email or not.
    */
    public func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /*
     Returns a copy of the string without its leading and trailing whitespace and newlines.
     */
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /**
     Returns a new string in which all occurrences of a target string in a specified range of the String are replaced by another given string.
     
     - parameter target: The string to replace.
     - parameter with: The replacement.
     - parameter options: The comparing options. Default: LiteralSearch
     - parameter range: The range of the string to search.
     - seealso: stringByReplacingOccurrencesOfString().
     */
    public func replacing(_ target: String, with replacement: String, options: NSString.CompareOptions = .literal, range: Range<Index>? = .none) -> String {
        return replacingOccurrences(of: target, with: replacement, options: .literal, range: range)
    }
    
    /**
     Returns a new string without whitespaces.
     */
    public var withoutWhiteSpaces: String {
        return replacing(" ", with: "")
    }
    
    /**
     Returns true if the string is not empty, false if not.
    */
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    /**
     Returns true if self contains the given `searchString`, false if not.
    */
    public func contains(searchString: String) -> Bool {
        return range(of: searchString) != .none
    }
    
    /**
     Returns a new string that contains the same as self except
     for the given `suffix`.
     If it doesn't have the suffix, it returns the same as self.
     If it has the suffix more than one time, it just removes the
     last occurence of it.
    */
    public func remove(suffix: String) -> String {
        if hasSuffix(suffix) {
            return String(characters.dropLast(suffix.characters.count))
        }
        return self
    }
    
    /**
     Returns a new string that contains the same as self except
     for the given `prefix`.
     If it doesn't have the prefix, it returns the same as self.
     If it has the prefix more than one time, it just removes the
     first occurence of it.
     */
    public func remove(prefix: String) -> String {
        if hasPrefix(prefix) {
            return String(characters.dropFirst(prefix.characters.count))
        }
        return self
    }
    
}
