//
//  Accessibility.swift
//  WolmoCore
//
//  Created by Gaston Maspero on 1/21/20.
//  Copyright © 2020 Wolox. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Applies accessibility features to the view.
     
     - Parameter trait: Accessibility trait for the view.
     - Parameter label: Accessibility label for the view. This parameter is an optional with default value set to nil.
     - Parameter hint: Accessibility hint for the view. This parameter is an optional with default value set to nil.
     */
    func applyAccessibility(trait: UIAccessibilityTraits, label: String? = nil, hint: String? = nil) {
        isAccessibilityElement = true
        accessibilityTraits = trait
        accessibilityLabel = label
        accessibilityHint = hint
    }
}
