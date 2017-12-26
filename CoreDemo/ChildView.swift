//
//  ChildView.swift
//  CoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import Core

final internal class ChildView: UIView, NibLoadable {

    @IBOutlet weak var centralView: UIView! {
        didSet {
            let gradientColors = [GradientColor(color: .clear, location: 0)!,
                                  GradientColor(color: .red, location: 0.5)!,
                                  GradientColor(color: .clear, location: 1)!]
            let viewGradient = ViewGradient(colors: gradientColors, direction: .bottomRightToTopLeft)
            centralView.gradient = viewGradient
        }
    }

}
