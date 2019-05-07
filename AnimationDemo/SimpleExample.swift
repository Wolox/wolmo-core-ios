//
//  SimpleExample.swift
//  AnimationDemo
//
//  Created by Argentino Ducret on 23/01/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

enum SimpleExample: Int {
    case simple = 0
    case chain
    case chained
    case chainedDifferentTypes
    case transformRotateAndScale
    case transformTranslateAndScaleSimple
    case transformTranslateAndScaleMixed
    case transformRotateAndActionScale
    case transformScaleAndActionTranslate
    
    static var all: [SimpleExample] {
        return [
            .simple, .chain, .chained, .chainedDifferentTypes,
            .transformRotateAndScale,
            .transformTranslateAndScaleSimple, .transformTranslateAndScaleMixed,
            .transformRotateAndActionScale, .transformScaleAndActionTranslate
        ]
    }
    
    var name: String {
        switch self {
        case .simple:
            return "Improved - Action and Transform - Simple"
        case .chain:
            return "Normal"
        case .chained:
            return "Improved - Action and Transform - Chain of Mixed - Loop"
        case .chainedDifferentTypes:
            return "Improved - Action and Transform - Chain of Simple and Mixed - Not loop"
        case .transformRotateAndScale:
            return "FAULTY - Normal and Improved - Action and Transform - Mixed"
        case .transformTranslateAndScaleSimple:
            return "FAULTY - Improved - Transform - Simple"
        case .transformTranslateAndScaleMixed:
            return "FAULTY - Improved - Transform - Chain of Mixed - Loop"
        case .transformRotateAndActionScale:
            return "Improved - Transform - Mixed"
        case .transformScaleAndActionTranslate:
            return "Improved - Action and Transform - Chain of Mixed - Loop"
        }
    }
}
