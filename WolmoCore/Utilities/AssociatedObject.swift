//
//  AssociatedObject.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

/**
 Sets an associated value for a given object using a given key and association policy, whether it is a value type or a class.
 
 - parameter object: The source object for the association.
 - parameter value: The value to associate with the key for object.
 - parameter key: The key for the association.
 - parameter policy: The policy for the association.
 
 - note: It uses the objc runtime through objc_setAssociatedObject, but wraps the value if it is a struct.
 - warning: Using associated objects should be avoided, as they are used in runtime and not in compile time, and could lead to performance issues.
 - seealso: objc_setAssociatedObject.
 */
public func setAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer, value: T?, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN) {
    guard let value = value else {
        objc_setAssociatedObject(object, key, nil, policy)
        return
    }
    objc_setAssociatedObject(object, key, value, policy)
}

/**
 Returns the value associated with a given object for a given key, whether it is a value type or a class.

 - parameter object: The source object for the association.
 - parameter key: The key for the association.
 - returns: The value associated with the key key for object.
 - note: It uses the objc runtime through objc_setAssociatedObject, but wraps the object if it is a struct.
 - warning: Using associated objects should be avoided, as they are used in runtime and not in compile time, and could lead to performance issues.
 - seealso: objc_getAssociatedObject.
 */
public func getAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer) -> T? {
    if let value = objc_getAssociatedObject(object, key) as? T {
        return value
    } else {
        return .none
    }
}
