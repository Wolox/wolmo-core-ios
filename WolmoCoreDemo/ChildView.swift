//
//  ChildView.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class ChildView: UIView, NibLoadable {

    @IBOutlet weak var centralView: KVOView! {
        didSet {
            let gradientColors = [GradientColor(color: .clear, location: 0)!,
                                  GradientColor(color: .red, location: 0.5)!,
                                  GradientColor(color: .clear, location: 1)!]
            let viewGradient = ViewGradient(colors: gradientColors, direction: .bottomRightToTopLeft)
            centralView.gradient = viewGradient
        }
    }

    deinit {
        centralView.gradient = .none
    }

}

// You can use your own KVO even when using the view gradient.
final internal class KVOView: UIView {

    var label: UILabel!
    var observer: NSKeyValueObservation!

    override func awakeFromNib() {
        super.awakeFromNib()

        label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        observer = observe(\.backgroundColor) { object, _ in
            object.label.text = "New color is \(String(describing: object.backgroundColor))"
        }
    }

}
