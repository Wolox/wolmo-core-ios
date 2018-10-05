//
//  UIImageView.swift
//  WolmoCore
//
//  Created by Diego Quiros on 02/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

extension UIImageView {
    
    /**
     Sets de image of the view to a drawing of the given string,
     it's recomended for using emojis as images, but it can be used with any string.
     - parameter string: String, the text to draw in the image.
     - parameter fontSize: CGFloat, size of the font to use on the represented string, if fontSize is not specified it will be set to the most convenient size.
     */
    func draw(string: String, fontSize: CGFloat? = nil) {
        contentMode = .scaleAspectFit
        var fontS: CGFloat
        if let unwrappedFontSize = fontSize {
            fontS = unwrappedFontSize
        } else {
            fontS = frame.size.width > frame.size.height ? frame.size.height * 0.85 : frame.size.width * 0.85
        }
        image = string.toImage(fontSize: fontS)
    }
    
    /**
     Sets de image of the view to a drawing of the given string,
     it's recomended for using emojis as images, but it can be used with any string.
     - parameter string: String, the text to draw in the image.
     - parameter font: UIFont to apply to the drawn string.
     */
    func draw(string: String, font: UIFont) {
        contentMode = .scaleAspectFit
        image = string.toImage(font: font)
    }
}
