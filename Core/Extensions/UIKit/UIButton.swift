//
//  UIButton.swift
//  Core
//
//  Created by Daniela Riesgo on 7/25/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /*
     Sets the button's title underlined with style and for state specified.
     
     - parameter title: Title for the button.
     - parameter style: NSUnderlineStyle with which the title is underlined.
        By default, StyleSingle.
     - parameter color: UIColor for the underline, or None if the color
        should be the same as the foreground's. By default, None.
     - parameter forState: UIControlState for which to set the title.
        By default, Normal.
     
     */
    public func setUnderlined(title: String, style: NSUnderlineStyle = .styleSingle, color: UIColor? = .none, forState state: UIControlState = .normal) {
        var attributes: [String : AnyObject] = [NSUnderlineStyleAttributeName: style.rawValue as AnyObject]
        if let colorAttr = color {
            attributes[NSUnderlineColorAttributeName] = colorAttr
        }
        let underlinedText = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(underlinedText, for: state)
    }

    /* 
     Sets the button's title and image with the specified spacing and arrangement.
    
     - parameter title: Title for the button.
     - parameter image: Image for the button.
     - parameter spacing: Spacing between the title and the button.
     - parameter imageOnRight: Boolean indicating whether the the image should be to the
            right of the text or to the left. By default, false (to the left).
     
     - seealso: CGAffineTransform(scaleX:y:)
    **/
    public func setTitle(title: String, image: UIImage, spacing: CGFloat = 0, imageOnRight: Bool = false) {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)

        imageView!.contentMode = .scaleAspectFill
        imageView!.clipsToBounds = false
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill

        // UIButton Insets: http://stackoverflow.com/a/25559946
        let inset = spacing / 2
        titleEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: -inset)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -inset, bottom: 0, right: inset)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        if imageOnRight {
            // Image to the right: http://stackoverflow.com/a/32174204
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            titleLabel!.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            imageView!.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }

        sizeToFit()
    }
    
}
