//
//  DictionarySpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 3/22/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

public class DictionarySpec: QuickSpec {
    override public func spec() {
        describe("castedValue(forKey:or:)") {
            var dict1: [Int: Any]!

            beforeEach {
                dict1 = [1: "one", 2: 2, 3: [",", ".", ":"]]
            }

            context("when the key is already in the dictionary") {
                context("when the key's value's type is not T") {
                    it("should raise a runtime error") {
                        expect(_ = dict1.castedValue(forKey: 2, or: "two")).to(throwAssertion())
                    }
                }
                context("when the key's value's type is T") {
                    it("should return the key's value") {
                        let value = dict1.castedValue(forKey: 1, or: "uno")
                        expect(value).to(equal("one"))
                    }
                }
            }
            context("when the key is not in the dictionary") {
                it("should return the default value") {
                    let value = dict1.castedValue(forKey: 5, or: ["español": "cinco"])
                    expect(value).to(equal(["español": "cinco"]))
                }
            }
        }
    }
}
