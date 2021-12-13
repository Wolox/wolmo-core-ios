//
//  UIView.swift
//  WolmoCore
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
    public let roundedCorners: Bool
    
    public init(thickness: Float, color: UIColor, rounded: Bool = false) {
        self.thickness = thickness
        self.color = color
        self.roundedCorners = rounded
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

    override public init(frame: CGRect) {
        fatalError("You shouldn't create a BorderView this way.")
    }

    required public init(coder: NSCoder) {
        fatalError("You shouldn't create a BorderView this way.")
    }
    
     func clipToBoundsBordersIfNeeded(border: BorderViewProperties) {
        if border.roundedCorners {
            self.layer.cornerRadius = CGFloat(border.thickness / 2)
            self.clipsToBounds = true
        }
    }
}

fileprivate extension UIView {
    enum Direction {
        case horizontal
        case vertical
    }
    
    func addBorderView(from border: BorderViewProperties, position: BorderPosition) -> BorderView {
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
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    @discardableResult
    func add(top border: BorderViewProperties,
             withLeftOffset left: CGFloat = 0,
             rightOffset right: CGFloat = 0,
             layout: LayoutMode = .constraints) -> BorderView {
        var borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .top)
            borderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
            rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: right).isActive = true
        case .frame:
            borderView = createBorderView(border: border,
                                          firstOffset: left,
                                          secondOffset: right,
                                          position: .top)
        }
        
        borderView.clipToBoundsBordersIfNeeded(border: border)
        
        return borderView
    }
    
    /**
     Adds a border to the bottom of the view, inside the view's bounds.
     
     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
            By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
            By default, 0.
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    @discardableResult
    func add(bottom border: BorderViewProperties,
             withLeftOffset left: CGFloat = 0, rightOffset right: CGFloat = 0,
             layout: LayoutMode = .constraints) -> BorderView {
        var borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .bottom)
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
            rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: right).isActive = true
        case .frame:
            borderView = createBorderView(border: border,
                                          firstOffset: left,
                                          secondOffset: right,
                                          position: .bottom)
        }
        
        borderView.clipToBoundsBordersIfNeeded(border: border)
        
        return borderView
    }
    
    /**
     Adds a border to the left of the view, inside the view's bounds.
     
     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
            By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
            By default, 0.
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    @discardableResult
    func add(left border: BorderViewProperties,
             withTopOffset top: CGFloat = 0,
             bottomOffset bottom: CGFloat = 0,
             layout: LayoutMode = .constraints) -> BorderView {
        var borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .left)
            borderView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
            bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: bottom).isActive = true
        case .frame:
            borderView = createBorderView(border: border,
                                          firstOffset: top,
                                          secondOffset: bottom,
                                          position: .left)
        }
        
        borderView.clipToBoundsBordersIfNeeded(border: border)
        
        return borderView
    }
    
    /**
     Adds a border to the right of the view, inside the view's bounds.
     
     - parameter border: Models characteristics of the border to be added.
     - parameter leftOffset: Offset from the view's left border to where the border should start.
            By default, 0.
     - parameter rightOffset: Offset from the view's right border to where the border should start.
            By default, 0.
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    @discardableResult
    func add(right border: BorderViewProperties,
             withTopOffset top: CGFloat = 0,
             bottomOffset bottom: CGFloat = 0,
             layout: LayoutMode = .constraints) -> BorderView {
        var borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .right)
            borderView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
            bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: bottom).isActive = true
        case .frame:
            borderView = createBorderView(border: border,
                                          firstOffset: top,
                                          secondOffset: bottom,
                                          position: .right)
        }
        
        borderView.clipToBoundsBordersIfNeeded(border: border)
        
        return borderView
    }
    
    private func createBorderView(border: BorderViewProperties,
                                  firstOffset: CGFloat,
                                  secondOffset: CGFloat,
                                  position: BorderPosition) -> BorderView {
        var frame: CGRect
        let thickness = CGFloat(border.thickness)
        
        switch position {
        case .top, .bottom:
            frame = CGRect(x: firstOffset,
                           y: position == .top ? 0 : bounds.height - thickness,
                           width: bounds.width - firstOffset - secondOffset,
                           height: thickness)
        case .left, .right:
            frame = CGRect(x: position == .left ? 0 : bounds.width - thickness,
                           y: firstOffset,
                           width: thickness,
                           height: bounds.height - firstOffset - secondOffset)
        }
        
        let borderView = BorderView(frame: frame, position: position)
        borderView.backgroundColor = border.color
        addSubview(borderView)
        
        return borderView
    }

    /**
        Removes the border view from self, only if
        the border was a child view to self.
    */
    func remove(border: BorderView) {
        if border.superview == self {
            border.removeFromSuperview()
        }
    }
    
    /**
     Adds borders to the selected sides of the view, inside the view's bounds.
     
     - parameter properties: characteristics of the borders to be added.
     
     - parameter positions: the sides of the view where borders will be added.
     
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     */
    
    func addBorders(properties: BorderViewProperties, positions: [BorderPosition], layout: LayoutMode = .constraints) {
        positions.forEach { position in
            switch position {
            case .top:
                add(top: properties, layout: layout)
            case .bottom:
                add(bottom: properties, layout: layout)
            case .left:
                add(left: properties, layout: layout)
            case .right:
                add(right: properties, layout: layout)
            }
        }
    }
}

public extension UIView {
    func addShadow(color: CGColor = UIColor.black.cgColor, size: CGSize = CGSize(width: 0, height: 2),
                   radius: CGFloat = 2.5, opacity: Float = 0.2, cornerRadius: CGFloat = 5) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = size
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
