//
//  Array.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension Array {
    
    /**
     Groups elements by the criteria provided.
     
     - parameter keyForElement: returns the appropiate key for each element.
     
     - returns: Dictionary with elements grouped by their corresponding keys.
     */
    public func group<K>(by keyForElement: (Element) -> K) -> [K: [Element]] {
        return Dictionary(grouping: self, by: keyForElement)
    }
    
    /**
     Returns a new array with element appended to the Array.
     
     - Complexity: Amortized O(1) unless self's storage is shared with another live array; 
     O(count) if self does not wrap a bridged NSArray; otherwise the efficiency is unspecified.
     - seealso: append().
    */
    public func appending(_ element: Element) -> [Element] {
        var result = self
        result.append(element)
        return result
    }
    
    /**
     Returns the indexth element.
     - Complexity:
     Reading is O(1). 
     Writing is O(1) unless self's storage is shared with another live array; 
     O(count) if self does not wrap a bridged NSArray; otherwise the efficiency is unspecified..
     
     - Note: This function should be used over subscript when we don't want a runtime error when indexth element doesn't exist.
     - Warning: Returns .none if the index is out of bound.
     - seealso: subcript()
     - returns: The Element or nil if the array doesn't contain an element in 
        that index
     */
    public func get(_ index: Int) -> Element? {
        return indices ~= index ? self[index] : .none
    }
    
}
