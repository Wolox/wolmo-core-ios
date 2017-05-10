//
//  Collection.swift
//  Core
//
//  Created by Daniela Riesgo on 3/27/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

public extension Collection {
    
    /**
     Returns true if the collection is not empty, false if not.
     */
    public var isNotEmpty: Bool {
        return !isEmpty
    }

    /**
     Returns the first element of the collection for which the predicate returns true,
     or .none if there is no such element.

     - parameter condition: The condition that will be applied.
     - returns: The element that satisfies the predicate or .none if none satisfies.
     - seealso: index(where:)
     */
    public func first(where condition: (Iterator.Element) -> Bool) -> Iterator.Element? {
        return index(where: condition).map { self[$0] }
    }
    
}
