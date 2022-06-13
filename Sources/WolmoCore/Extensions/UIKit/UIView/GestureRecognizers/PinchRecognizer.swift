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
    
    fileprivate typealias Action = ((UIPinchGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var pinchGestureRecognizerAction: Action? {
        get {
            let pinchGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.pinchGestureRecognizer) as? Action
            return pinchGestureRecognizerActionInstance
        }
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.pinchGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    /**
     Adds a pinch gesture recognizer that executes the closure when pinched
     
     - Parameter action: The closure that will execute when the view is pinched
     */
    func addPinchGestureRecognizer(action: ((UIPinchGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        pinchGestureRecognizerAction = action
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        addGestureRecognizer(pinchGestureRecognizer)
    }
    
    // Every time the user pinches on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handlePinchGesture(sender: UIPinchGestureRecognizer) {
        if let action = pinchGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the pinch gesture")
        }
    }
    
}
