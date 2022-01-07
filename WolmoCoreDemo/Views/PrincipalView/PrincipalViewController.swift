//
//  ViewController.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class PrincipalViewController: UIViewController {
    // MARK: - Private properties
    private lazy var _view = PrincipalView()

    // MARK: - Lifecycle methods
    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension PrincipalViewController {
    func setupButtons() {
        _view.stringsButton.addTarget(self,
                                      action: #selector(onTapStringsButton),
                                      for: .touchUpInside)
        
        _view.bordersGradientButton.addTarget(self,
                                              action: #selector(onTapBordersGradientButton),
                                              for: .touchUpInside)
        
        _view.animationsButton.addTarget(self,
                                         action: #selector(onTapAnimationsButton),
                                         for: .touchUpInside)
        
        _view.gesturesButton.addTarget(self,
                                       action: #selector(onTapGesturesButton),
                                       for: .touchUpInside)
    }
    
    @objc func onTapStringsButton() {
        present(StringToImageController(),
                animated: true)
    }
    
    @objc func onTapBordersGradientButton() {
        present(BorderGradientViewController(),
                animated: true)
    }
    
    @objc func onTapAnimationsButton() {
        present(AnimationsViewController(),
                animated: true)
    }
    
    @objc func onTapGesturesButton() {
        present(GesturesViewController(),
                animated: true)
    }
}
