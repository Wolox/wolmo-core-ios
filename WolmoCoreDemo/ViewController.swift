//
//  ViewController.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 12/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final internal class ViewController: UIViewController {

    private lazy var _view: View = View.loadFromNib()!
    private lazy var _childController = ChildController()

    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        load(childViewController: _childController,
             into: _view.childContainerView,
             with: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0),
             respectSafeArea: true)
        _view.stringsButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        setupScreenGestures()
        setupLabelGestures()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _childController.changeColor()
    }
    
    @objc func buttonAction() {
        present(StringToImageController(), animated: true, completion: .none)
    }
    
    private func setupScreenGestures() {
        _view.addScreenEdgePanGestureRecognizer(edge: .left) { _ in
            print("Edge panned!")
        }
    }
    
    private func setupLabelGestures() {
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
