//
//  Constraints.swift
//  WolmoCore
//
//  Created by Gaston Maspero on 1/21/20.
//  Copyright © 2020 Wolox. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Constrains the view to the specified anchors and size, with optional padding.
     
     - Parameter top: Top anchor to which the view's top anchor will be constrained.
     - Parameter leading: leading anchor to which the view's leading anchor will be constrained.
     - Parameter bottom: bottom anchor to which the view's bottom anchor will be constrained.
     - Parameter trailing: trailing anchor to which the view's trailing anchor will be constrained.
     - Parameter padding: these are the constants to be added to the anchors, grouped in a UIEdgeInsets object.
     - Parameter size: size to which the view will be constrained.
     
     
     - Returns: Returns an AnchoredConstraints object, that contains the view's top, bottom, leading, trailing, width and height constraints. This result is discardable.
     */
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = .none,
                leading: NSLayoutXAxisAnchor? = .none,
                bottom: NSLayoutYAxisAnchor? = .none,
                trailing: NSLayoutXAxisAnchor? = .none,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    /**
     Constrains the view to the borders of its superview, with optional padding.
     
     - Parameter padding: When using this parameter, the view will fill out its superview, using this paramater as padding.
     */
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    /**
     Centers the view to its superview, and constrains its height and width to the specified size.
     
     - Parameter size: Size to which the view will be constrained.
     */
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    /**
     Centers the view's x axis to its superview.
     */
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    /**
     Centers the view's y axis to its superview.
     */
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    /**
     Constrains the view's width to the specified parameter.
     
     - Parameter constant: Constant to which the view's width will be constrained.
     */
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    /**
     Constrains the view's height to the specified parameter.
     
     - Parameter constant: Constant to which the view's height will be constrained.
     */
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
