//
//  ScrollStackViewController.swift
//  WolmoCore
//
//  Created by nicolas.e.manograsso on 19/12/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import UIKit

/**
 UIViewController that allows loading, stacking and removing different ViewControllers in a single view.
 */
open class ScrollStackViewController: UIViewController {
    // MARK: - Private Properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    // MARK: - Lifecycle methods
    /**
     This override sets the NavigationBar to be shown in the view, and shows no Buttons on the right side it.
     */
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItems = []
        setupView()
    }

    /**
     Method for loading the view sections into the parent view.
     
     Override this method and use the `add(_:)` functions to load UIViews and UIViewControllers with their corresponding views.
     */
    open func addChildrenViewControllers() {
        // Override this function with the view sections
    }
}

extension ScrollStackViewController {
    // MARK: - view configuration methods
    private func setupView() {
        view.addSubview(scrollView)
        addChildrenViewControllers()
        scrollView.addSubview(stackView)
        scrollView.bounces = false
        stackView.axis = .vertical
        setupConstraints()
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    /**
     Loads and displays a UIViewController (and it's corresponding view) into the current ViewController.
     */
    open func add(_ child: UIViewController) {
        addChild(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /**
     Loads and displays a UIView into the current ViewController.
     */
    open func add(_ child: UIView) {
        stackView.addArrangedSubview(child)
    }
    
    /**
     Removes a UIViewController's view from the current ViewController.
     */
    open func remove(_ child: UIViewController) {
        stackView.removeArrangedSubview(child.view)
        child.view.removeFromSuperview()
    }
}
