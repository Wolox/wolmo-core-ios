//
//  UITextFieldExtension.swift
//  Core
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

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
    public var fontTextStyle: UIFontTextStyle? {
        get {
            return getAssociatedObject(self, key: &fontTextStyleKey)
        }

        set {
            if let disposable: Disposable = getAssociatedObject(self, key: &fontTextStyleDisposableKey) {
                disposable.dispose()
                setAssociatedObject(self, key: &fontTextStyleDisposableKey, value: Disposable?.none, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            setAssociatedObject(self, key: &fontTextStyleKey, value: newValue, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let fontStyle = fontTextStyle {
                font = UIFont.appFont(for: fontStyle)
                let disposable = reactive.signal(forKeyPath: "font")
                    .take(during: self.reactive.lifetime)
                    .take(first: 1)
                    .observeValues { [unowned self] _ in
                        setAssociatedObject(self,
                                            key: &fontTextStyleKey,
                                            value: UIFontTextStyle?.none,
                                            policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
                setAssociatedObject(self, key: &fontTextStyleDisposableKey, value: disposable, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

}

private var nextTextFieldKey: UInt8 = 0
private var fontTextStyleKey: UInt8 = 1
private var fontTextStyleDisposableKey: UInt8 = 2
