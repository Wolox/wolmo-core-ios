//
//  Comparable.swift
//  WolmoCore
//
//  Created by Diego Quiros on 11/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

public extension Comparable {
    /**
     Returns the closest value that is contained in the given interval, if the number is already in the interval it returns the same value.
     - parameter min: minimum value of the interval to use.
     - parameter max: maximum value of the interval to use.
     */
    func clamp(min: Self, max: Self) -> Self {
        if self < min { return min }
        if self > max { return max }
        return self
    }
}
