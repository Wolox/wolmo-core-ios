//
//  UIImageView.swift
//  WolmoCore
//
//  Created by Diego Quiros on 02/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

public extension UIImageView {
    /**
     Sets de image of the view to a drawing of the given string,
     it's recomended for using emojis as images, but it can be used with any string.
     - parameter string: String, the text to draw in the image.
     - parameter fontSize: CGFloat, size of the font to use on the represented string, if fontSize is not specified it will be set to 50.
     */
    func draw(string: String, fontSize: CGFloat = 50) {
        contentMode = .scaleAspectFit
        image = string.toImage(fontSize: fontSize)
    }
    
    /**
     Sets the image of the view to a drawing of the given string,
     it's recomended for using emojis as images, but it can be used with any string.
     - parameter string: String, the text to draw in the image.
     - parameter font: UIFont to apply to the drawn string.
     */
    func draw(string: String, font: UIFont) {
        contentMode = .scaleAspectFit
        image = string.toImage(font: font)
    }
    
    /**
     Rotates the image of the view a by a certain amount in degrees.
     */
    func rotate(degrees: CGFloat) {
        let radians = degrees * CGFloat.pi / 180
        transform = CGAffineTransform(rotationAngle: radians)
    }
}
