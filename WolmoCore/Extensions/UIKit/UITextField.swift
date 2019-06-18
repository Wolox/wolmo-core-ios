//
//  UITextFieldExtension.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension UITextField {
    
    /**
     nextTextField is intended to be used in a form, so that the delegate uses it, for example, in the textFieldShouldReturn method.
     
     - warning: Avoid setting nextTextField in the didSet hook of an outlet.
                Override awakeFromNib() of the containing view in that case.
     */
    public var nextTextField: UITextField? {
        get {
            return getAssociatedObject(self, key: &nextTextFieldKey)
        }
        
        set {
            setAssociatedObject(self, key: &nextTextFieldKey, value: newValue, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /**
     fontTextStyle is intended to be used instead of setting the font style by taking advantage of
     `UIFont.preferredFont(forTextStyle:)` to manage your app's fonts.
     
     When the style is set, the corresponding font will be set.
     If the font is changed, then the textfield will have no specific font text style.
     
     - warning: Setting this property may arise a runtime error if the font name returned by
        `UIFont.appFontName(for:)` is not valid.
     - seealso: UIFont.appFontName(for:).
    */
    public var fontTextStyle: UIFont.TextStyle? {
        get {
            return getStyle()
        }

        set {
            if fontTextStyle != nil {
                removeOldStyle()
            }
            if let style = newValue {
                applyNewStyle(style)
            }
        }
    }

    private func getStyle() -> UIFont.TextStyle? {
        return getAssociatedObject(self, key: &fontTextStyleKey)
    }

    private func removeOldStyle() {
        setAssociatedObject(self, key: &fontTextStyleKey, value: UIFont.TextStyle?.none)
        setAssociatedObject(self, key: &fontTextStyleObserverKey, value: NSKeyValueObservation?.none)
    }

    private func applyNewStyle(_ style: UIFont.TextStyle) {
        setAssociatedObject(self, key: &fontTextStyleKey, value: style)
        font = UIFont.appFont(for: style)
        let observer = observe(\.font) { object, _ in
            setAssociatedObject(object, key: &fontTextStyleKey, value: UIFont.TextStyle?.none)
            setAssociatedObject(object, key: &fontTextStyleObserverKey, value: NSKeyValueObservation?.none)
        }
        setAssociatedObject(self, key: &fontTextStyleObserverKey, value: observer as NSKeyValueObservation?)
    }

}

private var nextTextFieldKey: UInt8 = 0
private var fontTextStyleKey: UInt8 = 1
private var fontTextStyleObserverKey: UInt8 = 2
