//
//  ChildController.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class ChildController: UIViewController {

    lazy var _view: ChildView = ChildView.loadFromNib()!

    override func loadView() {
        view = _view
    }

    internal func changeColor() {
        _view.centralView.backgroundColor = .brown
    }

}
