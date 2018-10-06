//
//  View.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class View: UIView, NibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.fontTextStyle = UIFontTextStyle.headline
        }
    }
    @IBOutlet weak var bodyTextField: UITextField! {
        didSet {
            bodyTextField.fontTextStyle = UIFontTextStyle.body
        }
    }
    @IBOutlet weak var stringsButton: UIButton!
    
    @IBOutlet weak var childContainerView: UIView!
    
}
