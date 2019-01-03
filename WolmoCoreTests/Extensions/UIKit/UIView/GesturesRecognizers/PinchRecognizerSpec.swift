//
//  PinchRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 21/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class PinchRecognizerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#addPinchGestureRecognizer(Action:)") {
            
            var view: UIView!
            
            context("when addPinchGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addPinchGestureRecognizer { /* No action */ }
                }
                
                it("should have injected a UIPinchGestureRecognizer into the view") {
                    let pinchRecognizer = view.gestureRecognizers?.first as? UIPinchGestureRecognizer
                    expect(pinchRecognizer).toNot(beNil())
                }
            }
        }
    }
}
