//
//  AnimationsViewController.swift
//  AnimationDemo
//
//  Created by Argentino Ducret on 23/01/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class AnimationsViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var draggableView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var animationViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        
        setupSimpleAnimations()
        configureDraggableView()
    }
}

// MARK: - Configuration methods
private extension AnimationsViewController {
    func setupSimpleAnimations() {
        for each in SimpleExample.all {
            let view = createNewRedView()
            animationViews.append(view)

            if each.rawValue < segmentedControl.numberOfSegments {
                segmentedControl.setTitle(each.name, forSegmentAt: each.rawValue)
            } else {
                segmentedControl.insertSegment(withTitle: each.name, at: each.rawValue, animated: false)
            }
        }
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.addShadow(opacity: 0.2)
    }
    
    func configureDraggableView() {
        draggableView.isDraggable(returnToPosition: true) { view in
            view.backgroundColor = .init(named: "EerieBlack")
        } onDragFinished: { view in
            view.backgroundColor = .init(named: "deepSaffron")
        }

        draggableView.backgroundColor = .init(named: "deepSaffron")
        draggableView.layer.masksToBounds = true
        draggableView.addShadow(cornerRadius: 20)
    }
    
    /**
     Gets the AnimationType and animation closure to execute.
     - Each AnimationType has an `startAnimation(completion:)` that executes the specified animations depending on it's type
     - normalAnimation are example of animations without using WolmoCore Animations
     */
    @objc func segmentedControlValueChanged() {
        let newAnimationIndex = segmentedControl.selectedSegmentIndex
        for animation in SimpleExample.all {
            animationViews[animation.rawValue].isHidden = true
        }
        let view = animationViews[newAnimationIndex]
        resetView(view)
        view.isHidden = false
        let (animation, normalAnimation) = setupAnimation(SimpleExample(rawValue: newAnimationIndex)!, view: view)
        animation?.startAnimation(completion: .none)
        normalAnimation?()
    }
    
    func setupAnimation(_ animation: SimpleExample, view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        switch animation {
        case .simple: return setupSimpleAnimation(view)
        case .chain: return setupChainAnimation(view)
        case .chained: return setupChainedAnimation(view)
        case .chainedDifferentTypes: return setupChainedDifferentTypesAnimation(view)
        case .transformRotateAndScale: return setupTransformRotateAndScaleAnimation(view)
        case .transformTranslateAndScaleSimple: return setupTransformTranslateAndScaleSimpleAnimation(view)
        case .transformTranslateAndScaleMixed: return setupTransformTranslateAndScaleMixedAnimation(view)
        case .transformRotateAndActionScale: return setupTransformRotateAndActionScaleAnimation(view)
        case .transformScaleAndActionTranslate: return setupTransformScaleAndActionTranslateAnimation(view)
        }
    }
    
    func resetView(_ view: UIView) {
        view.backgroundColor = .init(named: "deepSaffron")
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.center = containerView.center
        view.bounds.size.width = 50
        view.bounds.size.height = 50
        view.transform = .identity
    }
    
    func createNewRedView() -> UIView {
        let view = UIView()
        view.backgroundColor = .init(named: "deepSaffron")
        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(view)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 50),
            view.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        return view
    }
}

// MARK: - Animation methods
private extension AnimationsViewController {
    /**
     Creates a simple animation, adding each action after the previous one is completed
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a SimpleAnimation an none normalAnimation
     
     - Note:
        - Translate the view to a new position
        - Change view's alpha
        - Rotate the view (45°)
     
     */
    func setupSimpleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.simpleAnimation()
            .action(withDuration: 2, translateX: 50, translateY: 100)
            .action(withDuration: 1, alpha: 0.5)
            .transform(withDuration: 2, rotationAngle: 45)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
    
    /**
     Creates a normal animation of a chain of transformations, adding each one after the previous one is completed
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has none AnimationType and one normal animation
     
     */
    func setupChainAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation: () -> Void = {
            UIView.animate(withDuration: 2.0, animations: {
                view.frame = CGRect(x: view.frame.origin.x + 50,
                                    y: view.frame.origin.y,
                                    width: view.frame.width,
                                    height: view.frame.height)
                view.alpha = 0.5
                
                view.frame = CGRect(x: view.frame.origin.x - view.frame.width / 2,
                                    y: view.frame.origin.y - view.frame.height / 2,
                                    width: view.frame.width * 2,
                                    height: view.frame.height * 2)
            }, completion: { _ in
                UIView.animate(withDuration: 2.0) {
                    view.frame = CGRect(x: view.frame.origin.x - 50,
                                        y: view.frame.origin.y,
                                        width: view.frame.width,
                                        height: view.frame.height)
                    view.alpha = 1
                    
                    view.frame = CGRect(x: view.frame.origin.x - view.frame.width / 2,
                                        y: view.frame.origin.y - view.frame.height / 2,
                                        width: view.frame.width / 2,
                                        height: view.frame.height / 2)
                }
            })
        }
        
