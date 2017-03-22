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
     */
    public func loadNib<NibType, T: RawRepresentable>(named nibName: T) -> NibType? where T.RawValue == String {
        return loadNibNamed(nibName.rawValue, owner: self, options: nil)?[0] as? NibType
    }
    
    /**
     Returns the value associated with the specified key in the receiver's information property list.
     
     The value associated with key in the receiver's property list (Info.plist). 
     The localized value of a key is returned when one is available.
     
     - parameter key: A key in the receiver's property list.
     - returns: The value associated with key in the receiver's property list (Info.plist) or .none if it don't exists.
     - seealso: objectForInfoDictionaryKey()
    */
    public subscript(key: String) -> String? {
        guard let value = object(forInfoDictionaryKey: key) as? String, !value.isEmpty else {
            return .none
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
