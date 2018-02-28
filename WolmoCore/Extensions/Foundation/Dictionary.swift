//
//  Dictionary.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 2/24/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

public extension Dictionary where Value == Any {

    /**
         Returns the value associated with the specified key casted to T
         (the type of the default value), or the specified default value
         if the key didn't have a value or if it couldn't be casted to T.

         Uses autoclosure so your default value won't be created if it's not needed.
     
         - warning: This will raise a runtime assertion error if there is a value in the dictionary
                but it's not of the same time as the default value. For that case, you should
                handle it some other way.
     */
    public func castedValue<T>(forKey key: Key, or defaultValue: @autoclosure () -> T) -> T {
        guard let value = self[key] else { return defaultValue() }
        guard let castedValue = value as? T else {
            fatalError("The dictionary's value to key \(key) is not of type \(T.self)")
        }
        return castedValue
    }

}
