//
//  Identifiable.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

/**
 Identifies an element.
 
 By default, it uses the type's simple name;
 except for NibLoadable components, it uses the nibname.
 */
public protocol Identifiable {
    /// The element's identifier.
    static var identifier: String { get }
}

public extension Identifiable {
    /// The element's identifier.
    static var identifier: String {
        return SimpleName(ofType: self)
    }
}

public extension Identifiable where Self: NibLoadable {
    /// The object's identifier when loaded from a Nib.
    static var identifier: String {
        return nibName
    }
}

extension UITableViewCell: Identifiable { }
extension UICollectionReusableView: Identifiable { }
extension UITableViewHeaderFooterView: Identifiable { }
