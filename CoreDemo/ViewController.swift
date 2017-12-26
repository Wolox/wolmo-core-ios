//
//  ViewController.swift
//  CoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import Core

final internal class ViewController: UIViewController {

    private lazy var _view: View = View.loadFromNib()!
    private lazy var _childController = ChildController()

    override func loadView() {
        view = _view
    }

}
