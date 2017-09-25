//
//  UIView.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//
import UIKit

/**
 Properties a BorderView has.
 */
public struct BorderViewProperties {

    public let thickness: Float
    public let color: UIColor

    public init(thickness: Float, color: UIColor) {
        self.thickness = thickness
        self.color = color
    }
}

/**
 Positions where a BorderView may appear.
 */
public enum BorderPosition {
    case top
    case bottom
    case left
    case right

    fileprivate var direction: UIView.Direction {
        switch self {
        case .top: return .horizontal
        case .bottom: return .horizontal
        case .left: return .vertical
        case .right: return .vertical
        }
    }
}

/**
 Represents a UIView that is used to create a border to another view.

 You can obtain a BorderView by using `add(top/bottom/left/right:, offsets:, useConstraints:)`
 functions. But the only changes you are expected to do with it are:
 hide or show it,
 change its color, its alpha or other properties.
 -warning: You are not suppose to change or use constraints with this view, that was already handled for you.
 */
public class BorderView: UIView {

    public let position: BorderPosition

    internal convenience init(position: BorderPosition) {
        self.init(frame: .zero, position: position)
    }

    internal init(frame: CGRect, position: BorderPosition) {
        self.position = position
        super.init(frame: frame)
    }

    public override init(frame _: CGRect) {
        fatalError("You shouldn't create a BorderView this way.")
    }

    public required init(coder _: NSCoder) {
        fatalError("You shouldn't create a BorderView this way.")
    }
}

fileprivate extension UIView {

    fileprivate enum Direction {
        case horizontal
        case vertical
    }

    fileprivate func addBorderView(from border: BorderViewProperties, position: BorderPosition) -> BorderView {
        let borderView = BorderView(position: position)
        borderView.backgroundColor = border.color
        addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        let anchor = (position.direction == .horizontal) ? borderView.heightAnchor : borderView.widthAnchor
        anchor.constraint(equalToConstant: CGFloat(border.thickness)).isActive = true
        return borderView
    }
}

public extension UIView {

    /**
     Adds a border to the top of the view, inside the view's bounds.

     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
     By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
     By default, 0.
     - parameter useConstraints: Boolean indicating whether to use constraints or frames. By default, true.

     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(top border: BorderViewProperties,
                    withLeftOffset left: CGFloat = 0, rightOffset right: CGFloat = 0,
                    useConstraints: Bool = true) -> BorderView {
        let borderView: BorderView
        if useConstraints {
            borderView = addBorderView(from: border, position: .top)
            borderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
            rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: right).isActive = true
        } else {
            let frame = CGRect(x: left,
                               y: 0,
                               width: bounds.width - left - right,
                               height: CGFloat(border.thickness))
            borderView = BorderView(frame: frame, position: .top)
            borderView.backgroundColor = border.color
            addSubview(borderView)
        }
        return borderView
    }

    /**
     Adds a border to the bottom of the view, inside the view's bounds.

     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
     By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
     By default, 0.
     - parameter useConstraints: Boolean indicating whether to use constraints or frames. By default, true.

     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(bottom border: BorderViewProperties,
                    withLeftOffset left: CGFloat = 0, rightOffset right: CGFloat = 0,
                    useConstraints: Bool = true) -> BorderView {
        let borderView: BorderView
        if useConstraints {
            borderView = addBorderView(from: border, position: .bottom)
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
            rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: right).isActive = true
        } else {
            let frame = CGRect(x: left,
                               y: bounds.height - CGFloat(border.thickness),
                               width: bounds.width - left - right,
                               height: CGFloat(border.thickness))
            borderView = BorderView(frame: frame, position: .bottom)
            borderView.backgroundColor = border.color
            addSubview(borderView)
        }
        return borderView
    }

    /**
     Adds a border to the left of the view, inside the view's bounds.

     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
     By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
     By default, 0.
     - parameter useConstraints: Boolean indicating whether to use constraints or frames. By default, true.

     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(left border: BorderViewProperties,
                    withTopOffset top: CGFloat = 0, bottomOffset bottom: CGFloat = 0,
                    useConstraints: Bool = true) -> BorderView {
        let borderView: BorderView
        if useConstraints {
            borderView = addBorderView(from: border, position: .left)
            borderView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
            bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: bottom).isActive = true
        } else {
            let frame = CGRect(x: 0,
                               y: top,
                               width: CGFloat(border.thickness),
                               height: bounds.height - top - bottom)
            borderView = BorderView(frame: frame, position: .left)
            borderView.backgroundColor = border.color
            addSubview(borderView)
        }
        return borderView
    }

    /**
     Adds a border to the right of the view, inside the view's bounds.

     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
     By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
     By default, 0.
     - parameter useConstraints: Boolean indicating whether to use constraints or frames. By default, true.

     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(right border: BorderViewProperties,
                    withTopOffset top: CGFloat = 0, bottomOffset bottom: CGFloat = 0,
                    useConstraints: Bool = true) -> BorderView {
        let borderView: BorderView
        if useConstraints {
            borderView = addBorderView(from: border, position: .right)
            borderView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
            bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: bottom).isActive = true
        } else {
            let frame = CGRect(x: bounds.width - CGFloat(border.thickness),
                               y: top,
                               width: CGFloat(border.thickness),
                               height: bounds.height - top - bottom)
            borderView = BorderView(frame: frame, position: .right)
            borderView.backgroundColor = border.color
            addSubview(borderView)
        }
        return borderView
    }

    /**
     Removes the border view from self, only if
     the border was a child view to self.
     */
    public func remove(border: BorderView) {
        if border.superview == self {
            border.removeFromSuperview()
        }
    }
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
     - parameter useConstraints: Boolean indicating whether to use constraints or frames. By default, true.

     - note: If you decide to use constraints to determine the size, the container's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     Also, this function matches left inset to leading and right to trailing of the view.
     */
    public func add(into containerView: UIView,
                    with insets: UIEdgeInsets = .zero,
                    in viewPositioning: ViewPositioning = .front,
                    useConstraints: Bool = true) {
        if useConstraints {
            containerView.addSubview(self)

            containerView.translatesAutoresizingMaskIntoConstraints = false
            translatesAutoresizingMaskIntoConstraints = false

            topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top).isActive = true
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: insets.left).isActive = true
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).isActive = true
        } else {
            let bounds = containerView.bounds
            let x = insets.left
            let y = insets.top
            let width = bounds.width - x - insets.right
            let height = bounds.height - y - insets.bottom
            frame = CGRect(x: x, y: y, width: width, height: height)

            containerView.addSubview(self)
        }

        if case viewPositioning = ViewPositioning.back {
            containerView.sendSubview(toBack: self)
        }
    }
}
