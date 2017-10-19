//
//  Gradient.swift
//  Core
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
    
    fileprivate var startPoint: CGPoint {
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
    
    fileprivate var endPoint: CGPoint {
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
    Represents a gradient that can be applied to a view.
    It can have many colors distributed in many ways and directions.
    There can only be one gradient at a time in a view.
 */
public struct ViewGradient {
    
    // Direction of the gradient.
    public let direction: GradientDirection
    // Colors involved in the order involved.
    public let colors: [UIColor]
    // Locations where the colors are placed.
    public var locations: [Float] {
        return layer.locations!.map { $0.floatValue }
    }
    
    fileprivate let layer: CAGradientLayer
    
    /**
     Initializes an inmutable ViewGradient.
     
     - parameter colors: Array of UIColors in the order in which to place them.
        There should be more than one.
     - parameter direction: Direction in which the gradient should develop.
     - parameter locations: Locations of the center of each color through out the screen.
        A location is any possible number between 0 and 1, being 0 the start of the gradient
        and 1 the end of the gradient in the direction specified.
        By default, it spreads the colors uniformly.
        If passed a value, it should have as many locations as it does colors.
    */
    public init(colors: [UIColor], direction: GradientDirection, locations: [Float]? = .none) {
        precondition(colors.count > 1)
        if let locations = locations {
            precondition(locations.first(where: { $0 < 0 || $0 > 1 }) == .none)
            precondition(locations.count == colors.count)
        }
        
        self.colors = colors
        self.direction = direction
        
        layer = CAGradientLayer()
        layer.anchorPoint = .zero
        layer.colors = colors.map { $0.cgColor }
        
        layer.locations = calculateLocations(from: locations, numberOfColors: colors.count)
        
        layer.startPoint = direction.startPoint
        layer.endPoint = direction.endPoint
    }
    
    private func calculateLocations(from locations: [Float]?, numberOfColors: Int) -> [NSNumber] {
        var locs: [NSNumber] = []
        if let locations = locations {
            locs = locations.map { NSNumber(value: $0) }
        } else {
            let colorProportion = 1.0 / Double(numberOfColors - 1)
            for i in 0...numberOfColors {
                let location = Double(i) * colorProportion
                locs.append(NSNumber(value: location))
            }
        }
        return locs
    }
    
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
    */
    public var gradient: ViewGradient? {
        set {
            if gradient != nil {
                removeGradient()
            }
            if let grad = newValue {
                apply(gradient: grad)
            }
        }
        get {
            return getGradient()
        }
    }
    
    private func apply(gradient: ViewGradient) {
        let gradientLayer = gradient.layer
        gradientLayer.bounds = bounds
        reactive.producer(forKeyPath: "bounds")
            .take(duringLifetimeOf: self)
            .take(duringLifetimeOf: gradientLayer)
            .map { $0 as! CGRect }      //swiftlint:disable:this force_cast
            .on(value: { [unowned gradientLayer] in gradientLayer.bounds = $0})
            .start()
        layer.insertSublayer(gradientLayer, at: 0)
        setAssociatedObject(self, key: &ViewGradientKey, value: gradient as ViewGradient?)
    }
    
    private func removeGradient() {
        if let gradient = getGradient() {
            gradient.layer.removeFromSuperlayer()
            setAssociatedObject(self, key: &ViewGradientKey, value: ViewGradient?.none)
        }
    }
    
    private func getGradient() -> ViewGradient? {
        return getAssociatedObject(self, key: &ViewGradientKey)
    }
    
}

private var ViewGradientKey: UInt8 = 1
