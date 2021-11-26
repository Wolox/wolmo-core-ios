//
//  NibView.swift
//  WolmoCore
//
//  Created by nicolas.e.manograsso on 25/11/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import UIKit

open class NibView: UIView {
    private var view: UIView?

    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setups view from .xib file
    private func xibSetup() {
        backgroundColor = .clear
        let view = loadNib()

        // use bounds not frame or it'll be offset
        view.frame = bounds

        // Adding custom subview on top of our view
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))

        self.view = view
    }

    /// Loads instance from nib with the same name.
    private func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not instantiate view")
        }

        return view
    }
}
