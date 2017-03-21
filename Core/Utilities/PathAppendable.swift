//
//  PathAppendable.swift
//  Core
//
//  Created by Daniela Riesgo on 3/3/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

/**
     Appends a path component to the string, similar to web resource addressing.
     
     - parameter basePath: base string.
     - parameter pathComponent: PathAppendable that will be appended.
     
     - returns: The new NSURL, with pathComponent appended to baseURL.
     - seealso: `appendingPathComponent` from NSString.
 */
public func / (basePath: String, pathComponent: PathAppendable) -> String {
    return (basePath as NSString).appendingPathComponent(pathComponent.toPath())
}


/**
    Represents a component that can be part of a path,
    by representing itself with a string to be appended to the path.
 */
public protocol PathAppendable {
    
    /**
         String represention of the path that represents the component.
     
         By default, it uses the String's describing init.
         This means you can override the `toPath` function,
         or implement the `CustomStringConvertible` protocol and override
         the `description` property.
         
         - see also: `String(describing: Subject)` init.
    */
    func toPath() -> String
    
}

public extension PathAppendable {
    
    public func toPath() -> String {
        return String(describing: self)
    }
    
}

extension String: PathAppendable {}
extension Int: PathAppendable {}
extension UInt: PathAppendable {}
