//
//  Animation.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 05/03/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import Foundation
import UIKit

public typealias Transform = CGAffineTransform
public typealias Action = () -> Void

public protocol AnimationType {

    func startAnimation(completion: ((Bool) -> Void)?)

}

public enum AnimationContent {
    case action(Action, duration: TimeInterval)
    case transform(Transform, duration: TimeInterval)
}

protocol Animation {

    func startAnimation(completion: ((Bool) -> Void)?)

}
