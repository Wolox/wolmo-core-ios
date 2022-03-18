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
    
    // MARK: - Lifecyle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .eerieBlack
        
        firstLabel.text = "This is a ScrollStack View. You can add Views or ViewControllers programatically, and they'll stack automatically."
        
        secondLabel.text = "The parent view will become scrollable if the height of the ViewControllers is taller than the height of the device's display."
        
        thirdLabel.text = "These are just some generic banners used for showing you this class. You can also create dynamic views in .xib format and add their associated ViewController."
        
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
    }
    
    override func addChildrenViewControllers() {
        add(firstView)
        add(firstLabel)
        add(secondView)
        add(secondLabel)
        add(thirdView)
        add(thirdLabel)
        add(fourthView)
        add(fourthLabel)
    }
    
    private var firstView: SimpleView {
        let view = SimpleView()
        view.cardView.backgroundColor = .deepSaffron
        view.cardView.addShadow()
        view.cardView.addShadow(opacity: 0.4, cornerRadius: 8)
        
        return view
    }
    
    private var secondView: SimpleView {
        let view = SimpleView()
        view.cardView.backgroundColor = .slateGray
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
    
    private var fourthView: SimpleView {
        let view = SimpleView()
        view.cardView.backgroundColor = .cyberYellow
        view.cardView.addShadow()
        view.cardView.addShadow(opacity: 0.4, cornerRadius: 8)
        
        if #available(iOS 13.0, *) {
            view.image.image = UIImage(systemName: "04.square.fill")
        }
        
        return view
    }
}

private extension UIColor {
    static var cyberYellow: UIColor {
        UIColor(named: "cyberYellow")!
    }
    
    static var deepSaffron: UIColor {
        UIColor(named: "deepSaffron")!
    }
    
    static var eerieBlack: UIColor {
        UIColor(named: "eerieBlack")!
    }
    
    static var pictorialCarmine: UIColor {
        UIColor(named: "pictorialCarmine")!
    }
    
    static var slateGray: UIColor {
        UIColor(named: "slateGray")!
    }
    
    static var UARed: UIColor {
        UIColor(named: "UARed")!
    }
}
