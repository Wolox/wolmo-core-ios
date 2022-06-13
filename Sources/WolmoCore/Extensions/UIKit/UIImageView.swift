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
     Initializes an UIImageView with a corner radius and an optional content mode (whose default value is "scaleAspectFIll")
     
     - parameter cornerRadius: Corner radius for the image view.
     - parameter contentMode: Content mode for the image view. Default value is "scaleAspectFill".
     */
    convenience init(cornerRadius: CGFloat, contentMode: UIImageView.ContentMode = .scaleAspectFill) {
        self.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = contentMode
    }
    
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
