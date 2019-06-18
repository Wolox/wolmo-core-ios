//
//  UILabel.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 6/5/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

public extension UILabel {

    /**
     fontTextStyle is intended to be used instead of setting the font style by taking advantage of
     `UIFont.preferredFont(forTextStyle:)` to manage your apps fonts.

     When the style is set, the corresponding font will be set.
     If the font is changed, then the label will have no specific font text style.
     
     - warning: Setting this property may arise a runtime error if the font name returned by
     `UIFont.appFontName(for:)` is not valid.
     - warning: To avoid memory leak and crashes, you should set the `fontTextStyle` to .none before deallocating the label.
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

private var fontTextStyleKey: UInt8 = 0
private var fontTextStyleObserverKey: UInt8 = 1
