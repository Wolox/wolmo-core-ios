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
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}
