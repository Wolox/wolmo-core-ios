//
//  UIViewExtension.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 24/01/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    enum Position {
        case back
        case front
    }
    
    /**
     Creates a SimpleAnimation that allows you to add different actions and transformations to the view, executing each of them only when the previous one is finished in the order they were added.
     
     - Returns: SimpleAnimation for this view
     
     */
    func simpleAnimation() -> SimpleAnimation {
        return SimpleAnimation(view: self)
    }
    
    /**
     Creates a MixedAnimation that allows you to add different actions and transformations to the view, concatenating and executing first all transformations and when that is done, executes each action that was added.
     
     - Returns: MixedAnimation for this view
     
     */
    func mixedAnimation(withDuration duration: TimeInterval) -> MixedAnimation {
        return MixedAnimation(view: self, duration: duration)
    }
    
    /**
     Creates a ChainedAnimation that allows you to combine SimpleAnimations and MixedAnimations, and execute them in the order they were added.
     
     - Returns: ChainedAnimation for this view
     
     */
    func chainedAnimation(loop: Bool = false) -> ChainedAnimation {
        return ChainedAnimation(view: self, loop: loop)
    }
    
    /**
     Adds a shake animation that executes the closure when long pressed
     
     - Parameter duration: Time in seconds the animation will be executed. Default is 0.05
     - Parameter repeatShake: Number of times the view will change position. Default is 3
     
     */
    
    func shake(withDuration duration: TimeInterval = 0.05, repeatShake: Float = 3) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatShake
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: center.x - 4, y: center.y)
        animation.toValue = CGPoint(x: center.x + 4, y: center.y)
        
        layer.add(animation, forKey: "position")
    }
    
    /**
     Allows dragging the view and executing actions when the press gesture begins or ends.
     
     - Parameter returnToPosition: Whether the view will return to its original position when released. Default is true
     - Parameter duration: Time in seconds that it takes for the view to return to the original position. Default is 0.5
     - Parameter onDragStarted: The closure that will execute when the view is held
     - Parameter onDragFinished: The closure that will execute when the view is released
     
     */
    
    func isDraggable(returnToPosition: Bool = true, withDuration duration: TimeInterval = 0.5, onDragStarted: ((UIView) -> Void)?, onDragFinished: ((UIView) -> Void)?) {
        var origin: CGPoint = frame.origin
        
        addPanGestureRecognizer { [weak self] recognizer in
            let translation = recognizer.translation(in: self)
            guard let guardSelf = self else { return }
            switch recognizer.state {
            case .began:
                origin = guardSelf.frame.origin
                onDragStarted?(guardSelf)
            case .changed:
                guardSelf.center = CGPoint(x: guardSelf.center.x + translation.x, y: guardSelf.center.y + translation.y)
                recognizer.setTranslation(CGPoint.zero, in: self)
            case .ended:
                onDragFinished?(guardSelf)
                if returnToPosition {
                    UIView.animate(withDuration: duration, animations: {
                        guardSelf.frame.origin = origin
                    })
                }
            default:
                break
            }
        }
    }
}
