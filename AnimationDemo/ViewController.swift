//
//  ViewController.swift
//  AnimationTest
//
//  Created by Argentino Ducret on 23/01/2018.
//  Copyright © 2018 wolox. All rights reserved.
//

import UIKit
import WolmoCore

class ViewController: UIViewController {

    // Card Animation
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var cardsContainerView: UIView!

    var rotationAnimator: UIViewPropertyAnimator!
    var lastTranslation = CGPoint.zero

    // Simple example animations
    @IBOutlet weak var redContainerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var animationViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0

        setUpCardAnimation()
        setupSimpleAnimations()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControlValueChanged()
    }
    
}

// MARK: - Card animation
extension ViewController {

    func setUpCardAnimation() {
        greenView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        yellowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
        sendToBack(view: yellowView)
    }

    @objc // swiftlint:disable:next function_body_length
    func dragView(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        let halfWidthScreen = cardsContainerView.bounds.width / 2.0
        let screenWidth = cardsContainerView.bounds.width
        let completeAnimationLimit = screenWidth - 50
        let swapViewsLimit = halfWidthScreen + 75

        switch gesture.state {
        case .began:
            rotationAnimator = UIViewPropertyAnimator(duration: 4, curve: UIViewAnimationCurve.easeInOut) {
                target.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * 15.0) / 180.0)
            }

        case .changed:
            let translation = gesture.translation(in: self.view)
            let dx = translation.x - lastTranslation.x
            guard target.center.x + dx > halfWidthScreen && target.center.x + dx < screenWidth else { break }

            target.center = CGPoint(x: target.center.x + dx, y: target.center.y)
            lastTranslation = translation
            rotationAnimator.fractionComplete = (target.center.x - halfWidthScreen) / completeAnimationLimit

        case .ended:
            lastTranslation = CGPoint.zero
            rotationAnimator.stopAnimation(true)

            if target.center.x >= swapViewsLimit {
                sendToBack(view: target)
                let otherView = getOtherView(view: target)
                bringToTop(view: otherView)
                changeGestureRecognizers(panView: target, tapView: otherView)
            } else {
                reset(view: target)
            }

        default:
            break
        }
    }

    @objc
    func tapView(gesture: UITapGestureRecognizer) {
        let target = gesture.view!
        bringToTop(view: target)
        let otherView = getOtherView(view: target)
        sendToBack(view: otherView)
        changeGestureRecognizers(panView: otherView, tapView: target)
    }

    func changeGestureRecognizers(panView: UIView, tapView: UIView) {
        panView.gestureRecognizers?.forEach { panView.removeGestureRecognizer($0) }
        tapView.gestureRecognizers?.forEach { tapView.removeGestureRecognizer($0) }

        tapView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        panView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
    }

    func getOtherView(view: UIView) -> UIView {
        if view.isEqual(greenView) {
            return yellowView
        } else {
            return greenView
        }
    }

    func reset(view: UIView) {
        let halfWidthScreen = cardsContainerView.bounds.width / 2.0
        //        UIView.animate(withDuration: 0.25) {
        //            view.center = CGPoint(x: halfWidthScreen, y: view.center.y)
        //            view.transform = CGAffineTransform.identity
        //        }
        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transformIdentity()
            .startAnimation()
    }

    func bringToTop(view: UIView) {
        let halfWidthScreen = cardsContainerView.bounds.width / 2.0
        //        UIView.animate(withDuration: 0.25) {
        //            view.center = CGPoint(x: halfWidthScreen, y: view.center.y)
        //            view.transform = CGAffineTransform.identity
        //                .concatenating(CGAffineTransform(scaleX: 1, y: 1))
        //            self.view.bringSubview(toFront: view)
        //            view.alpha = 1
        //        }

        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transform(scaleX: 1, scaleY: 1)
            .action(alpha: 1)
            .action(moveTo: .front)
            .startAnimation()
    }

    func sendToBack(view: UIView) {
        let halfWidthScreen = cardsContainerView.bounds.width / 2.0

        UIView.animate(withDuration: 0.25) {
            view.center = CGPoint(x: halfWidthScreen, y: view.center.y)
            view.transform = CGAffineTransform.identity
                .concatenating(CGAffineTransform(scaleX: 0.9, y: 0.9))
                .concatenating(CGAffineTransform(translationX: 0, y: -30))
            self.view.sendSubview(toBack: view)
            view.alpha = 0.5
        }

        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transformIdentity()
            .transform(scaleX: 0.9, scaleY: 0.9)
            .transform(translationX: 0, translationY: -30)
            .action(moveTo: .back)
            .action(alpha: 0.5)
            .startAnimation()
    }

}
