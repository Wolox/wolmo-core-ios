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

    override public init(frame: CGRect) {
        fatalError("You shouldn't create a BorderView this way.")
    }

    required public init(coder: NSCoder) {
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
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(top border: BorderViewProperties,
                    withLeftOffset left: CGFloat = 0, rightOffset right: CGFloat = 0,
                    layout: LayoutMode = .constraints) -> BorderView {
        let borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .top)
            borderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
            rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: right).isActive = true
        case .frame:
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
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(bottom border: BorderViewProperties,
                    withLeftOffset left: CGFloat = 0, rightOffset right: CGFloat = 0,
                    layout: LayoutMode = .constraints) -> BorderView {
        let borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .bottom)
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            borderView.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
            rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: right).isActive = true
        case .frame:
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
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(left border: BorderViewProperties,
                    withTopOffset top: CGFloat = 0, bottomOffset bottom: CGFloat = 0,
                    layout: LayoutMode = .constraints) -> BorderView {
        let borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .left)
            borderView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
            bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: bottom).isActive = true
        case .frame:
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
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, self's frame doesn't need to be final.
             Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
             We strongly recommend to work with constraints as a better practice than frames.
     */
    public func add(right border: BorderViewProperties,
                    withTopOffset top: CGFloat = 0, bottomOffset bottom: CGFloat = 0,
                    layout: LayoutMode = .constraints) -> BorderView {
        let borderView: BorderView
        
        switch layout {
        case .constraints:
            borderView = addBorderView(from: border, position: .right)
            borderView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
            bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: bottom).isActive = true
        case .frame:
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
