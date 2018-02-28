//
//  ArraySpec.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class ArraySpec: QuickSpec {

    override public func spec() {

        describe("#group(by:)") {

            it("should group the array based on condition") {

                let array = [1, 1, 2, 4, 6]
                let grouped = array.group(by: { (elem) -> String in
                    String(elem)
                })

                expect(grouped.count).to(equal(4))

                expect(grouped["1"]).to(equal([1, 1]))
                expect(grouped["2"]).to(equal([2]))
                expect(grouped["4"]).to(equal([4]))
                expect(grouped["6"]).to(equal([6]))
                expect(grouped["7"]).to(beNil())

            }
        }

        describe("#appending") {

            let base = [1, 2, 3]

            it("should return a new array appending the new value") {
                expect(base.appending(4)).to(equal([1, 2, 3, 4]))
            }

            it("should not mutate the base array") {
                _ = base.appending(5)
                expect(base).to(equal([1, 2, 3]))
            }

        }

        describe("#get") {

            let array = [1, 2, 6]

            context("When the array contains indexth element") {

                it("returns that element") {
                    expect(array.get(0)).to(equal(1))
                    expect(array.get(1)).to(equal(2))
                    expect(array.get(2)).to(equal(6))
                }

            }

            context("When the array doesn't contain the indexth element") {

                it("returns nil") {
                    expect(array.get(-1)).to(beNil())
                    expect(array.get(3)).to(beNil())
                }

            }

        }

    }
}
