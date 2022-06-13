//
//  Animation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

/// See [CGAffineTransform](https://developer.apple.com/documentation/coregraphics/cgaffinetransform).
public typealias Transform = CGAffineTransform
/// A Void method.
public typealias Action = () -> Void

/**
 Defines and Animation object.
 */
public protocol AnimationType {
    /**
     Starts the animation.
     
     - parameter completion: completion handler for when the animation has finished.
     */
    func startAnimation(completion: ((Bool) -> Void)?)
}

/**
 Possible contents of an Animation.
 */
public enum AnimationContent {
    /// A Void method.
    case action(Action, duration: TimeInterval)
    /// See [CGAffineTransform](https://developer.apple.com/documentation/coregraphics/cgaffinetransform).
    case transform(Transform, duration: TimeInterval)
}

/**
 Defines and Animation.
 */
protocol Animation {
    /**
     Starts the animation.
     
     - parameter completion: completion handler for when the animation has finished.
     */
    func startAnimation(completion: ((Bool) -> Void)?)

}
