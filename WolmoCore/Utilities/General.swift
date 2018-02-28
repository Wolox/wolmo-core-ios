//
//  General.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

/**
    Returns the type's simple name.
    That is to say:
        without scope prefixes,
        without properties' values if it's a struct.
 */
public func SimpleName(ofType type: Any.Type) -> String {
    return String(describing: type).components(separatedBy: ".").last!
}

/**
     Returns the concrete type's simple name.
     That is to say:
        without scope prefixes,
        without properties' values if it's a struct.
 
    - seealso: type(of:)
 */
public func SimpleName<T>(of element: T) -> String {
    return SimpleName(ofType: type(of: element as Any))
    // Using as Any to get dynamic type for cases like protocol conforming types.
}
