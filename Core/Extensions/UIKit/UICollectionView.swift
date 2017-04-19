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
         
         - parameter cellType: A nibloadable collection view cell type
                to take the identifier and nib from.
     */
    public func register<T: UICollectionViewCell>(cell cellType: T.Type) where T: NibLoadable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    /**
         Registers a header to be used by a UICollectionView.
         
         - parameter headerType: A nibloadable reusable view type
                to take the identifier and nib from.
     */
    public func register<T: UICollectionReusableView>(header headerType: T.Type) where T: NibLoadable {
        register(headerType.nib,
                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                 withReuseIdentifier: headerType.identifier)
    }
    
    /**
         Registers a footer to be used by a UICollectionView.
         
         - parameter footerType: A nibloadable reusable view type
                to take the identifier and nib from.
     */
    func register<T: UICollectionReusableView>(footer footerType: T.Type) where T: NibLoadable {
        register(footerType.nib,
                 forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                 withReuseIdentifier: footerType.identifier)
    }
    
    /**
         Returns a reusable cell of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
         
         - parameter cellType: A collection cell to take the identifier from.
         - parameter indexPath: IndexPath where to add the cell to the collection view.
     */
    public func dequeue<T: UICollectionViewCell>(cell cellType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T
    }
    
    /**
         Returns a reusable header of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
     
         - parameter headerType: A collection reusable header view to take the identifier from.
     */
    public func dequeue<T: UICollectionReusableView>(header headerType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                withReuseIdentifier: headerType.identifier,
                                                for: indexPath) as? T
    }
    
    /**
         Returns a reusable footer of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
     
         - parameter footerType: AA collection reusable footer view to take the identifier from.
     */
    public func dequeue<T: UICollectionReusableView>(footer footerType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                withReuseIdentifier: footerType.identifier,
                                                for: indexPath) as? T
    }
    
}
