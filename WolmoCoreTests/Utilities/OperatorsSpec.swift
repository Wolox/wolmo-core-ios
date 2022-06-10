//
//  OperatorsSpec.swift
//  WolmoCoreTests
//
//  Created by juan.martin.gordo on 04/02/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import Quick
import Nimble

infix operator ^^

func ^^ (lhs: Bool, rhs: Bool) -> Bool {
    return lhs != rhs
}

public class OperatorsSpec: QuickSpec {
    override public func spec() {
        let truth = true
        let falsehood = false
        describe("^^") {
            context("when comparing two opposite boolean values") {
                it("should return true") {
                    expect(truth^^falsehood).to(beTrue())
                    expect(truth^^truth).to(beFalse())
                }
            }
            context("when comparing two equal boolean values") {
                it("should return false") {
                    expect(falsehood^^truth).to(beTrue())
                    expect(falsehood^^falsehood).to(beFalse())
                }
            }
        }
    }
}
