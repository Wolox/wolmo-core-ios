//
//  UIFont.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 6/15/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

// Needs to be a class or it won't work.
// TODO: Check why. Maybe for the `setAssociatedObject`? You can check using UILabelSpec.
public protocol UIFontProvider: class {

    /**
     Returns a valid font name associated with the font text style specified.
     By default, returns the font name of the font returned by
     `UIFont.preferredFont(forTextStyle:)`.

     - parameter style: A UIFontTextStyle.

     - seealso: `UIFont.preferredFont(forTextStyle:)`.
     */
    func appFontName(for style: UIFontTextStyle) -> String

}

public func == (lhs: UIFontProvider?, rhs: UIFontProvider?) -> Bool {
    switch (lhs, rhs) {
    case (.none, .none): return true
    case (.some(let lhs), .some(let rhs)):
        var styles: [UIFontTextStyle] = [.title1, .title2, .title3,
                                         .headline, .subheadline, .body, .callout,
                                         .footnote, .caption1, .caption2]
        if #available(iOS 11.0, *) {
            styles.append(.largeTitle)
        }

        for style in styles {
            if lhs.appFontName(for: style) != rhs.appFontName(for: style) {
                return false
            }
        }
        return true
    default: return false
    }
}

public extension UIFontProvider {

    public func appFontName(for style: UIFontTextStyle) -> String {
        return UIFont.preferredFont(forTextStyle: style).fontName
    }

}

private class DefaultFontProvider: UIFontProvider { }

public extension UIFont {

    /**
     UIFontProvider used to get the fonts associated with UIFontTextStyles.
    */
    public static var fontProvider: UIFontProvider? {
        get {
            return getAssociatedObject(self, key: &fontProviderKey)
        }

        set {
            setAssociatedObject(self, key: &fontProviderKey, value: newValue)
        }
    }

    /**
     Returns the UIFont associated with the font text style provided.
     This functions takes into consideration the font name provided by `fontProvider`
     and the size provided by `UIFont.preferredFont(forTextStyle:)` to
     build the final UIFont returned.

     - parameter style: The app's font style we want to use.
     - warning: This function may fail in runtime is the font provided by the `fontProvider`
        property is not a valid one (because it doesn't exist or it isn't added in the bundle).
     - seealso: UIFont.fontProvider and UIFont.preferredFont(forTextStyle:)
    */
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
