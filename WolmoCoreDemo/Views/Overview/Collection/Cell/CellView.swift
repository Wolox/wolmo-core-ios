//
//  CellView.swift
//  WolmoCoreDemo
//
//  Created by juan.martin.gordo on 21/03/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import UIKit

final class CellView: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.addShadow(cornerRadius: 5)
        }
    }
}
