//
//  SimpleAnimation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

public class SimpleAnimation: AnimationType {
    fileprivate let view: UIView
    fileprivate var animations: [AnimationContent] = []
    fileprivate var completion: ((Bool) -> Void)? = .none
    
    init(view: UIView) {
        self.view = view
    }
    
    // MARK: - Transforms
    
    public func transformIdentity(withDuration duration: TimeInterval) -> SimpleAnimation {
        let transform = CGAffineTransform.identity
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    public func transform(withDuration duration: TimeInterval, translationX: CGFloat, translationY: CGFloat) -> SimpleAnimation {
        let transform = CGAffineTransform(translationX: translationX, y: translationY)
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    public func transform(withDuration duration: TimeInterval, rotationAngle: CGFloat) -> SimpleAnimation {
        let angleInRadians = (rotationAngle * CGFloat.pi) / 180.0
        let transform = CGAffineTransform(rotationAngle: angleInRadians)
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    public func transform(withDuration duration: TimeInterval, scaleX: CGFloat, scaleY: CGFloat) -> SimpleAnimation {
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        animations.append(.transform(transform, duration: duration))
        return self
    }
    
    // MARK: Actions
    
    public func action(withDuration duration: TimeInterval, positionX: CGFloat, positionY: CGFloat) -> SimpleAnimation {
        let action = {
            self.view.center = CGPoint(x: positionX, y: positionY)
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    public func action(withDuration duration: TimeInterval, translateX: CGFloat, translateY: CGFloat) -> SimpleAnimation {
        let action = {
            self.view.center = CGPoint(x: self.view.center.x + translateX, y: self.view.center.y + translateY)
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
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
    
    public func action(withDuration duration: TimeInterval, alpha: CGFloat) -> SimpleAnimation {
        let action = {
            self.view.alpha = alpha
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    public func action(withDuration duration: TimeInterval, moveTo position: UIView.Position) -> SimpleAnimation {
        let action = {
            switch position {
            case .back:
                self.view.superview?.sendSubview(toBack: self.view)
            case .front:
                self.view.superview?.bringSubview(toFront: self.view)
            }
        }
        animations.append(.action(action, duration: duration))
        return self
    }
    
    // MARK: - Start
    
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
