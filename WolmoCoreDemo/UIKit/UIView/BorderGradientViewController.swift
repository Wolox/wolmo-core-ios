//
//  BorderGradientViewController.swift
//  WolmoCoreDemo
//
//  Created by nicolas.e.manograsso on 25/11/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final class BorderGradientViewController: ScrollStackViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
    }
    
    private func setGradientBackground() {
        let gradientColors = [GradientColor(color: .white, location: 0)!,
                              GradientColor(color: .init(hex: "717a89") ?? .clear, location: 1)!]
        let viewGradient = ViewGradient(colors: gradientColors, direction: .topToBottom)
        view.gradient = viewGradient
    }
    
    override func addChildrenViewControllers() {
        add(firstView)
        add(secondView)
        add(thirdView)
        add(fourthView)
        add(fifthView)
    }
    
    private var firstView: SimpleView {
        let view = SimpleView()
        view.cardView.addShadow(opacity: 0.4, cornerRadius: 8)
        
        return view
    }
    
    private var secondView: SimpleView {
        let view = firstView
        
        let borderViewProperties = BorderViewProperties(thickness: 4,
                                                        color: .init(hex: "121416")!,
                                                        rounded: false)
        view.cardView.addBorders(properties: borderViewProperties,
                                 positions: [.left])
        
        view.cardView.clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "02.square.fill")
        }
        
        return view
    }
    
    private var thirdView: SimpleView {
        let view = firstView
        
        let borderViewProperties = BorderViewProperties(thickness: 4,
                                                        color: .init(hex: "121416")!,
                                                        rounded: false)
        view.cardView.addBorders(properties: borderViewProperties,
                                 positions: [.top, .bottom])
        
        let gradientColors = [GradientColor(color: .init(hex: "ffcd37") ?? .clear, location: 0)!,
                              GradientColor(color: .init(hex: "fe942f") ?? .clear, location: 1)!]
        let viewGradient = ViewGradient(colors: gradientColors, direction: .topLeftToBottomRight)
        view.cardView.gradient = viewGradient
        
        view.cardView.clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "03.square.fill")
        }
        
        return view
    }
    
    private var fourthView: SimpleView {
        let view = firstView
        
        let borderViewProperties = BorderViewProperties(thickness: 4,
                                                        color: .white,
                                                        rounded: true)
        view.cardView.addBorders(properties: borderViewProperties,
                                 positions: [.top, .bottom, .left, .right],
                                 layout: .frame)
        
        let colors = [UIColor(hex: "c8123f") ?? .clear,
                      UIColor(hex: "ad0c3b") ?? .clear,
                      UIColor(hex: "49202e") ?? .clear]
        let viewGradient = ViewGradient(colors: colors, direction: .leftToRight)
        view.cardView.gradient = viewGradient
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "04.square.fill")
        }
        
        view.image.tintColor = .white
        
        return view
    }
    
    private var fifthView: SimpleView {
        let view = firstView
        
        let colors = [UIColor(hex: "c8123f") ?? .clear,
                      UIColor(hex: "ad0c3b") ?? .clear,
                      UIColor(hex: "49202e") ?? .clear,
                      UIColor(hex: "49202e") ?? .clear,
                      UIColor(hex: "ad0c3b") ?? .clear,
                      UIColor(hex: "c8123f") ?? .clear]
        let viewGradient = ViewGradient(colors: colors, direction: .bottomRightToTopLeft)
        view.cardView.gradient = viewGradient
        
        view.cardView.clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "05.square.fill")
        }
        
        view.image.tintColor = .white
        
        return view
    }
}
