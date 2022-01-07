//
//  NSAttributedString.swift
//  WolmoCore
//
//  Created by juan.martin.gordo on 27/12/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    /**
     Appends a `String` formatted as a superscript to a `NSAttributedString`and returns a new `NSAttributedString`.
     
     - parameter superscript: the `String` to be formatted as a superscript.
     - parameter percentageSize: the size percentage of the resulting superscript in relation to the font's [pointSize](https://developer.apple.com/documentation/uikit/uifont/1619031-pointsize).
     
     - seealso: [NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring)
     */
    func append(superscript: String, percentageSize: Float = 0.4) -> NSAttributedString {
        guard percentageSize > 0 && percentageSize < 1 else {
            fatalError("Size of superscript must be a percentage (0,1)")
        }
        guard self.length != .zero else {
            fatalError("Attributed string to append superscript to must not be empty")
        }
        let font: UIFont = self.attribute(
            NSAttributedString.Key.font,
            at: self.length-1,
            effectiveRange: nil) as! UIFont //swiftlint:disable:this force_cast
        let superscriptPointSize = font.pointSize * CGFloat(percentageSize)
        let superscriptFont = UIFont(descriptor: font.fontDescriptor, size: superscriptPointSize)
        let newString = NSMutableAttributedString(attributedString: self)
        let baseLine = font.pointSize - superscriptPointSize
        
        let superscriptAttributed = NSAttributedString(
            string: superscript,
            attributes: [NSAttributedString.Key.font: superscriptFont, NSAttributedString.Key.baselineOffset: baseLine]
        )
        newString.append(superscriptAttributed)
        return newString
    }
    
    /**
     Appends a `String` formatted as a subscript to a `NSAttributedString`and returns a new `NSAttributedString`.
     
     - parameter subscript: the `String` to be formatted as a subscript.
     - parameter percentageSize: the size percentage of the resulting subscript in relation to the font's [pointSize](https://developer.apple.com/documentation/uikit/uifont/1619031-pointsize).
     
     - seealso: [NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring)
     */
    func append(subscript subscriptString: String, percentageSize: Float = 0.4) -> NSAttributedString {
        guard percentageSize > 0 && percentageSize < 1 else {
            fatalError("Size of subscript must be a percentage (0,1)")
        }
        guard self.length != .zero else {
            fatalError("Attributed string to append subscript to must not be empty")
        }
        let font: UIFont = self.attribute(
            NSAttributedString.Key.font,
            at: self.length-1,
            effectiveRange: nil) as! UIFont //swiftlint:disable:this force_cast
        let subscriptPointSize = font.pointSize * CGFloat(percentageSize)
        let subscriptFont = UIFont(descriptor: font.fontDescriptor, size: subscriptPointSize)
        let newString = NSMutableAttributedString(attributedString: self)
        let baseLine = 0
        
        let subscriptAttributed = NSAttributedString(
            string: subscriptString,
            attributes: [NSAttributedString.Key.font: subscriptFont, NSAttributedString.Key.baselineOffset: baseLine]
        )
        newString.append(subscriptAttributed)
        return newString
    }
}
