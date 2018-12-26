//
//  SwipeRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 26/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class SwipeRecognizerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#addSwipeGestureRecognizer(Action:)") {
            
            var view: UIView!
            
            context("when addSwipeGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addSwipeGestureRecognizer { recognizer in
                        // No action
                    }
                }
                
                it("should have injected a UISwipeGestureRecognizer into the view") {
                    let swipeRecognizer = view.gestureRecognizers?.first as? UISwipeGestureRecognizer
                    expect(swipeRecognizer).toNot(beNil())
                }
            }
        }
    }
}

