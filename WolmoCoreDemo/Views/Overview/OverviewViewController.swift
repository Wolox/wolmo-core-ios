//
//  OverviewViewController.swift
//  WolmoCoreDemo
//
//  Created by juan.martin.gordo on 18/03/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class OverviewViewController: ScrollStackViewController {
    // MARK: - Properties
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    private let fourthLabel = UILabel()
    private var views: [SimpleView] = []
    
    // MARK: - Lifecyle methods
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }
    
    override func addChildrenViewControllers() {
        add(firstView)
        add(firstLabel)
        add(secondView)
        add(secondLabel)
        add(thirdView)
        add(thirdLabel)
        add(CollectionViewController(cellSize: firstView.cardView.frame.size))
        add(fourthLabel)
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .eerieBlack
        
        firstLabel.text = "This is a ScrollStack View. You can add Views or ViewControllers programatically, and they'll stack automatically."
        
        secondLabel.text = "The parent view will become scrollable if the height of the ViewControllers is taller than the height of the device's display."
        
        thirdLabel.text = "These are just some generic banners used for showing you this class. You can also create dynamic views in .xib format and add their associated ViewController:"
        
        fourthLabel.text = "Cool, right?"
        
        let labels = [firstLabel,
                      secondLabel,
                      thirdLabel,
                      fourthLabel]
        for label in labels {
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .white
        }
        
        views = [firstView,
                 secondView,
                 thirdView]
    }
    
    // MARK: - Computed properties
    private var firstView: SimpleView {
        let view = SimpleView()
        view.cardView.backgroundColor = .cyberYellow
        view.cardView.addShadow()
        view.cardView.addShadow(opacity: 0.4, cornerRadius: 8)
        
        return view
    }
    
    private var secondView: SimpleView {
        let view = SimpleView()
        view.cardView.backgroundColor = .deepSaffron
        view.cardView.addShadow()
        view.cardView.addShadow(opacity: 0.4, cornerRadius: 8)
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "02.square.fill")
        }
        
        return view
    }
    
    private var thirdView: SimpleView {
        let view = SimpleView()
        view.cardView.backgroundColor = .UARed
        view.cardView.addShadow()
        view.cardView.addShadow(opacity: 0.4, cornerRadius: 8)
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "03.square.fill")
        }
        
        return view
    }
}
