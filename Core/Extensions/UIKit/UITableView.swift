//
//  UITableView.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /**
         Registers a cell to be used by a UITableView.
         
         - parameter cellType: An identifiable, nibloadable cell type
                to take the identifier and nib from.
     */
    public func register<T: Identifiable>(cell cellType: T.Type) where T: NibLoadable {
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    /**
         Registers a header to be used by a UITableView.
         
         - parameter headerType: An identifiable, nibloadable header type
                to take the identifier and nib from.
     */
    func register<T: Identifiable>(header headerType: T.Type) where T: NibLoadable {
        register(headerType.nib, forHeaderFooterViewReuseIdentifier: headerType.identifier)
    }
    
    /**
         Registers a footer to be used by a UITableView.
         
         - parameter footerType: An identifiable, nibloadable footer type
                to take the identifier and nib from.
     */
    func register<T: Identifiable>(footer footerType: T.Type) where T: NibLoadable {
        register(footerType.nib, forHeaderFooterViewReuseIdentifier: footerType.identifier)
    }
    
    /**
         Returns a reusable cell of the type specified to be used by a UITableView.
         
         - parameter cellType: An identifiable cell to take the identifier from.
     */
    public func dequeue<T: Identifiable>(cell cellType: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellType.identifier) as? T
    }
    
    /**
         Returns a reusable cell of the type specified to be used and adds it
          to the UITableView in the indexPath specified.
         
         - parameter cellType: An identifiable cell to take the identifier from.
         - parameter indexPath: IndexPath where to add the cell to the table view.
     */
    public func dequeue<T: Identifiable>(cell cellType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T
    }
    
    /**
         Returns a reusable header of the type specified to be used in the UITableView.
         
         - parameter headerType: An identifiable header to take the identifier from.
     */
    public func dequeue<T: Identifiable>(header headerType: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: headerType.identifier) as? T
    }
    
    /**
         Returns a reusable footer of the type specified to be used in the UITableView.
         
         - parameter footerType: An identifiable footer to take the identifier from.
     */
    public func dequeue<T: Identifiable>(footer footerType: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: footerType.identifier) as? T
    }
    
}
