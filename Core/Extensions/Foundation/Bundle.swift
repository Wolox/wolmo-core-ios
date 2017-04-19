//
//  Bundle.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension Bundle {
    
    /**
     Loads a nib from the bundle.
     
     - parameter nibName: Contains a StringRepresentable nib.
     - returns: The loaded NibType or .none if it don't exists.
     - seealso: loadNibNamed()
     - warning: This may through an ObjC NSException if there is no
        nib with that name in that bundle.
     */
    public func loadNib<NibType, T: RawRepresentable>(named nibName: T) -> NibType? where T.RawValue == String {
        return loadNibNamed(nibName.rawValue, owner: self, options: .none)?[0] as? NibType
    }
    
    /**
     Returns the value associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The string representation of the value associated with key in the
            receiver's property list (Info.plist) or .none if the key doesn't exist.
     - seealso: object(forInfoDictionaryKey:) and String(describing:)
    */
    public subscript(key: String) -> String? {
        guard let value = object(forInfoDictionaryKey: key) else {
            return .none
        }
        let stringValue = value as? String ?? String(describing: value)
        return stringValue
    }
    
    /**
     Returns the string associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The string associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not a string.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getString(from key: String) -> String? {
        guard let value = object(forInfoDictionaryKey: key) as? String else {
            return .none
        }
        return value
    }
    
    /**
     Returns the integer associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The integer associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not an integer.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getInt(from key: String) -> Int? {
        guard let value = object(forInfoDictionaryKey: key) as? Int else {
            return .none
        }
        return value
    }
    
    /**
     Returns the float number associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The float associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not not a real number.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getFloat(from key: String) -> Float? {
        guard let value = object(forInfoDictionaryKey: key) as? Float else {
            return .none
        }
        return value
    }
    
    /**
     Returns the date associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The date associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not a date.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getDate(from key: String) -> Date? {
        guard let value = object(forInfoDictionaryKey: key) as? Date else {
            return .none
        }
        return value
    }
    
    /**
     Returns the data associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The data associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not data.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getData(from key: String) -> Data? {
        guard let value = object(forInfoDictionaryKey: key) as? Data else {
            return .none
        }
        return value
    }
    
    /**
     Returns the array associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The array associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not an array of elements
            of type T.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getArray<T>(from key: String) -> [T]? {
        guard let value = object(forInfoDictionaryKey: key) as? NSArray,
              let swiftArray = value as? [T] else {
            return .none
        }
        return swiftArray
    }
    
    /**
     Returns the dictionary associated with the specified key in the receiver's
     information property list (Info.plist).
     
     - parameter key: A key in the bundle's property list.
     - returns: The dictionary associated with key in the receiver's property list (Info.plist)
            or .none if the key doesn't exist or if the value is not a dictionary of
            keys of type K and values of type V.
     - seealso: object(forInfoDictionaryKey:)
     */
    public func getDictionary<V>(from key: String) -> [String: V]? {
        guard let value = object(forInfoDictionaryKey: key) as? NSDictionary,
              let swiftDictionary = value as? [String: V] else {
            return .none
        }
        return swiftDictionary
    }
    
}

extension String: RawRepresentable {
    
    public init?(rawValue: String) {
        self = rawValue
    }
    
    public var rawValue: String {
        return self
    }
    
}
