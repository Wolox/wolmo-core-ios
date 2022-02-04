//
//  SimpleAnimation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

/**
 Concatenate different animations.
 */
public class SimpleAnimation: AnimationType {
    fileprivate let view: UIView
    fileprivate var animations: [AnimationContent] = []
    fileprivate var completion: ((Bool) -> Void)? = .none
    
    /**
     Default initializer for the SimpleAnimation class.
     
     - parameter view: the object's view.
     */
    init(view: UIView) {
        self.view = view
    }
    
    // MARK: - Transforms
    /**
     Adds an Identity transformation to the object's animations list and performs it in the specified amount of time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     */
    public func transformIdentity(withDuration duration: TimeInterval) -> SimpleAnimation {
        let transform = CGAffineTransform.identity
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    /**
     Moves the view by a specified amount in a given time, both horizontally and vertically.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter translationX: how much the view should move horizontally.
     - parameter translationY: how much the view should move vertically.
     */
    public func transform(withDuration duration: TimeInterval, translationX: CGFloat, translationY: CGFloat) -> SimpleAnimation {
        let transform = CGAffineTransform(translationX: translationX, y: translationY)
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    /**
     Rotates the view by a specified amount in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter rotationAngle: how much the view should rotate, in degrees.
     */
    public func transform(withDuration duration: TimeInterval, rotationAngle: CGFloat) -> SimpleAnimation {
        let angleInRadians = (rotationAngle * CGFloat.pi) / 180.0
        let transform = CGAffineTransform(rotationAngle: angleInRadians)
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    /**
     Changes the view's width and height values by the specified horizontal and vertical scale values in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter scaleX: the new horizontal scale value to be applied to the view.
     - parameter scaleY: the new vertical scale value to be applied to the view.
     */
    public func transform(withDuration duration: TimeInterval, scaleX: CGFloat, scaleY: CGFloat) -> SimpleAnimation {
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    // MARK: Actions
    /**
     Moves the position of the view by changing the center point of the view in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter positionX: the new horizontal position of the view, from the center.
     - parameter positionY: the new vertical position of the view, from the center.
     */
    public func action(withDuration duration: TimeInterval, positionX: CGFloat, positionY: CGFloat) -> SimpleAnimation {
        let action = {
            self.view.center = CGPoint(x: positionX, y: positionY)
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    /**
     Moves the position of the view a specified amount, from the center of the view, in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter translateX: how much the view should move horizontally, from the center.
     - parameter translateY: how much the view should move vertically, from the center.
     */
    public func action(withDuration duration: TimeInterval, translateX: CGFloat, translateY: CGFloat) -> SimpleAnimation {
        let action = {
            self.view.center = CGPoint(x: self.view.center.x + translateX, y: self.view.center.y + translateY)
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    /**
     Multiplies the object view's frame width and height values by the specified horizontal and vertical scale values in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter scaleX: the new horizontal scale value to be applied to the object's view.
     - parameter scaleY: the new vertical scale value to be applied to the object's view.
     */
    public func action(withDuration duration: TimeInterval, scaleX: CGFloat, scaleY: CGFloat) -> SimpleAnimation {
        let action = {
            let center = self.view.center
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width * scaleX,
                                     height: self.view.frame.height * scaleY)
            self.view.center = center
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    /**
     Applies an alpha value to the object's view in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter alpha: the alpha value to be applied to the object's view.
     */
    public func action(withDuration duration: TimeInterval, alpha: CGFloat) -> SimpleAnimation {
        let action = {
            self.view.alpha = alpha
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    /**
     Moves the view to the front or back of the superview in a given time.
     
     - parameter withDuration: the duration of the transformation, expressed in seconds.
     - parameter moveTo: the position the view should be moved to, in relation to it's superview. See `UIView.Position` for more details.
     */
    public func action(withDuration duration: TimeInterval, moveTo position: UIView.Position) -> SimpleAnimation {
        let action = {
            switch position {
            case .back:
                self.view.superview?.sendSubviewToBack(self.view)
            case .front:
                self.view.superview?.bringSubviewToFront(self.view)
            }
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    // MARK: - Start
    /**
     Starts the first animation on the object's animation list.
     
     - parameter completion: completion handler for when the animation has finished.
     */
    public func startAnimation(completion: ((Bool) -> Void)? = .none) {
        self.completion = completion
        if animations.count > 0 {
            let animation = animations.remove(at: 0)
            recursiveAnimation(animation: animation, animations: animations)
        }
    }
}

// MARK: - Private Methods
fileprivate extension SimpleAnimation {
    func recursiveAnimation(animation: AnimationContent, animations: [AnimationContent]) {
        var mutableAnimations = animations
        switch animation {
        case .transform(let transform, let duration):
            UIView.animate(withDuration: duration, animations: {
                self.view.transform = transform
            }, completion: { finished in
                if mutableAnimations.count > 0 {
                    let nextAnimation = mutableAnimations.remove(at: 0)
                    self.recursiveAnimation(animation: nextAnimation, animations: mutableAnimations)
                } else {
                    self.completion?(finished)
                }
            })

        case .action(let action, let duration):
            UIView.animate(withDuration: duration, animations: {
                action()
            }, completion: { finished in
                if mutableAnimations.count > 0 {
                    let nextAnimation = mutableAnimations.remove(at: 0)
                    self.recursiveAnimation(animation: nextAnimation, animations: mutableAnimations)
                } else {
                    self.completion?(finished)
                }
            })
        }
    }
    
}
