//
//  Operators.swift
//  WolmoCore
//
//  Created by juan.martin.gordo on 04/02/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

infix operator ^^

/**
     XOR operator for booleans.
     
     - parameter lhs: left-hand side boolean.
     - parameter rhs: right-hand side boolean.
     
     - returns: Boolean value determining whether the arguments differ.
 */
func ^^ (lhs: Bool, rhs: Bool) -> Bool { return lhs != rhs }
