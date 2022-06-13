//
//  UIStackView.swift
//  WolmoCore
//
//  Created by Gaston Maspero on 1/21/20.
//  Copyright © 2020 Wolox. All rights reserved.
//

import UIKit

extension UIStackView {
    /**
     Initializes a stack view with a lsit of subviews, spacing, axis orientation, alignment and distribution. It has default values of 0 for spacing, "fill" for distribution and alignment, and horizontal orientation for the stack itself.
     
     - Parameter arrangedSubviews: Variadic argument for the initial subviews for the stackview.
     - Parameter spacing: Spacing for the stack view. Default is 0.
     - Parameter axis: Axis orientation for the stack view. Default is horizontal.
     - Parameter alignment: Alignment for the stack view. Default is "fill".
     - Parameter distribution: Distribution for the stack view. Default is "fill".
     */
    convenience init(arrangedSubviews: UIView...,
                     spacing: CGFloat = 0,
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(frame: .zero)
        arrangedSubviews.forEach { addArrangedSubview($0) }
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
