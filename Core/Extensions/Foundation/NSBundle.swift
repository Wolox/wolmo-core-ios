//
//  NSBundle.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension NSBundle {
    
    /**
     Loads a nib from the bundle.
     
     - parameter nibName: Contains a StringRepresentable nib.
     - returns: The loaded NibType or .None if it don't exists.
     - seealso: loadNibNamed()
     */
    public func loadNib<NibType, T: RawRepresentable where T.RawValue == String>(nibName: T) -> NibType? {
        return loadNibNamed(nibName.rawValue, owner: self, options: nil)?[0] as? NibType
    }
    
    /**
     Returns the value associated with the specified key in the receiver's information property list.
     
     The value associated with key in the receiver's property list (Info.plist). 
     The localized value of a key is returned when one is available.
     
     - parameter key: A key in the receiver's property list.
     - returns: The value associated with key in the receiver's property list (Info.plist) or .None if it don't exists.
     - seealso: objectForInfoDictionaryKey()
    */
    public subscript(key: String) -> String? {
        guard let value = objectForInfoDictionaryKey(key) as? String where !value.isEmpty else {
            return .None
        }
        return value
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
