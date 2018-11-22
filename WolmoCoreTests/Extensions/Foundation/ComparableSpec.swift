//
//  ComparableSpec.swift
//  WolmoCoreTests
//
//  Created by Diego Quiros on 11/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class ComparableSpec: QuickSpec {
    
    override public func spec() {

        describe("#clamp(min:,max:)") {
            
            let min = 3
            let max = 6
            
            context("when the number is higher than the interval") {
                
                let testNumber = 8
                
                it("should return the max number of the interval") {
                    let expectedNumber = 6
                    expect(testNumber.clamp(min: min, max: max)).to(equal(expectedNumber))
                }
            }
            
            context("when the number is lower than the interval") {
                
                let testNumber = 2
                
                it("should return the min number of the interval") {
                    let expectedNumber = 3
                    expect(testNumber.clamp(min: min, max: max)).to(equal(expectedNumber))
                }
            }
            
            context("when the number is contained in the interval") {
                
                let testNumber = 5
                
                it("should return the same number") {
                    let expectedNumber = 5
                    expect(testNumber.clamp(min: min, max: max)).to(equal(expectedNumber))
                }
            }
        }
    }
}
