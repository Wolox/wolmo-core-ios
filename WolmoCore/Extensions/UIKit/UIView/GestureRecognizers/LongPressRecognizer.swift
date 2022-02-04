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
    
    fileprivate typealias Action = ((UILongPressGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var longPressGestureRecognizerAction: Action? {
        get {
            let longPressGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.longPressGestureRecognizer) as? Action
            return longPressGestureRecognizerActionInstance
        }
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.longPressGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    /**
     Adds a long-press gesture recognizer that executes the closure when long pressed
     
     - Parameter numberOfTapsRequired: The number of full taps required before the press for gesture to be recognized. Default is 0
     - Parameter numberOfTouchesRequired: Number of fingers that must be held down for the gesture to be recognized. Default is 1
     - Parameter minimumPressDuration: Time in seconds the fingers must be held down for the gesture to be recognized. Default is 0.5
     - Parameter allowableMovement: Maximum movement in pixels allowed before the gesture fails. Once recognized (after minimumPressDuration) there is no limit on finger movement for the remainder of the touch tracking. Default is 10
     - Parameter action: The closure that will execute when the view is long pressed
     */
    func addLongPressGestureRecognizer(numberOfTapsRequired: Int = 0,
                                       numberOfTouchesRequired: Int = 1,
                                       minimumPressDuration: TimeInterval = 0.5,
                                       allowableMovement: CGFloat = 10,
                                       action: ((UILongPressGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        longPressGestureRecognizerAction = action
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        longPressGestureRecognizer.numberOfTapsRequired = numberOfTapsRequired
        longPressGestureRecognizer.numberOfTouchesRequired = numberOfTouchesRequired
        longPressGestureRecognizer.minimumPressDuration = minimumPressDuration
        longPressGestureRecognizer.allowableMovement = allowableMovement
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    // Every time the user long presses on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        if let action = longPressGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the long-press gesture")
        }
    }
}
