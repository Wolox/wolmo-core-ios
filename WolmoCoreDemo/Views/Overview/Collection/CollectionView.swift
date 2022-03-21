//
//  CollectionView.swift
//  WolmoCoreDemo
//
//  Created by juan.martin.gordo on 21/03/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final class CollectionView: NibView {
    @IBOutlet var mainView: UIView! {
        didSet {
            mainView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint! {
        didSet {
            collectionViewWidthConstraint.constant = UIScreen.main.bounds.width
        }
    }
}
