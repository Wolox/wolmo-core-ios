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
        
        setupScreenGestures()
        setupLabelGestures()
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
    }
    
    @objc func onTapStringsButton() {
        present(StringToImageController(),
                animated: true)
    }
    
    @objc func onTapBordersGradientButton() {
        present(BorderGradientViewController(),
                animated: true)
    }
    
    func setupScreenGestures() {
        _view.addScreenEdgePanGestureRecognizer(edge: .left) { _ in
            print("Edge panned!")
        }
    }
    
    func setupLabelGestures() {
        _view.gestureLabel.addTapGestureRecognizer(numberOfTapsRequired: 1) { [weak self] _ in
            self?._view.gestureLabel.shake(withDuration: 0.05)
            print("Label tapped!")
        }
        _view.gestureLabel.addLongPressGestureRecognizer(minimumPressDuration: 1.0) { _ in
            print("Label long pressed!")
        }
        _view.gestureLabel.addPinchGestureRecognizer { _ in
            print("Label pinched!")
        }
        _view.gestureLabel.addRotationGestureRecognizer { _ in
            print("Label rotated!")
        }
        _view.gestureLabel.addPanGestureRecognizer { _ in
            print("Label panned!")
        }
        _view.gestureLabel.addSwipeGestureRecognizer(direction: .left) { _ in
            print("Label swiped!")
        }
    }
}
