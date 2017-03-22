//
//  Dictionary.swift
//  Core
//
//  Created by Daniela Riesgo on 2/24/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /**
        Returns a new dictionary with the contents of self and the given `dictionary`.
        If both dictionaries have the same key with different value, the result
        will have that key with the value found in `dictionary`.
    */
    public func appending(contentsOf dictionary: [Key: Value]) -> [Key: Value] {
        var result = self
        result.append(contentsOf: dictionary)
        return result
    }
    
    /**
         Adds to self the contents of the given `dictionary`.
         If both dictionaries have the same key with different value,
         the result will have that key with the value found in `dictionary`.
     */
    public mutating func append(contentsOf dictionary: [Key: Value]) {
        for (key, value) in dictionary {
            updateValue(value, forKey: key)
        }
    }
    
}
