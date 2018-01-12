//
//  DeviceType.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/* 
 DeviceType provides the current device type,
 in relation to its window height in points.
 */
public enum DeviceType: CGFloat {
    case iPhone4s_previous = 480.0
    case iPhone5_5s_5c_SE = 568.0
    case iPhone6_6s_7_8 = 667.0
    case iPhone6Plus_6sPlus_7Plus_8Plus = 736.0
    case iPhoneX = 812.0
    case unknown = -1
    
    /**
     Initializer that returns the current DeviceType.
    */
    public init() {
        let height = UIScreen.main.bounds.size.height
        self = DeviceType(rawValue: height) ?? .unknown
    }
}
