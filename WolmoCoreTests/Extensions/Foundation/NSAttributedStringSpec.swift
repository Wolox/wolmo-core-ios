//
//  NSAttributedStringSpec.swift
//  WolmoCoreTests
//
//  Created by juan.martin.gordo on 05/01/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

public class NSAttributedStringSpec: QuickSpec {
    override public func spec() {
        let font: UIFont = .appFont(for: .body)
        let attributes = [NSAttributedString.Key.font: font]
        
        let testNSString = NSAttributedString(string: "String", attributes: attributes)
        let testString = "String"
                
        let emptyNSString = NSAttributedString(string: "", attributes: attributes)
        let emptyString = ""
        
        describe("#append(superscript:percentageSize:)") {
            context("when applying on an empty string") {
                it("should stop execution") {
                    expect(emptyNSString.append(superscript: testString)).to(throwAssertion())
                }
            }
            
            context("when appending an empty string") {
                it("should return the unaltered string") {
                    expect(testNSString.append(superscript: emptyString)).to(equal(testNSString))
                }
            }
            
            context("when applying on a string") {
                it("should return a new string with the appended superscript") {
                    let result = testNSString.append(superscript: testString)
                    let expected: String = testNSString.string + testString
                    expect(result.string).to(equal(expected))
                }
            }
            
            context("when applying an incorrect percentage size value") {
                it("should stop execution") {
                    expect(testNSString.append(superscript: testString, percentageSize: 2)).to(throwAssertion())
                }
            }
        }
        
        describe("#append(subscript:percentageSize:)") {
            context("when applying on an empty string") {
                it("should stop execution") {
                    expect(emptyNSString.append(subscript: testString)).to(throwAssertion())
                }
            }
            
            context("when appending an empty string") {
                it("should return the unaltered string") {
                    expect(testNSString.append(subscript: emptyString)).to(equal(testNSString))
                }
            }
            
            context("when applying on a string") {
                it("should return a new string with the appended subscript") {
                    let result = testNSString.append(subscript: testString)
                    let expected: String = testNSString.string + testString
                    expect(result.string).to(equal(expected))
                }
            }
            
            context("when applying an incorrect percentage size value") {
                it("should stop execution") {
                    expect(testNSString.append(subscript: testString, percentageSize: 2)).to(throwAssertion())
                }
            }
        }
    }
}
