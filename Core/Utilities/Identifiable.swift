//
//  Identifiable.swift
//  Core
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
    
    static var identifier: String { get }
    
}

public extension Identifiable {
    
    public static var identifier: String {
        return SimpleName(ofType: self)
    }
    
}

public extension Identifiable where Self: NibLoadable {
    
    public static var identifier: String {
        return nibName
    }
    
}

extension UITableViewCell: Identifiable { }
extension UICollectionReusableView: Identifiable { }
extension UITableViewHeaderFooterView: Identifiable { }
