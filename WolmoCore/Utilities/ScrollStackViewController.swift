//
//  ScrollStackViewController.swift
//  WolmoCore
//
//  Created by nicolas.e.manograsso on 19/12/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import UIKit

open class ScrollStackViewController: UIViewController {
    // MARK: - Private Properties
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    // MARK: - Lifecycle methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItems = []
        setupView()
    }

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

    open func add(_ child: UIViewController) {
        addChild(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
    
    open func add(_ child: UIView) {
        stackView.addArrangedSubview(child)
    }
    
    open func remove(_ child: UIViewController) {
        stackView.removeArrangedSubview(child.view)
        child.view.removeFromSuperview()
    }
}
