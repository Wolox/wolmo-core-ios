//
//  GesturesViewController.swift
//  AnimationDemo
//
//  Created by Argentino Ducret on 23/01/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

final class GesturesViewController: UIViewController {
    // MARK: - Properties
    private let gesturesView = GesturesView()
    private var rotationAnimator: UIViewPropertyAnimator!
    private var lastTranslation = CGPoint.zero
    private var animationViews: [UIView] = []
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCardAnimation()
        setupScreenGestures()
        setupLabelGestures()
    }
    
    override func loadView() {
        super.loadView()
        view = gesturesView
    }
}

private extension GesturesViewController {
    // MARK: - Configuration methods
    func setUpCardAnimation() {
        guard let swiftView = gesturesView.swiftView,
        let gameControllerView = gesturesView.gameControllerView else { return }
        
        swiftView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        gameControllerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
        sendToBack(view: gameControllerView)
    }
    
    // MARK: - Helper methods
    /** This methods are used to handle specific behaviour for the example.
     If you need to use those animations, you would need to handle this methods
     depending on the feature you want to address
     */
    
    func getOtherView(view: UIView) -> UIView {
        if view.isEqual(gesturesView.swiftView) {
            return gesturesView.gameControllerView
        } else {
            return gesturesView.swiftView
        }
    }
    
    func changeGestureRecognizers(panView: UIView, tapView: UIView) {
        panView.gestureRecognizers?.forEach { panView.removeGestureRecognizer($0) }
        tapView.gestureRecognizers?.forEach { tapView.removeGestureRecognizer($0) }
        
        tapView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        panView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
    }
    
    func reset(view: UIView) {
        let halfWidthScreen = gesturesView.cardsContainerView.bounds.width / 2.0
        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transformIdentity()
            .startAnimation()
    }
}

// MARK: - Animation methods
private extension GesturesViewController {
    /**
     Animate the view when the user is draging it to the right
     
     - Parameter gesture: Gesture recognizer that generates the event
     
     - Note:
        - Rotates the view using the angle provided (0.2618 here)
        - Updates view's position while the user is dragging it
        - If the movement exceed the specified limit (***) sends the view to the back of all subviews
     
     */
    @objc func dragView(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        let halfWidthScreen = gesturesView.cardsContainerView.bounds.width / 2.0
        let screenWidth = gesturesView.cardsContainerView.bounds.width
        let completeAnimationLimit = screenWidth - 50
        let swapViewsLimit = halfWidthScreen + 75
        
        switch gesture.state {
        case .began:
            rotationAnimator = UIViewPropertyAnimator(duration: 4, curve: .easeInOut) {
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
    
    /**
     Brings the selected view to the top
     
     - Parameter gesture: Gesture recognizer that generates the event
     
     - Note: Uses bringToTop(view:) to set the tapped view at the begining of all subviews
    
     - Important: If you need to use more views, you need to change bringToBack(view:) because here are being used just 2 views
     
     */
    @objc func tapView(gesture: UITapGestureRecognizer) {
        let target = gesture.view!
        bringToTop(view: target)
        let otherView = getOtherView(view: target)
        sendToBack(view: otherView)
        changeGestureRecognizers(panView: otherView, tapView: target)
    }
    
    /**
     Uses a mixed animation to put the view at the start of subview's array.
     
     - Parameter view : view that is going to be send to top
     
     - Note: Is created a mix for the following transformations:
        - Set the view in the middle of the container
        - Make the view bigget (scalling x **)
        - Set the view at the start of all subviews
     */
    func bringToTop(view: UIView) {
        let halfWidthScreen = gesturesView.cardsContainerView.bounds.width / 2.0
        view
            .mixedAnimation(withDuration: 0.25)
            .action(positionX: halfWidthScreen, positionY: view.center.y)
            .transform(scaleX: 1, scaleY: 1)
            .action(alpha: 1)
            .action(moveTo: .front)
            .startAnimation()
    }
    
    /**
     Uses a mixed animation to put the view at the end of subview's array.
     
     - Parameter view: view that is going to be send to back
     
     - Note: Is created a mix of the following transformations:
        - Set the view in the middle of the container
        - Make the view smaller (scalling x ***)
        - Set the view at the end of all subviews
        - Move the view up (translate in Y position)
     */
    func sendToBack(view: UIView) {
        let halfWidthScreen = gesturesView.cardsContainerView.bounds.width / 2.0
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

extension GesturesViewController {
    func setupScreenGestures() {
        gesturesView.addScreenEdgePanGestureRecognizer(edge: .left) { _ in
            print("Edge panned!")
        }
    }
    
    func setupLabelGestures() {
        gesturesView.gestureLabel.addTapGestureRecognizer(numberOfTapsRequired: 1) { [weak self] _ in
            self?.gesturesView.gestureLabel.shake(withDuration: 0.05)
            print("Label tapped!")
        }
        gesturesView.gestureLabel.addLongPressGestureRecognizer(minimumPressDuration: 1.0) { _ in
            print("Label long pressed!")
        }
        gesturesView.gestureLabel.addPinchGestureRecognizer { _ in
            print("Label pinched!")
        }
        gesturesView.gestureLabel.addRotationGestureRecognizer { _ in
            print("Label rotated!")
        }
        gesturesView.gestureLabel.addPanGestureRecognizer { _ in
            print("Label panned!")
        }
        gesturesView.gestureLabel.addSwipeGestureRecognizer(direction: .left) { _ in
            print("Label swiped!")
        }
    }
}
