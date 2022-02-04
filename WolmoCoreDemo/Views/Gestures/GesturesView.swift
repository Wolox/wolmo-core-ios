//
//  GesturesView.swift
//  WolmoCoreDemo
//
//  Created by nicolas.e.manograsso on 22/12/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import WolmoCore

final class GesturesView: NibView {
    // MARK: - Properties
    @IBOutlet weak var gameControllerView: UIView! {
        didSet {
            gameControllerView.addShadow(radius: 8,
                                         opacity: 0.1,
                                         cornerRadius: 14)
        }
    }
    
    @IBOutlet weak var swiftView: UIView! {
        didSet {
            swiftView.addShadow(radius: 8,
                                opacity: 0.1,
                                cornerRadius: 14)
        }
    }
    
    @IBOutlet weak var cardsContainerView: UIView!
    
    @IBOutlet weak var gestureLabel: UILabel!
}
