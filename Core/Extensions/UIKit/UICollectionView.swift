//
//  UICollectionView.swift
//  Core
//
//  Created by Daniela Riesgo on 3/23/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    /**
         Registers a cell to be used by a UICollectionView.
         
         - parameter cellType: An identifiable cell to take the identifier from.
         - parameter bundle: The Bundle where the Nib for the cell is located.
     */
    public func register(_ cellType: IdentifiableCell.Type, bundle: Bundle? = .none) {
        register(UINib(nibName: cellType.cellIdentifier, bundle: bundle), forCellWithReuseIdentifier: cellType.cellIdentifier)
    }
    
    /**
         Returns a reusable cell of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
         
         - parameter cellType: An identifiable cell to take the identifier from.
         - parameter indexPath: IndexPath where to add the cell to the collection view.
     */
    public func dequeue<T: IdentifiableCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        //swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: cellType.cellIdentifier, for: indexPath) as! T
    }
    
}
