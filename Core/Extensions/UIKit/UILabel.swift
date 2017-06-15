//
//  UILabel.swift
//  Core
//
//  Created by Daniela Riesgo on 6/5/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

public extension UILabel {

    /**
     fontTextStyle is intended to be used instead of setting the font style by taking advantage of
     `UIFont.preferredFont(forTextStyle:)` to manage your apps fonts.

     When the style is set, the corresponding font will be set.
     If the font is changed, then the label will have no specific font text style.
     
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

private var fontTextStyleKey: UInt8 = 0
private var fontTextStyleDisposableKey: UInt8 = 1
