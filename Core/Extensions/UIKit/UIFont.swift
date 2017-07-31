//
//  UIFont.swift
//  Core
//
//  Created by Daniela Riesgo on 6/15/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

public protocol UIFontProvider {

    /**
     Returns a valid font name associated with the font text style specified.
     By default, returns the font name of the font returned by
     `UIFont.preferredFont(forTextStyle:)`.

     - parameter style: A UIFontTextStyle.

     - seealso: `UIFont.preferredFont(forTextStyle:)`.
     */
    func appFontName(for style: UIFontTextStyle) -> String

}

public extension UIFontProvider {

    public func appFontName(for style: UIFontTextStyle) -> String {
        return UIFont.preferredFont(forTextStyle: style).fontName
    }

}

fileprivate class DefaultFontProvider: UIFontProvider {}

public extension UIFont {

    /**
     UIFontProvider used to get the fonts associated with UIFontTextStyles.
    */
    public static var fontProvider: UIFontProvider? {
        get {
            return getAssociatedObject(self, key: &fontProviderKey)
        }

        set {
            setAssociatedObject(self, key: &fontProviderKey, value: newValue, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public static func appFont(for style: UIFontTextStyle) -> UIFont {
        let defaultFont = UIFont.preferredFont(forTextStyle: style)
        let provider = fontProvider ?? DefaultFontProvider()
        let fontName = provider.appFontName(for: style)
        if let newFont = UIFont(name: fontName, size: defaultFont.pointSize) {
            return newFont
        }
        fatalError("The font name associated with UIFontTextStyle \(style) is not valid.")
    }

}

private var fontProviderKey: UInt8 = 0
