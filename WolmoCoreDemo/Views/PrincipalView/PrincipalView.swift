//
//  View.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class PrincipalView: NibView {
    let borderViewProperties = BorderViewProperties(thickness: 4, color: .red, rounded: true)
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.fontTextStyle = .headline
        }
    }
    @IBOutlet weak var roundBordersLabel: UILabel! {
        didSet {
            roundBordersLabel.addBorders(properties: borderViewProperties, positions: [.left, .right])
        }
    }
    @IBOutlet weak var bodyTextField: UITextField! {
        didSet {
            bodyTextField.fontTextStyle = .body
        }
    }
    
    @IBOutlet weak var stringsButton: UIButton!
    @IBOutlet weak var bordersGradientButton: UIButton!
    @IBOutlet weak var animationsButton: UIButton!
    
    @IBOutlet weak var childContainerView: UIView!
    
    @IBOutlet weak var gestureLabel: UILabel!
}
