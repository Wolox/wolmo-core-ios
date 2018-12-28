//
//  PanRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 26/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class PanRecognizerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#addPanGestureRecognizer(Action:)") {
            
            var view: UIView!
            
            context("when addPanGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addPanGestureRecognizer { recognizer in
                        // No action
                    }
                }
                
                it("should have injected a UIPanGestureRecognizer into the view") {
                    let panRecognizer = view.gestureRecognizers?.first as? UIPanGestureRecognizer
                    expect(panRecognizer).toNot(beNil())
                }
            }
        }
    }
}
