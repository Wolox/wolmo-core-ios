//
//  UIDevice.swift
//  WolmoCore
//
//  Created by juan.martin.gordo on 15/03/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIDevice {
    /**
     Makes the current device vibrate.
     
     ## Usage
     ```
     UIDevice.vibrate()
     ```
     */
    public static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}
