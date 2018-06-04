//
//  CustomFontProvider.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 04/06/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import WolmoCore

class CustomFontProvider: UIFontProvider {

    func appFontName(for style: UIFontTextStyle) -> String {
        switch style {
        case .headline: return "Kefa"
        case .body: return "Savoye LET"
        default: return UIFont.preferredFont(forTextStyle: style).fontName
        }
    }

}
