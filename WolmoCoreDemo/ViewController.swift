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
        
        _view.addScreenEdgePanGestureRecognizer(edges: [.left, .right]) { recognizer in
            print("Edge panned!")
        }
        
        _view.gestureLabel.addTapGestureRecognizer {
            print("Label tapped!")
        }
        _view.gestureLabel.addLongPressGestureRecognizer(minimumPressDuration: 1.0) { recognizer in
            print("Label long pressed!")
        }
        _view.gestureLabel.addPinchGestureRecognizer {
            print("Label pinched!")
        }
        _view.gestureLabel.addRotationGestureRecognizer { recognizer in
            print("Label rotated!")
        }
        _view.gestureLabel.addPanGestureRecognizer { recognizer in
            print("Label panned!")
        }
        _view.gestureLabel.addSwipeGestureRecognizer(direction: .left) { recognizer in
            print("Label swiped!")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _childController.changeColor()
    }
    
    @objc func buttonAction() {
        present(StringToImageController(), animated: true, completion: .none)
    }
}
