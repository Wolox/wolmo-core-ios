//
//  UICollectionViewSpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
import WolmoCore

public class UICollectionViewSpec: QuickSpec, UICollectionViewDataSource, UICollectionViewDelegate {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    override public func spec() {
        var collectionView: UICollectionView!
        
        beforeEach {
            collectionView = NibLoadableUICollectionView.loadFromNib()!
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.reloadData()
        }
        describe("#register(cell:) and #dequeue(cell:for:)") {
            context("when dequeing an already registered cell") {
                it("should return the loaded cell") {
                    collectionView.register(cell: NibLoadableCollectionCell.self)
                    let cell = collectionView.dequeue(cell: NibLoadableCollectionCell.self, for: IndexPath(row: 0, section: 0))
                    expect(cell).toNot(beNil())
                }
            }
        }
    }
}
