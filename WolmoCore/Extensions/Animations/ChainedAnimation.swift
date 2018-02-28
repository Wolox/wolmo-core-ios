//
//  ChainedAnimation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

public class ChainedAnimation: AnimationType {
    fileprivate let view: UIView
    fileprivate let loop: Bool
    fileprivate var completion: ((Bool) -> Void)? = .none
    fileprivate var animations: [AnimationType] = []
    fileprivate var currentAnimation = 0

    init(view: UIView, loop: Bool = false) {
        self.view = view
        self.loop = loop
    }
    
    // MARK: - Add Methods
    
    public func add(animation: MixedAnimation) -> ChainedAnimation {
        animations.append(animation)
        return self
    }
    
    public func add(animation: SimpleAnimation) -> ChainedAnimation {
        animations.append(animation)
        return self
    }
    
    // MARK: - Start Methods

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
