//
//  ScreenEdgePanRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 26/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class ScreenEdgePanRecognizerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#addScreenEdgePanGestureRecognizer(Action:)") {
            
            var view: UIView!
            
            context("when addScreenEdgePanGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addScreenEdgePanGestureRecognizer(edge: .left) { recognizer in
                        // No action
                    }
                }
                
                it("should have injected a UIScreenEdgePanGestureRecognizer into the view") {
                    let screenEdgePanRecognizer = view.gestureRecognizers?.first as? UIScreenEdgePanGestureRecognizer
                    expect(screenEdgePanRecognizer).toNot(beNil())
                }
            }
        }
    }
}
