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

    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var redView: UIView!
    
    var rotationAnimator: UIViewPropertyAnimator!
    
    var lastTranslation = CGPoint.zero
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // CARDS:
        greenView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        yellowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
        sendToBack(view: yellowView)
        
        // HIDE CARDS:
//        greenView.isHidden = true
//        yellowView.isHidden = true
        
        // HIDE RED VIEW
        redView.isHidden = true
        
        // CHAIN EXAMPLE:
        
//        UIView.animate(withDuration: 2.0, animations: {
//            self.redView.frame = CGRect(x: self.redView.frame.origin.x + 50,
//                                        y: self.redView.frame.origin.y,
//                                        width: self.redView.frame.width,
//                                        height: self.redView.frame.height)
//            self.redView.alpha = 0.5
//
//            self.redView.frame = CGRect(x: self.redView.frame.origin.x - self.redView.frame.width / 2,
//                                        y: self.redView.frame.origin.y - self.redView.frame.height / 2,
//                                        width: self.redView.frame.width * 2,
//                                        height: self.redView.frame.height * 2)
//        }) { _ in
//            UIView.animate(withDuration: 2.0) {
//                self.redView.frame = CGRect(x: self.redView.frame.origin.x - 50,
//                                            y: self.redView.frame.origin.y,
//                                            width: self.redView.frame.width,
//                                            height: self.redView.frame.height)
//                self.redView.alpha = 1
//
//                self.redView.frame = CGRect(x: self.redView.frame.origin.x - self.redView.frame.width / 2,
//                                            y: self.redView.frame.origin.y - self.redView.frame.height / 2,
//                                            width: self.redView.frame.width / 2,
//                                            height: self.redView.frame.height / 2)
//            }
//        }
        
        // CHAINED ANIMATION
        
//        let animation1 = redView.mixedAnimation(withDuration: 1)
//            .action(translateX: 0, translateY: 100)
//            .action(alpha: 0.5)
//            .transform(rotationAngle: 45)
//            .transform(scaleX: 2.0, scaleY: 2.0)
//
//        let animation2 = redView.mixedAnimation(withDuration: 3)
//            .action(translateX: 0, translateY: -100)
//            .action(alpha: 1)
//            .transform(rotationAngle: 0)
//            .transform(scaleX: 1, scaleY: 1)
//
//        redView.chainedAnimation(loop: true)
//            .add(animation: animation1)
//            .add(animation: animation2)
//            .startAnimation()

        // SIMPLE ANIMATION
        
//        redView.simpleAnimation()
//            .action(withDuration: 2, translateX: 50, translateY: 100)
//            .action(withDuration: 1, alpha: 0.5)
//            .transform(withDuration: 2, rotationAngle: 45)
//            .startAnimation()
        
        // CHAINED ANIMATION WITH TWO TYPES OF ANIMATIONS
        
//        let animation1 = redView.simpleAnimation()
//            .action(withDuration: 2, translateX: 50, translateY: 100)
//            .transform(withDuration: 1, scaleX: 2, scaleY: 2)
//
//        let animation2 = redView.mixedAnimation(withDuration: 3)
//            .action(translateX: 50, translateY: 0)
//            .transform(rotationAngle: 45)
//            .action(alpha: 0.5)
//
//        redView.chainedAnimation(loop: false)
//            .add(animation: animation1)
//            .add(animation: animation2)
//            .startAnimation()
        
        // TRANSFORM ROTATE + ACTION SCALE
        
//        redView.mixedAnimation(withDuration: 2)
//            .action(scaleX: 5, scaleY: 5)
//            .transform(rotationAngle: 45)
//            .startAnimation()
        
//        UIView.animate(withDuration: 2) {
//            let angleInRadians = (45 * CGFloat.pi) / 180.0;
//            self.redView.transform = CGAffineTransform(rotationAngle: angleInRadians)
//            let center = self.redView.center
//            self.redView.frame = CGRect(x: self.redView.frame.origin.x, y: self.redView.frame.origin.y, width: self.redView.frame.width * 5, height: self.redView.frame.height * 5)
//            self.redView.center = center
//        }
        
        // TRANSFORM ROTATE + TRANSFORM SCALE
        
//        redView.mixedAnimation(withDuration: 2)
//            .transform(rotationAngle: 45)
//            .transform(scaleX: 5, scaleY: 5)
//            .startAnimation()

        // TRANSFORM TRANSLATE + TRANSFORM SCALE (SIMPLE ANIMATION)
        
//        redView.simpleAnimation()
//            .transform(withDuration: 1, translationX: 100, translationY: 0)
//            .transform(withDuration: 1, translationX: 100, translationY: -100)
//            .transform(withDuration: 1, scaleX: 2, scaleY: 2)
//            .transform(withDuration: 1, translationX: 0, translationY: -100)
//            .transform(withDuration: 1, translationX: 0, translationY: 0)
//            .transform(withDuration: 1, scaleX: 1, scaleY: 1)
//            .startAnimation()
        
        // TRANSFORM TRANSLATE + TRANSFORM SCALE (MIXED ANIMATION)
        
//        let a1 = redView.mixedAnimation(withDuration: 1)
//            .transform(translationX: 50, translationY: 0)
//
//        let a2 = redView.mixedAnimation(withDuration: 1)
//            .transform(translationX: 50, translationY: -50)
//            .transform(scaleX: 2, scaleY: 2)
//
//        let a3 = redView.mixedAnimation(withDuration: 1)
//            .transform(translationX: 0, translationY: -50)
//
//        let a4 = redView.mixedAnimation(withDuration: 1)
//            .transform(translationX: 0, translationY: 0)
//            .transform(scaleX: 1, scaleY: 1)
//
//        redView.chainedAnimation(loop: true)
//            .add(animation: a1)
//            .add(animation: a2)
//            .add(animation: a3)
//            .add(animation: a4)
//            .startAnimation()
        
        // TRANSFORM SCALE + ACTION TRANSLATE
        
//        let a1 = redView.mixedAnimation(withDuration: 1)
//            .action(translateX: 100, translateY: 0)
//
//        let a2 = redView.mixedAnimation(withDuration: 1)
//            .action(translateX: 0, translateY: -100)
//            .transform(scaleX: 2, scaleY: 2)
//
//        let a3 = redView.mixedAnimation(withDuration: 1)
//            .action(translateX: -100, translateY: 0)
//
//        let a4 = redView.mixedAnimation(withDuration: 1)
//            .action(translateX: 0, translateY: 100)
//            .transform(scaleX: 0.5, scaleY: 0.5)
//
//        redView.chainedAnimation(loop: true)
//            .add(animation: a1)
//            .add(animation: a2)
//            .add(animation: a3)
//            .add(animation: a4)
//            .startAnimation()
        
    }
    
    @objc // swiftlint:disable:next function_body_length
    func dragView(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        let halfWidthScreen = UIScreen.main.bounds.width / 2.0
        let screenWidth = UIScreen.main.bounds.width
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
        let halfWidthScreen = UIScreen.main.bounds.width / 2.0
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
        let halfWidthScreen = UIScreen.main.bounds.width / 2.0
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
        let halfWidthScreen = UIScreen.main.bounds.width / 2.0
    
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
