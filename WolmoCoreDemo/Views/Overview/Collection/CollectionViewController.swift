//
//  CollectionViewController.swift
//  WolmoCoreDemo
//
//  Created by juan.martin.gordo on 21/03/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import UIKit

final class CollectionViewController: UIViewController {
    private var _view = CollectionView()
    private let colorsList: [UIColor] = [.cyberYellow,
                                         .deepSaffron,
                                         .pictorialCarmine,
                                         .slateGray]
    private let cellSize: CGSize
    
    init(cellSize: CGSize) {
        self.cellSize = cellSize
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: CellView.identifier, bundle: nil)
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
        _view.collectionView.register(nib, forCellWithReuseIdentifier: CellView.identifier)
        super.viewDidLoad()
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.identifier, for: indexPath) as? CellView else {
            return CellView()
        }
        cell.cellView.backgroundColor = colorsList[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
}
