//
//  Identifiable.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

/**
 Identifies a cell
 */
public protocol Identifiable {
    
    static var identifier: String { get }
    
}

public extension Identifiable where Self: NibLoadable {
    
    public static var identifier: String {
        return nibName
    }
    
}

extension UITableViewCell: Identifiable {}
extension UICollectionReusableView: Identifiable {}
