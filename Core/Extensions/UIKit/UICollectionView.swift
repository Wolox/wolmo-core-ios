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
         
         - parameter cellType: An identifiable, nibloadable cell type
                to take the identifier and nib from.
     */
    public func register<T: Identifiable>(cell cellType: T.Type) where T: NibLoadable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    /**
         Registers a header to be used by a UICollectionView.
         
         - parameter headerType: An identifiable, nibloadable header type
                to take the identifier and nib from.
     */
    public func register<T: Identifiable>(header headerType: T.Type) where T: NibLoadable {
        register(headerType.nib,
                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                 withReuseIdentifier: headerType.identifier)
    }
    
    /**
         Registers a footer to be used by a UICollectionView.
         
         - parameter footerType: An identifiable, nibloadable footer type
                to take the identifier and nib from.
     */
    func register<T: Identifiable>(footer footerType: T.Type) where T: NibLoadable {
        register(footerType.nib,
                 forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                 withReuseIdentifier: footerType.identifier)
    }
    
    /**
         Returns a reusable cell of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
         
         - parameter cellType: An identifiable cell to take the identifier from.
         - parameter indexPath: IndexPath where to add the cell to the collection view.
     */
    public func dequeue<T: Identifiable>(cell cellType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T
    }
    
    /**
         Returns a reusable header of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
     
         - parameter headerType: An identifiable header to take the identifier from.
     */
    public func dequeue<T: Identifiable>(header headerType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                withReuseIdentifier: headerType.identifier,
                                                for: indexPath) as? T
    }
    
    /**
         Returns a reusable footer of the type specified to be used and adds it
         to the UICollectionView in the indexPath specified.
     
         - parameter footerType: An identifiable footer to take the identifier from.
     */
    public func dequeue<T: Identifiable>(footer footerType: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                withReuseIdentifier: footerType.identifier,
                                                for: indexPath) as? T
    }
    
}
