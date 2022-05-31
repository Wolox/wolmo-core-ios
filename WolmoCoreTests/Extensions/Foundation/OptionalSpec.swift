//
//  Optional.swift
//  WolmoCoreTests
//
//  Created by juan.martin.gordo on 31/05/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import Foundation
import Nimble
import Quick
import WolmoCore

public class OptionalSpec: QuickSpec {
    override public func spec() {
        describe("isNilOrEmpty") {
            it("should return true when collection is empty") {
                let array: [Any]? = []
                expect(array.isNilOrEmpty).to(beTrue())
            }
            it("should return true when collection is nil") {
                let array: [Any]? = nil
                expect(array.isNilOrEmpty).to(beTrue())
            }
            it("should return false when collection is not empty or nil") {
                let array: [Any]? = [0]
                expect(array.isNilOrEmpty).to(beFalse())
            }
        }
    }
}
