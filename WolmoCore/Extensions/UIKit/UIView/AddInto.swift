//
//  AddInto.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 28/08/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

/**
 Indicates the way in which the layout is set.
 */

public enum LayoutMode {
    case constraints
    case frame
}

/**
 Represents the possible positions where you can add a view into another.
 */
public enum ViewPositioning {
    case back
    case front
}

public extension UIView {

    /**
     Loads the view into the specified containerView.

     - parameter containerView: The container view.
     - parameter insets: Insets that separate self from the container view. By default, .zero.
     - parameter viewPositioning: Back or Front. By default, .front.
     - parameter layout: Enum indicating the layout mode. By default, .constraints.

     - note: If you decide to use constraints to determine the size, the container's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     Also, this function matches left inset to leading and right to trailing of the view.
     */
    public func add(into containerView: UIView,
                    with insets: UIEdgeInsets = .zero,
                    in viewPositioning: ViewPositioning = .front,
                    layout: LayoutMode = .constraints,
                    respectSafeArea: Bool = false) {

        switch layout {
        case .constraints:
            containerView.addSubview(self)
            translatesAutoresizingMaskIntoConstraints = false
            addConstraints(containerView: containerView, insets: insets, respectSafeArea: respectSafeArea)
        case .frame:
            frame = getFrame(containerView: containerView, insets: insets, respectSafeArea: respectSafeArea)

            containerView.addSubview(self)
        }

        if case viewPositioning = ViewPositioning.back {
            containerView.sendSubview(toBack: self)
        }
    }

    private func addConstraints(containerView: UIView, insets: UIEdgeInsets, respectSafeArea: Bool) {
        if respectSafeArea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: containerView.safeLayoutGuide.topAnchor, constant: insets.top),
                containerView.safeLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
                leadingAnchor.constraint(equalTo: containerView.safeLayoutGuide.leadingAnchor, constant: insets.left),
                containerView.safeLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
                leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: insets.left),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
            ])
        }
    }

    private func getFrame(containerView: UIView, insets: UIEdgeInsets, respectSafeArea: Bool) -> CGRect {
        if respectSafeArea {
            let bounds = containerView.bounds
            let x = containerView.safeLayoutInsets.left + insets.left
            let y = containerView.safeLayoutInsets.top + insets.top
            let width = bounds.width - x - insets.right - containerView.safeLayoutInsets.right
            let height = bounds.height - y - insets.bottom - containerView.safeLayoutInsets.bottom
            return CGRect(x: x, y: y, width: width, height: height)
        } else {
            let bounds = containerView.bounds
            let x = insets.left
            let y = insets.top
            let width = bounds.width - x - insets.right
            let height = bounds.height - y - insets.bottom
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }

}
