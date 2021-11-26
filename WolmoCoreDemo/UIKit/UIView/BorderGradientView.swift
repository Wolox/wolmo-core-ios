//
//  BorderGradientView.swift
//  WolmoCoreDemo
//
//  Created by nicolas.e.manograsso on 25/11/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import WolmoCore
import UIKit

final class BorderGradientView: NibView {
    @IBOutlet weak var topLeftView: UIView! {
        didSet {
            topLeftView.addShadow(opacity: 0.3)
        }
    }
    
    @IBOutlet weak var topRightView: UIView! {
        didSet {
            let borderViewProperties = BorderViewProperties(thickness: 2,
                                                            color: .init(hex: "121416")!,
                                                            rounded: false)
            topRightView.addBorders(properties: borderViewProperties,
                                  positions: [.top, .right, .bottom, .left])
        }
    }
    
    @IBOutlet weak var centerLeftView: UIView! {
        didSet {
            let borderViewProperties = BorderViewProperties(thickness: 4,
                                                            color: .init(hex: "121416")!,
                                                            rounded: true)
            centerLeftView.addBorders(properties: borderViewProperties,
                                 positions: [.top, .right, .bottom, .left],
                                 layout: .frame)
            centerLeftView.addShadow(opacity: 0.3)
            centerLeftView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var centerRightView: UIView! {
        didSet {
            let gradientColors = [GradientColor(color: .init(hex: "c8123f") ?? .clear, location: 0)!,
                                  GradientColor(color: .init(hex: "ad0c3b") ?? .clear, location: 0.5)!,
                                  GradientColor(color: .init(hex: "49202e") ?? .clear, location: 1)!]
            let viewGradient = ViewGradient(colors: gradientColors, direction: .topToBottom)
            centerRightView.gradient = viewGradient
        }
    }
    
    @IBOutlet weak var bottomLeftView: UIView! {
        didSet {
            bottomLeftView.addShadow(opacity: 0.3)
            let gradientColors = [GradientColor(color: .white, location: 0)!,
                                  GradientColor(color: .init(hex: "717a89") ?? .clear, location: 0.5)!,
                                  GradientColor(color: .init(hex: "121416") ?? .clear, location: 0.9)!]
            let viewGradient = ViewGradient(colors: gradientColors, direction: .topToBottom)
            bottomLeftView.gradient = viewGradient
            bottomLeftView.clipsToBounds = true
        }
    }

    @IBOutlet weak var bottomRightView: UIView! {
        didSet {
            bottomRightView.addShadow(opacity: 0.3)
            
            let gradientColors = [GradientColor(color: .init(hex: "c8123f") ?? .clear, location: 0)!,
                                  GradientColor(color: .init(hex: "ad0c3b") ?? .clear, location: 0.5)!,
                                  GradientColor(color: .init(hex: "49202e") ?? .clear, location: 0.9)!]
            let viewGradient = ViewGradient(colors: gradientColors, direction: .topToBottom)
            bottomRightView.gradient = viewGradient
            
            let borderViewProperties = BorderViewProperties(thickness: 2,
                                                            color: .init(hex: "121416")!,
                                                            rounded: false)
            bottomRightView.addBorders(properties: borderViewProperties,
                                  positions: [.top, .right, .bottom, .left])
            
            bottomRightView.clipsToBounds = true
        }
    }
}
