//
//  ViewController+SimpleAnimations.swift
//  WolmoCoreDemo
//
//  Created by Daniela Riesgo on 30/08/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Simple animations
enum SimpleExample: Int {
    case simple = 0
    case chain
    case chained
    case chainedDifferentTypes
    case transformRotateAndScale
    case transformTranslateAndScaleSimple
    case transformTranslateAndScaleMixed
    case transformRotateAndActionScale
    case transformScaleAndActionTranslate

    static var all: [SimpleExample] {
        return [
            .simple, .chain, .chained, .chainedDifferentTypes,
            .transformRotateAndScale,
            .transformTranslateAndScaleSimple, .transformTranslateAndScaleMixed,
            .transformRotateAndActionScale, .transformScaleAndActionTranslate
        ]
    }

    var name: String {
        switch self {
        case .simple:
            return "Improved - Action and Transform - Simple"
        case .chain:
            return "Normal"
        case .chained:
            return "Improved - Action and Transform - Chain of Mixed - Loop"
        case .chainedDifferentTypes:
            return "Improved - Action and Transform - Chain of Simple and Mixed - Not loop"
        case .transformRotateAndScale:
            return "FAULTY - Normal and Improved - Action and Transform - Mixed"
        case .transformTranslateAndScaleSimple:
            return "FAULTY - Improved - Transform - Simple"
        case .transformTranslateAndScaleMixed:
            return "FAULTY - Improved - Transform - Chain of Mixed - Loop"
        case .transformRotateAndActionScale:
            return "Improved - Transform - Mixed"
        case .transformScaleAndActionTranslate:
            return "Improved - Action and Transform - Chain of Mixed - Loop"
        }
    }
}

extension ViewController {

    func setupSimpleAnimations() {
        for each in SimpleExample.all {
            let view = createNewRedView()
            animationViews.append(view)
            view.isHidden = true

            if each.rawValue < segmentedControl.numberOfSegments {
                segmentedControl.setTitle(each.name, forSegmentAt: each.rawValue)
            } else {
                segmentedControl.insertSegment(withTitle: each.name, at: each.rawValue, animated: false)
            }
        }
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    @objc
    private func segmentedControlValueChanged() {
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

    private func setupAnimation(_ animation: SimpleExample, view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func setupSimpleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.simpleAnimation()
            .action(withDuration: 2, translateX: 50, translateY: 100)
            .action(withDuration: 1, alpha: 0.5)
            .transform(withDuration: 2, rotationAngle: 45)

        return (coreAnimation: animation, normalAnimation: .none)
    }

    //swiftlint:disable:next function_body_length
    private func setupChainAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func setupChainedAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func setupChainedDifferentTypesAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func setupTransformRotateAndScaleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func setupTransformTranslateAndScaleSimpleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.simpleAnimation()
            .transform(withDuration: 1, translationX: 100, translationY: 0)
            .transform(withDuration: 1, translationX: 100, translationY: -100)
            .transform(withDuration: 1, scaleX: 2, scaleY: 2)
            .transform(withDuration: 1, translationX: 0, translationY: -100)
            .transform(withDuration: 1, translationX: 0, translationY: 0)
            .transform(withDuration: 1, scaleX: 1, scaleY: 1)

        return (coreAnimation: animation, normalAnimation: .none)
    }

    private func setupTransformTranslateAndScaleMixedAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func setupTransformRotateAndActionScaleAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
        let animation = view.mixedAnimation(withDuration: 2)
            .transform(rotationAngle: 45)
            .transform(scaleX: 5, scaleY: 5)

        return (coreAnimation: animation, normalAnimation: .none)
    }

    private func setupTransformScaleAndActionTranslateAnimation(_ view: UIView) -> (coreAnimation: AnimationType?, normalAnimation: (() -> Void)?) {
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

    private func createNewRedView() -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        redContainerView.addSubview(view)
        NSLayoutConstraint.activate([
            redContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 50),
            view.heightAnchor.constraint(equalToConstant: 50)
            ])

        return view
    }

    private func resetView(_ view: UIView) {
        view.backgroundColor = .red
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.center = redContainerView.center
        view.bounds.size.width = 50
        view.bounds.size.height = 50
        view.transform = .identity
    }

}
