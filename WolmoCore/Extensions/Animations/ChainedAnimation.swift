//
//  ChainedAnimation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

/**
 Defines an Animation object with multiple animations to be played.
 */
public class ChainedAnimation: AnimationType {
    fileprivate let view: UIView
    fileprivate let loop: Bool
    fileprivate var completion: ((Bool) -> Void)? = .none
    fileprivate var animations: [AnimationType] = []
    fileprivate var currentAnimation = 0

    /**
     Initializer for the ChainedAnimation object.
     
     - parameter view: the view of the object.
     - parameter loop: Boolean value indicating whether the animation should loop.
     */
    init(view: UIView, loop: Bool = false) {
        self.view = view
        self.loop = loop
    }
    
    // MARK: - Add Methods
    /**
     Adds a `MixedAnimation` to the objects animation list.
     */
    public func add(animation: MixedAnimation) -> ChainedAnimation {
        animations.append(animation)
        return self
    }
    
    /**
     Adds a `SimpleAnimation` to the object's animation list.
     */
    public func add(animation: SimpleAnimation) -> ChainedAnimation {
        animations.append(animation)
        return self
    }
    
    // MARK: - Start Methods
    /**
     Starts the first animation on the object's animation list.
     
     - parameter completion: completion handler for when the animation has finished.
     */
    public func startAnimation(completion: ((Bool) -> Void)? = .none) {
        self.completion = completion
        animations[currentAnimation].startAnimation(completion: animationCompletion)
    }
    
}

// MARK: - Private Methods
fileprivate extension ChainedAnimation {
    func animationCompletion(completed: Bool) {
        currentAnimation += 1
        if currentAnimation >= animations.count {
            currentAnimation = 0
            completion?(completed)
            if !loop {
                return
            }
        }
        
        if let mixedAnimation = animations[currentAnimation] as? MixedAnimation {
            mixedAnimation.startAnimation(completion: animationCompletion)
        } else if let simpleAnimation = animations[currentAnimation] as? SimpleAnimation {
            simpleAnimation.startAnimation(completion: animationCompletion)
        }
    }
}
