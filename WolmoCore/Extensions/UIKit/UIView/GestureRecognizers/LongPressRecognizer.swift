//
//  LongPressRecognizer.swift
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
        static var longPressGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var longPressGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.longPressGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let longPressGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.longPressGestureRecognizer) as? Action
            return longPressGestureRecognizerActionInstance
        }
    }
    
    /**
     Adds a long-press gesture recognizer that executes the closure when long pressed
     
     - Parameter action: The closure that will execute when the view is long pressed
     */
    public func addLongPressGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.longPressGestureRecognizerAction = action
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    // Every time the user long presses on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        if let action = self.longPressGestureRecognizerAction {
            action?()
        } else {
            print("No action for the long-press gesture")
        }
    }
    
}
