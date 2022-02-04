//
//  TapRecognizer.swift
//  WolmoCore
//
//  Created by Gabriel Mazzei on 17/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

public extension UIView {
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = ((UITapGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    /**
     Adds a tap gesture recognizer that executes the closure when tapped
     
     - Parameter numberOfTapsRequired: The number of taps required to match. Default is 1
     - Parameter numberOfTouchesRequired: The number of fingers required to match. Default is 1
     - Parameter action: The number of fingers required to match. Default is 1
     */
    func addTapGestureRecognizer(numberOfTapsRequired: Int = 1,
                                 numberOfTouchesRequired: Int = 1,
                                 action: ((UITapGestureRecognizer) -> Void)?) {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGestureRecognizer.numberOfTapsRequired = numberOfTapsRequired
        tapGestureRecognizer.numberOfTouchesRequired = numberOfTouchesRequired
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = tapGestureRecognizerAction {
            action?(sender)
        } else {
            print("No action for the tap gesture")
        }
    }
}
