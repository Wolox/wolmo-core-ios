//
//  CardsViewController.swift
//  AnimationDemo
//
//  Created by Carolina Arcos on 5/3/19.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class CardsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var cardsContainerView: UIView!
    
    var rotationAnimator: UIViewPropertyAnimator!
    var lastTranslation = CGPoint.zero
    
    var animationViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCardAnimation()
    }
}

private extension CardsViewController {
    func setUpCardAnimation() {
        greenView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        yellowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
//        sendToBack(view: yellowView)
    }
    
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
//                sendToBack(view: target)
//                let otherView = getOtherView(view: target)
//                bringToTop(view: otherView)
//                changeGestureRecognizers(panView: target, tapView: otherView)
            } else {
//                reset(view: target)
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
//        bringToTop(view: target)
//        let otherView = getOtherView(view: target)
//        sendToBack(view: otherView)
//        changeGestureRecognizers(panView: otherView, tapView: target)
    }
    
}
