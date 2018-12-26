//
//  RotationRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 26/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class RotationRecognizerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#addRotationGestureRecognizer(Action:)") {
            
            var view: UIView!
            
            context("when addRotationGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addRotationGestureRecognizer { recognizer in
                        // No action
                    }
                }
                
                it("should have injected a UIRotationGestureRecognizer into the view") {
                    let rotationRecognizer = view.gestureRecognizers?.first as? UIRotationGestureRecognizer
                    expect(rotationRecognizer).toNot(beNil())
                }
            }
        }
    }
}

