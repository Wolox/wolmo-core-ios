//
//  MixedAnimation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

/**
 Concatenate different affine transformations in one single transformation.
 */
public class MixedAnimation: AnimationType {
    fileprivate let duration: TimeInterval
    fileprivate let view: UIView
    fileprivate var transformations: [CGAffineTransform] = []
    fileprivate var actions: [() -> Void] = []
    
    /**
     Initializer for the MixedAnimation object.
     
     - parameter duration: the length of the animation, expressed in Seconds.
     - parameter view: the view of the object.
     */
    init(view: UIView, duration: TimeInterval) {
        self.duration = duration
        self.view = view
    }
    
    // MARK: - Transforms
    /// Adds an Identity transformation to the object's transformations list.
    public func transformIdentity() -> MixedAnimation {
        transformations.append(CGAffineTransform.identity)
        return self
    }
    
    /**
     Moves the view by a specified amount, both horizontally and vertically.
     
     - parameter translationX: how much the view should move horizontally.
     - parameter translationY: how much the view should move vertically.
     */
    public func transform(translationX: CGFloat, translationY: CGFloat) -> MixedAnimation {
        transformations.append(CGAffineTransform(translationX: translationX, y: translationY))
        return self
    }
    
    /**
     Rotates the view by a specified amount.
     
     - parameter rotationAngle: how much the view should rotate, in degrees.
     */
    public func transform(rotationAngle: CGFloat) -> MixedAnimation {
        let angleInRadians = (rotationAngle * CGFloat.pi) / 180.0
        transformations.append(CGAffineTransform(rotationAngle: angleInRadians))
        return self
    }
    
    /**
     Changes the view's width and height values by the specified horizontal and vertical scale values.
     
     - parameter scaleX: the new horizontal scale value to be applied to the view.
     - parameter scaleY: the new vertical scale value to be applied to the view.
     */
    public func transform(scaleX: CGFloat, scaleY: CGFloat) -> MixedAnimation {
        transformations.append(CGAffineTransform(scaleX: scaleX, y: scaleY))
        return self
    }
    
    // MARK: - Actions
    /**
     Moves the position of the view by changing the center point of the view.
     
     - parameter positionX: the new horizontal position of the view, from the center.
     - parameter positionY: the new vertical position of the view, from the center.
     */
    public func action(positionX: CGFloat, positionY: CGFloat) -> MixedAnimation {
        actions.append {
            self.view.center = CGPoint(x: positionX, y: positionY)
        }
        
        return self
    }
    
    /**
     Moves the position of the view a specified amount, from the center of the view.
     
     - parameter translateX: how much the view should move horizontally, from the center.
     - parameter translateY: how much the view should move vertically, from the center.
     */
    public func action(translateX: CGFloat, translateY: CGFloat) -> MixedAnimation {
        actions.append {
            self.view.center = CGPoint(x: self.view.center.x + translateX, y: self.view.center.y + translateY)
        }
        return self
    }
    
    /**
     Multiplies the object view's frame width and height values by the specified horizontal and vertical scale values.
     
     - parameter scaleX: the new horizontal scale value to be applied to the object's view.
     - parameter scaleY: the new vertical scale value to be applied to the object's view.
     */
    public func action(scaleX: CGFloat, scaleY: CGFloat) -> MixedAnimation {
        actions.append {
            let center = self.view.center
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width * scaleX,
                                     height: self.view.frame.height * scaleY)
            self.view.center = center
        }
        return self
    }
    
    /**
     Applies an alpha value to the object's view.
     
     - parameter alpha: the alpha value to be applied to the object's view.
     */
    public func action(alpha: CGFloat) -> MixedAnimation {
        actions.append({
            self.view.alpha = alpha
        })
        return self
    }
    
    /**
     Moves the view to the front or back of the superview.
     
     - parameter moveTo: the position the view should be moved to, in relation to it's superview. See `UIView.Position` for more details.
     */
    public func action(moveTo position: UIView.Position) -> MixedAnimation {
        actions.append({
            switch position {
            case .back:
                self.view.superview?.sendSubviewToBack(self.view)
            case .front:
                self.view.superview?.bringSubviewToFront(self.view)
            }
        })
        return self
    }
    
    /**
     Starts the first animation on the object's animation list.
     
     - parameter completion: completion handler for when the animation has finished.
     */
    public func startAnimation(completion: ((Bool) -> Void)? = .none) {
        UIView.animate(withDuration: duration, animations: {
            if self.transformations.count > 0 {
                self.view.transform = self.transformations[0]
                for i in 1..<self.transformations.count {
                    self.view.transform = self.view.transform.concatenating(self.transformations[i])
                }
            }
            self.actions.forEach { $0() }
        }, completion: completion)
    }
}
