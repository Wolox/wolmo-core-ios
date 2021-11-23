//
//  RotationRecognizer.swift
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
        static var rotationGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = ((UIRotationGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var rotationGestureRecognizerAction: Action? {
        get {
            let rotationGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.rotationGestureRecognizer) as? Action
            return rotationGestureRecognizerActionInstance
        }
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.rotationGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    /**
     Adds a rotation gesture recognizer that executes the closure when rotated
     
     - Parameter action: The closure that will execute when the view is rotated
     */
    func addRotationGestureRecognizer(action: ((UIRotationGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        rotationGestureRecognizerAction = action
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture))
        addGestureRecognizer(rotationGestureRecognizer)
    }
    
    // Every time the user rotates on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleRotationGesture(sender: UIRotationGestureRecognizer) {
        if let action = rotationGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the rotation gesture")
        }
    }
}
