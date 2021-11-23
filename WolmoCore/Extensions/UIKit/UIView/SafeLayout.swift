//
//  SafeLayout.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 28/08/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

public extension UIView {
    /**
     This is an extension for layout compatibility between iOS 11 and lower versions.
     If the native safe layout guide is not available, then return a regular layout guide.
     */
    var safeLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        } else {
            let id = "\(accessibilityIdentifier ?? "").safe_layout"
            if let safeGuide = layoutGuides.filter({ $0.identifier == id }).first {
                return safeGuide
            } else {
                let safeGuide = UILayoutGuide()
                safeGuide.identifier = id
                addLayoutGuide(safeGuide)

                NSLayoutConstraint.activate([
                    safeGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
                    safeGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
                    safeGuide.topAnchor.constraint(equalTo: topAnchor),
                    safeGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])

                return safeGuide
            }
        }
    }

    var safeLayoutInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }
}
