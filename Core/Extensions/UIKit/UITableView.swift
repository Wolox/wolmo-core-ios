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
         
         - parameter cellType: An identifiable cell to take the identifier from.
         - parameter bundle: The Bundle where the Nib for the cell is located.
     */
    public func register(cell cellType: IdentifiableCell.Type, bundle: Bundle? = .none) {
        let nib = UINib(nibName: cellType.cellIdentifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellType.cellIdentifier)
    }
    
    /**
        Registers a header or footer to be used by a UITableView.
    
        - parameter viewType: An identifiable view to take the identifier from.
        - parameter bundle: The Bundle where the Nib for the cell is located.
    */
    func register(headerFooter viewType: IdentifiableView.Type, bundle: Bundle? = .none) {
        let nib = UINib(nibName: viewType.viewIdentifier, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: viewType.viewIdentifier)
    }
    
    /**
         Returns a reusable cell of the type specified to be used by a UITableView.
         
         - parameter cellType: An identifiable cell to take the identifier from.
     */
    public func dequeue<T: IdentifiableCell>(_ cellType: T.Type) -> T {
        //swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: cellType.cellIdentifier) as! T
    }
    
    /**
         Returns a reusable cell of the type specified to be used and adds it
          to the UITableView in the indexPath specified.
         
         - parameter cellType: An identifiable cell to take the identifier from.
         - parameter indexPath: IndexPath where to add the cell to the table view.
     */
    public func dequeue<T: IdentifiableCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        //swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: cellType.cellIdentifier, for: indexPath) as! T
    }
    
}
