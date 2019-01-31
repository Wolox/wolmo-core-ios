//
//  ScreenEdgePanRecognizer.swift
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
        static var screenEdgePanGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = ((UIScreenEdgePanGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var screenEdgePanGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.screenEdgePanGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let screenEdgePanGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.screenEdgePanGestureRecognizer) as? Action
            return screenEdgePanGestureRecognizerActionInstance
        }
    }
    
    /**
     Adds a screen-edge-pan gesture recognizer that executes the closure when panned on the edge
     - Parameter edge: The edge on which this gesture recognizes, relative to the current interface orientation.
     - Parameter action: The closure that will execute when the edge of the view is panned
     */
    public func addScreenEdgePanGestureRecognizer(edge: UIRectEdge, action: ((UIScreenEdgePanGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        screenEdgePanGestureRecognizerAction = action
        let screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePanGesture))
        screenEdgePanGestureRecognizer.edges = edge
        addGestureRecognizer(screenEdgePanGestureRecognizer)
    }
    
    // Every time the user pans on the edge of the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleScreenEdgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        if let action = screenEdgePanGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the screen edge pan gesture")
        }
    }
    
}
