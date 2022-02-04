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
            return "1"
        case .chain:
            return "2"
        case .chained:
            return "3"
        case .chainedDifferentTypes:
            return "4"
        case .transformRotateAndScale:
            return "5"
        case .transformTranslateAndScaleSimple:
            return "6"
        case .transformTranslateAndScaleMixed:
            return "7"
        case .transformRotateAndActionScale:
            return "8"
        case .transformScaleAndActionTranslate:
            return "9"
        }
    }
}
