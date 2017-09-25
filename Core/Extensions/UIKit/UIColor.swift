//
//  UIColor.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UIColor {

    /**
     Initialzer based on hex string.

     - parameter hexString: It can either be uppercase or lowercase, and contain or not a leading #.
     */
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        let start: String.Index
        if hex.hasPrefix("#") {
            start = hex.characters.index(hex.startIndex, offsetBy: 1)
        } else {
            start = hex.startIndex
        }

        var hexColor = hex.substring(from: start)

        if hexColor.characters.count == 6 {
            hexColor.append("ff")
        }

        if hexColor.characters.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                a = CGFloat(hexNumber & 0x0000_00FF) / 255

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
}
