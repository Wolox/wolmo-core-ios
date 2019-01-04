//
//  SwipeRecognizer.swift
//  WolmoCore
//
//  Created by Gabriel Mazzei on 26/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

public extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var swipeGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = ((UISwipeGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var swipeGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.swipeGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let swipeGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.swipeGestureRecognizer) as? Action
            return swipeGestureRecognizerActionInstance
        }
    }
    
    /**
     Adds a swipe gesture recognizer that executes the closure when swiped
     
     - Parameter numberOfTouchesRequired: The number of fingers that must swipe. Default is 1
     - Parameter direction: The desired direction of the swipe. Multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete). Default is right
     - Parameter action: The closure that will execute when the view is swiped
     */
    public func addSwipeGestureRecognizer(numberOfTouchesRequired: Int = 1,
                                          direction: UISwipeGestureRecognizerDirection = .right,
                                          action: ((UISwipeGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        swipeGestureRecognizerAction = action
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGestureRecognizer.direction = direction
        swipeGestureRecognizer.numberOfTouchesRequired = numberOfTouchesRequired
        addGestureRecognizer(swipeGestureRecognizer)
    }
    
    // Every time the user swipes on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        if let action = swipeGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the swipe gesture")
        }
    }
}
