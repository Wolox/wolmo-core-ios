//
//  BorderGradientViewController.swift
//  WolmoCoreDemo
//
//  Created by nicolas.e.manograsso on 25/11/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import UIKit

final class BorderGradientViewController: UIViewController {
    lazy var bordersView = BorderGradientView()
    
    override func loadView() {
        view = bordersView
    }
}
