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
     - parameter fontSize: CGFloat, size of the font to use on the represented string, if fontSize is not specified it will be set to the size that better fills the Image.
     - parameter offx: CGFloat, used to adjust the X position of the string in the image, if offx is not specified the string will be centered on the X axis.
     - parameter offy: CGFloat, used to adjust the Y position of the string in the image, if offy is not specified the string will be centered on the Y axis.
     */
    func draw(string: String, fontSize: CGFloat? = nil, offx: CGFloat = 0, offy: CGFloat = 0) {
        image = string.toImage(size: bounds.size, fontSize: fontSize, offx: offx, offy: offy)
    }
}
