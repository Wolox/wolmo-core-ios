//
//  ViewController.swift
//  CoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import Core

class ViewController: UIViewController {

    private lazy var _view: View = View.loadFromNib()!
    private lazy var _childController = ChildController()

    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        load(childViewController: _childController, into: _view.childContainerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
