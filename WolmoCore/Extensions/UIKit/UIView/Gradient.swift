//
//  Gradient.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 10/12/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

/**
 Represents the posible directions of a gradient in a view.
 */
public enum GradientDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    case topLeftToBottomRight
    case bottomRightToTopLeft
    case topRightToBottomLeft
    case bottomLeftToTopRight
}

fileprivate extension GradientDirection {
    var startPoint: CGPoint {
        switch self {
        case .leftToRight: return CGPoint(x: 0, y: 0.5)
        case .rightToLeft: return CGPoint(x: 1, y: 0.5)
        case .topToBottom: return CGPoint(x: 0.5, y: 0)
        case .bottomToTop: return CGPoint(x: 0.5, y: 1)
        case .topLeftToBottomRight: return CGPoint(x: 0, y: 0)
        case .bottomRightToTopLeft: return CGPoint(x: 1, y: 1)
        case .topRightToBottomLeft: return CGPoint(x: 1, y: 0)
        case .bottomLeftToTopRight: return CGPoint(x: 0, y: 1)
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .leftToRight: return CGPoint(x: 1, y: 0.5)
        case .rightToLeft: return CGPoint(x: 0, y: 0.5)
        case .topToBottom: return CGPoint(x: 0.5, y: 1)
        case .bottomToTop: return CGPoint(x: 0.5, y: 0)
        case .topLeftToBottomRight: return CGPoint(x: 1, y: 1)
        case .bottomRightToTopLeft: return CGPoint(x: 0, y: 0)
        case .topRightToBottomLeft: return CGPoint(x: 0, y: 1)
        case .bottomLeftToTopRight: return CGPoint(x: 1, y: 0)
        }
    }
}

/**
     Represents a color that takes place ina gradient that can be applied to a view.
     It has a UIColor and a location which indicates where that color should be placed in the gradient.
 */
public struct GradientColor {
    // Color to use in gradient.
    public let color: UIColor
    // Location where to place color inside the gradient.
    // Number between 0 and 1 (inclusive).
    public let location: Float

    /**
     Initializes an inmutable GradientColor.

     - parameter color: UIColor to use.
     - parameter location: Locations of the center of the color through out the gradient.
     A location is any possible number between 0 and 1, being 0 the start of the gradient
     and 1 the end of the gradient in the direction specified.
     - warning: If the location isn't between 0 and 1 (inclusive) the init will fail.
     */
    public init?(color: UIColor, location: Float) {
        if location < 0 || location > 1 {
            return nil
        }
        self.color = color
        self.location = location
    }
}

/**
    Represents a gradient that can be applied to a view.
    It can have many colors distributed in many ways and directions.

    - note: There can only be one gradient at a time in a view.
 */
public struct ViewGradient {
    // Direction of the gradient.
    public let direction: GradientDirection
    // GradientColors involved in the order involved.
    public let colors: [GradientColor]
    
    fileprivate let layer: CAGradientLayer

    /**
     Initializes an inmutable ViewGradient.

     - parameter colors: Array of GradientColors to be used.
     - parameter direction: Direction in which the gradient should develop.
     */
    public init(colors: [GradientColor], direction: GradientDirection) {
        self.colors = colors.sorted { g1, g2 in g1.location < g2.location }
        self.direction = direction

        layer = CAGradientLayer()
        layer.anchorPoint = .zero

        layer.colors = self.colors.map { $0.color.cgColor }
        layer.locations = self.colors.map { NSNumber(value: $0.location) }

        layer.startPoint = direction.startPoint
        layer.endPoint = direction.endPoint
    }

    /**
     Initializes an inmutable ViewGradient.
     
     - parameter colors: Array of UIColors in the order in which to place them.
        They will be evenly separated.
     - parameter direction: Direction in which the gradient should develop.
    */
    public init(colors: [UIColor], direction: GradientDirection) {
        let locations = calculateLocations(for: colors.count)
        let gradientColors = colors.enumerated().map { (index, color) in
            GradientColor(color: color, location: locations[index].floatValue)!
        }
        
        self.init(colors: gradientColors, direction: direction)
    }
}

private func calculateLocations(for numberOfColors: Int) -> [NSNumber] {
    var locs: [NSNumber] = []
    let colorProportion = 1.0 / Double(numberOfColors - 1)
    for i in 0...numberOfColors {
        let location = Double(i) * colorProportion
        locs.append(NSNumber(value: location))
    }
    return locs
}

public extension UIView {
    /**
        ViewGradient applied currently to the view.
        A view can only have one gradient at a time.
        When setting this property to a new gradient, the old one will be removed,
            and when set to .none the current one will be removed.
        The gradient will always have the same direction in relation to the view's
            orientation at a certain time.
        The gradient will always acommodate to the view's change in size or orientation.

        - warning: To avoid memory leak and crashes, you should set the `gradient` to .none before deallocating the view.
    */
    var gradient: ViewGradient? {
        get {
            return getGradient()
        }
        set {
            if gradient != nil {
                removeGradient()
            }
            if let grad = newValue {
                apply(gradient: grad)
            }
        }
    }
    
    private func apply(gradient: ViewGradient) {
        let gradientLayer = gradient.layer
        gradientLayer.bounds = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        setAssociatedObject(self, key: &ViewGradientKey, value: gradient as ViewGradient?)
        let observer = observe(\.bounds) { object, _ in
            gradientLayer.bounds = object.bounds
        }
        setAssociatedObject(self, key: &ViewGradientObserverKey, value: observer as NSKeyValueObservation?)
    }
    
    private func removeGradient() {
        if let gradient = getGradient() {
            gradient.layer.removeFromSuperlayer()
            setAssociatedObject(self, key: &ViewGradientKey, value: ViewGradient?.none)
            setAssociatedObject(self, key: &ViewGradientObserverKey, value: NSKeyValueObservation?.none)
        }
    }
    
    private func getGradient() -> ViewGradient? {
        return getAssociatedObject(self, key: &ViewGradientKey)
    }
}

private var ViewGradientKey: UInt8 = 1
private var ViewGradientObserverKey: UInt8 = 2
