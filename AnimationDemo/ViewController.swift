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
    @IBOutlet weak var draggableView: UIImageView!
    
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
        
        draggableView.isDraggable(returnToPosition: true,
                                  onDragStarted: { view in
                view.backgroundColor = UIColor.blue
            },
                                  onDragFinished: { view in
                view.backgroundColor = UIColor.red
            })
        draggableView.backgroundColor = UIColor.red
        draggableView.layer.masksToBounds = true
        draggableView.layer.cornerRadius = 23.5
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

    /*
     Uses a pan gesture recognizer:
     - When the animation starts, rotates the view slighlty
     - When the user is moving the view, updates the view so it follows the user movement
     - When the interaction is finished: If the movement was bigger than the specified limit, it sends the view to the back
     - Actual angle rotation: 0.2618
    */
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
            print((CGFloat.pi * 15.0) / 180.0)

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

    /*
     Sends current view to the back, and brings the other view to the front
     */
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
        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transformIdentity()
            .startAnimation()
    }

    /*
     Creates a mixed animation, that sets the view in the middle of the container, make it bigger (scalling x 1)
     and put in at the start of subviews array
     */
    func bringToTop(view: UIView) {
        let halfWidthScreen = cardsContainerView.bounds.width / 2.0
        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transform(scaleX: 1, scaleY: 1)
            .action(alpha: 1)
            .action(moveTo: .front)
            .startAnimation()
    }

    /*
     Creates a mixed animation, that sets the view in the middle of the container, make it smaller (scalling x 0.9)
     and put in at the end of subviews array and a little upper so it can be seen
     */
    func sendToBack(view: UIView) {
        let halfWidthScreen = cardsContainerView.bounds.width / 2.0
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
