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
    
   public enum Position {
        case back
        case front
    }
    
    public func simpleAnimation() -> SimpleAnimation {
        return SimpleAnimation(view: self)
    }
    
    public func mixedAnimation(withDuration duration: TimeInterval) -> MixedAnimation {
        return MixedAnimation(view: self, duration: duration)
    }
    
    public func chainedAnimation(loop: Bool = false) -> ChainedAnimation {
        return ChainedAnimation(view: self, loop: loop)
    }
    
}
