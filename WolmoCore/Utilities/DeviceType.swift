//
//  DeviceType.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
 DeviceType provides the current device type,
 in relation to its window height in points.
 */
public enum DeviceType: CGFloat {
    /// iPhone 4S or earlier models.
    case iPhone4s_previous = 480.0
    /// iPhone 5, 5S, 5C or SE.
    case iPhone5_5s_5c_SE = 568.0
    /// iPhone 6, 6S, 7 or 8.
    case iPhone6_6s_7_8 = 667.0
    /// iPhone 6 Plus, 6S Plus, 7 Plus or 8 Plus.
    case iPhone6Plus_6sPlus_7Plus_8Plus = 736.0
    /// iPhoneX, Xs, 12 Mini or 13 Mini.
    case iPhoneX = 812.0
    /// iPhone 12, 12 Pro, 13 or 13 Pro.
    case iPhone12_12Pro_13_13Pro = 844.0
    /// iPhone Xr, Xs Max, 11 or 11 Pro Max.
    case iPhoneXr_XsMax_11_11ProMax = 896.0
    /// iPhone 12 Pro Max or 13 Pro Max.
    case iPhone12ProMax_13ProMax = 926.0
    /// A device that is not any of the ones listed above.
    case unknown = -1
    
    /**
     Initializer that returns the current DeviceType.
    */
    public init() {
        let height = UIScreen.main.bounds.size.height
        self = DeviceType(rawValue: height) ?? .unknown
    }
}
