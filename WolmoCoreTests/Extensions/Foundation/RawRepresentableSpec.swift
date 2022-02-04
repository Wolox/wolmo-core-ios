//
//  RawRepresentable.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

private enum IntRepresentable: Int {
    case zero
    case one
    case two
    case three
}

public class RawRepresentableSpec: QuickSpec {
    override public func spec() {
        describe("#allValues") {
            context("When specifying an existent initial value") {
                it("should return all values starting at the initial value") {
                    let values = Array(IntRepresentable.allValues(startingAt: .one))
                    expect(values).to(equal([.one, .two, .three]))
                }
                
                context("When the value is the first one") {
                    it("should return all values") {
                        let values = Array(IntRepresentable.allValues(startingAt: .zero))
                        expect(values).to(equal([.zero, .one, .two, .three]))
                    }
                }
                context("When the value is the last one") {
                    it("should return the last value") {
                        let values = Array(IntRepresentable.allValues(startingAt: .three))
                        expect(values).to(equal([.three]))
                    }
                }
            }
        }
        
        describe("#count") {
            context("When specifying an initial value") {
                it("should return the count of all the values starting at the initial value") {
                    expect(IntRepresentable.count(startingAt: .one)).to(equal(3))
                }
                context("When the value is the first one") {
                    it("should return the count of all the values") {
                        expect(IntRepresentable.count(startingAt: .zero)).to(equal(4))
                    }
                }
                context("When the value is the last one") {
                    it("should return one") {
                        expect(IntRepresentable.count(startingAt: .three)).to(equal(1))
                    }
                }
            }
        }
    }
}

public class RawRepresentableGeneratorSpec: QuickSpec {
    override public func spec() {
        var generator: RawRepresentableGenerator<Int, IntRepresentable>!
        
        beforeEach {
            generator = RawRepresentableGenerator(startingAt: .zero) { $0 }
        }
        
        describe("#next") {
            context("When using the identity function as generator") {
                it("should return always the same element") {
                    expect(generator.next()).to(equal(IntRepresentable.zero))
                    expect(generator.next()).to(equal(IntRepresentable.zero))
                }
            }
            context("When adding one in the generator") {
                beforeEach {
                    generator = RawRepresentableGenerator(startingAt: .zero) { IntRepresentable(rawValue: $0.rawValue + 1) }
                }
                
                it("should return the following element until there is no following") {
                    expect(generator.next()).to(equal(IntRepresentable.zero))
                    expect(generator.next()).to(equal(IntRepresentable.one))
                    expect(generator.next()).to(equal(IntRepresentable.two))
                    expect(generator.next()).to(equal(IntRepresentable.three))
                    expect(generator.next()).to(beNil())
                    expect(generator.next()).to(beNil())
                }
            }
        }
    }
}
