//
//  LongPressRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 21/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class LongPressRecognizerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#addLongPressGestureRecognizer(Action:)") {
            
            var view: UIView!
            
            context("when addLongPressGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addLongPressGestureRecognizer { recognizer in
                        // No action
                    }
                }
                
                it("should have injected a UILongPressGestureRecognizer into the view") {
                    let longPressRecognizer = view.gestureRecognizers?.first as? UILongPressGestureRecognizer
                    expect(longPressRecognizer).toNot(beNil())
                }
            }
        }
    }
}

