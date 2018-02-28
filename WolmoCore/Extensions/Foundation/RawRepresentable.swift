//
//  RawRepresentable.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension RawRepresentable where RawValue == Int {
    
    /**
     Returns a sequence that contains all the possible rawValues of self.
     
     - parameter startingAt: The value from which to start.
     */
    public static func allValues(startingAt value: Self) -> AnySequence<Self> {
        let generator = RawRepresentableGenerator(startingAt: value) { Self(rawValue: ($0.rawValue + 1)) }
        return AnySequence { generator }
    }
    
    /**
     Returns the count of all the possible values of self, starting in value.
     
     - parameter startingAt: The value from which to start.
     
     - Complexity: O(N) where N = #values - startingAt.
     */
    public static func count(startingAt value: Self) -> Int {
        var count = 0
        for _ in allValues(startingAt: value) {
            count += 1
        }
        return count
    }
    
}

/**
 Creates a generator for the specified RawValue type.
 */
public struct RawRepresentableGenerator<RawValue, Representable: RawRepresentable>: IteratorProtocol where Representable.RawValue == RawValue {
    
    private let _valueSuccessor: (Representable) -> Representable?
    private var _nextValue: Representable?
    
    /**
     Provides a baseRawValue and a function to get a new RawValue.
     */
    public init(startingAt baseValue: Representable, valueSuccessor: @escaping (Representable) -> Representable?) {
        _nextValue = baseValue
        _valueSuccessor = valueSuccessor
    }
    
    /**
     Returns the new representable value.
     
     - note: The first value, is always the element associated with the baseRawValue
     provided at init.
     */
    public mutating func next() -> Representable? {
        if let nextValue = _nextValue {
            let value = nextValue
            _nextValue = _valueSuccessor(nextValue)
            return value
        } else {
            return .none
        }
    }
    
}
