//
//  TapRecognizerSpec.swift
//  WolmoCoreTests
//
//  Created by Gabriel Mazzei on 17/12/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

public class TapRecognizerSpec: QuickSpec {
    override public func spec() {
        describe("#addTapGestureRecognizer(Action:)") {
            var view: UIView!
            
            context("when addTapGestureRecognizer has been called") {
                beforeEach {
                    view = UIView()
                    view.addTapGestureRecognizer { recognizer in
                        // No action
                    }
                }
                it("should have injected a UITapGestureRecognizer into the view") {
                    let tapRecognizer = view.gestureRecognizers?.first as? UITapGestureRecognizer
                    expect(tapRecognizer).toNot(beNil())
                }
            }
        }
    }
}
