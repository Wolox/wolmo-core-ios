//
//  DeviceType.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/*
 DeviceType provides the current device type.
 */
public enum DeviceType: CGFloat {
    case iPhone4s = 480.0
    case iPhone5 = 568.0
    case iPhone6 = 667.0
    case iPhone6Plus = 736.0
    case unknown = -1

    /**
     Initializer that returns the current DeviceType.
     */
    public init() {
        let height = UIScreen.main.bounds.size.height
        self = DeviceType(rawValue: height) ?? .unknown
    }
}