        return (coreAnimation: .none, normalAnimation: animation)
    }
    
    /**
     Creates 2 different mixed animations and set them in a single chained animation that executes one after the previous one is completed, and repeats them in a loop
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a ChainedAnimation and none normal animation
     
     */
    func setupChainedAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation1 = view.mixedAnimation(withDuration: 1)
            .action(translateX: 0, translateY: 100)
            .action(alpha: 0.5)
            .transform(rotationAngle: 45)
            .transform(scaleX: 2.0, scaleY: 2.0)
        let animation2 = view.mixedAnimation(withDuration: 3)
            .action(translateX: 0, translateY: -100)
            .action(alpha: 1)
            .transform(rotationAngle: 0)
            .transform(scaleX: 1, scaleY: 1)
        let animation = view.chainedAnimation(loop: true)
            .add(animation: animation1)
            .add(animation: animation2)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
    
    /**
     Creates a SimpleAnimation and a MixedAnimation and sets them in a single chained animation that executes one after the previous one is completed, without repeating them
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a ChainedAnimation and none normal animation
     */
    func setupChainedDifferentTypesAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let a1 = view.simpleAnimation()
            .action(withDuration: 2, translateX: 50, translateY: 100)
            .transform(withDuration: 1, scaleX: 2, scaleY: 2)
        let a2 = view.mixedAnimation(withDuration: 3)
            .action(translateX: 50, translateY: 0)
            .transform(rotationAngle: 45)
            .action(alpha: 0.5)
        
        let animation = view.chainedAnimation(loop: false)
            .add(animation: a1)
            .add(animation: a2)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
    
    /**
     Creates a MixedAnimation that scals the view and and a normal animation
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a ChainedAnimation and a normal animation
     */
    func setupTransformRotateAndScaleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.mixedAnimation(withDuration: 2)
            .action(scaleX: 5, scaleY: 5)
            .transform(rotationAngle: 45)
        
        let normalAnimation: () -> Void = {
            UIView.animate(withDuration: 2) {
                let angleInRadians = (45 * CGFloat.pi) / 180.0
                view.transform = CGAffineTransform(rotationAngle: angleInRadians)
                let center = view.center
                view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width * 5, height: view.frame.height * 5)
                view.center = center
            }
        }
        
        return (coreAnimation: animation, normalAnimation: normalAnimation)
    }
    
    /**
     Creates a SimpleAnimation that adds some transformation to the view
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a SimpleAnimation and none normal animation
     */
    func setupTransformTranslateAndScaleSimpleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.simpleAnimation()
            .transform(withDuration: 1, translationX: 100, translationY: 0)
            .transform(withDuration: 1, translationX: 100, translationY: -100)
            .transform(withDuration: 1, scaleX: 2, scaleY: 2)
            .transform(withDuration: 1, translationX: 0, translationY: -100)
            .transform(withDuration: 1, translationX: 0, translationY: 0)
            .transform(withDuration: 1, scaleX: 1, scaleY: 1)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
    
    /**
     Creates four MixedAnimations and sets them in a single ChainedAnimation that executes one after the previous one is completed, repeating them
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a SimpleAnimation and none normal animation
     */
    func setupTransformTranslateAndScaleMixedAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let a1 = view.mixedAnimation(withDuration: 1)
            .transform(translationX: 50, translationY: 0)
        let a2 = view.mixedAnimation(withDuration: 1)
            .transform(translationX: 50, translationY: -50)
            .transform(scaleX: 2, scaleY: 2)
        let a3 = view.mixedAnimation(withDuration: 1)
            .transform(translationX: 0, translationY: -50)
        let a4 = view.mixedAnimation(withDuration: 1)
            .transform(translationX: 0, translationY: 0)
            .transform(scaleX: 1, scaleY: 1)
        
        let animation = view.chainedAnimation(loop: true)
            .add(animation: a1)
            .add(animation: a2)
            .add(animation: a3)
            .add(animation: a4)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
    
    /**
     Creates a MixedAnimation that rotates and scales the view
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a MixedAnimation and none normal animation

     */
    func setupTransformRotateAndActionScaleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.mixedAnimation(withDuration: 2)
            .transform(rotationAngle: 45)
            .transform(scaleX: 5, scaleY: 5)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
    
    /**
     Creates four MixedAnimations and sets them in a single ChainedAnimation that executes one after the previous one is completed, repeating them
     
     - Parameter view: view to be animated
     
     - Returns: tuple that has a SimpleAnimation and none normal animation

     */
    func setupTransformScaleAndActionTranslateAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let a1 = view.mixedAnimation(withDuration: 1)
            .action(translateX: 100, translateY: 0)
        
        let a2 = view.mixedAnimation(withDuration: 1)
            .action(translateX: 0, translateY: -100)
            .transform(scaleX: 2, scaleY: 2)
        
        let a3 = view.mixedAnimation(withDuration: 1)
            .action(translateX: -100, translateY: 0)
        
        let a4 = view.mixedAnimation(withDuration: 1)
            .action(translateX: 0, translateY: 100)
            .transform(scaleX: 0.5, scaleY: 0.5)
        
        let animation = view.chainedAnimation(loop: true)
            .add(animation: a1)
            .add(animation: a2)
            .add(animation: a3)
            .add(animation: a4)
        
        return (coreAnimation: animation, normalAnimation: .none)
    }
}
