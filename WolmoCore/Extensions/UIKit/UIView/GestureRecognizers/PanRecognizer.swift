//
//  PanRecognizer.swift
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
        static var panGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var panGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let panGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer) as? Action
            return panGestureRecognizerActionInstance
        }
    }
    
    /**
     Adds a pan gesture recognizer that executes the closure when panned
     
     - Parameter action: The closure that will execute when the view is panned
     */
    public func addPanGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.panGestureRecognizerAction = action
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Every time the user pans on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handlePanGesture(sender: UIPanGestureRecognizer) {
        if let action = self.panGestureRecognizerAction {
            action?()
        } else {
            print("No action for the pan gesture")
        }
    }
    
}

