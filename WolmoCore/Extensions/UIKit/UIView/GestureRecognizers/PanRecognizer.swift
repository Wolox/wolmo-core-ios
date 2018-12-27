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
    
    fileprivate typealias Action = ((UIPanGestureRecognizer) -> Void)?
    
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
     
     - Parameter minimumNumberOfTouches: The minimum number of touches required to match. Default is 1
     - Parameter maximumNumberOfTouches: The maximum number of touches that can be down. Default is Int.max
     - Parameter action: The closure that will execute when the view is panned
     */
    public func addPanGestureRecognizer(minimumNumberOfTouches: Int = 1,
                                        maximumNumberOfTouches: Int = .max,
                                        action: ((UIPanGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        panGestureRecognizerAction = action
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.minimumNumberOfTouches = minimumNumberOfTouches
        panGestureRecognizer.maximumNumberOfTouches = maximumNumberOfTouches
        addGestureRecognizer(panGestureRecognizer)
    }
    
    // Every time the user pans on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handlePanGesture(sender: UIPanGestureRecognizer) {
        if let action = panGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the pan gesture")
        }
    }
}
