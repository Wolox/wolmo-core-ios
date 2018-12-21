//
//  PinchRecognizer.swift
//  WolmoCore
//
//  Created by Gabriel Mazzei on 21/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

public extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var pinchGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var pinchGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.pinchGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let pinchGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.pinchGestureRecognizer) as? Action
            return pinchGestureRecognizerActionInstance
        }
    }
    
    /**
     Adds a pinch gesture recognizer that executes the closure when pinched
     
     - Parameter action: The closure that will execute when the view is pinched
     */
    public func addPinchGestureRecognizer(action: (() -> Void)?) {
        isUserInteractionEnabled = true
        pinchGestureRecognizerAction = action
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        addGestureRecognizer(pinchGestureRecognizer)
    }
    
    // Every time the user pinches on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handlePinchGesture(sender: UIPinchGestureRecognizer) {
        if let action = pinchGestureRecognizerAction {
            action?()
        } else {
            print("No action for the pinch gesture")
        }
    }
    
}
