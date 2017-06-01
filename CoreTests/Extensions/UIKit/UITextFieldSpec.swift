//
//  UITextFieldSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/15/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class UITextFieldSpec: QuickSpec {
    
    override public func spec() {

        describe("#nextTextField") {
            
            context("When there isn't next textfield associated") {
            
                it("should be nil") {
                    let textField = UITextField()
                    expect(textField.nextTextField).to(beNil())
                }
            }
            
            context("When there is a next textfield associated") {
                
                var textField: UITextField!
                var nextTextField: UITextField!
                
                beforeEach {
                    textField = UITextField()
                    nextTextField = UITextField()
                    textField.nextTextField = nextTextField
                }
                
                it("should return the next textfield") {
                    expect(textField.nextTextField).toNot(beNil())
                    expect(textField.nextTextField!).to(equal(nextTextField))
                }
                
                context("When the next textField is changed") {
                    
                    var otherTextField: UITextField!
                    
                    beforeEach {
                        otherTextField = UITextField()
                        textField.nextTextField = otherTextField
                    }
                    
                    it("should return the new textfield") {
                        expect(textField.nextTextField).toNot(beNil())
                        expect(textField.nextTextField!).to(equal(otherTextField))
                    }

                }

            }
            
        }

        describe("#fontTextStyle") {

            var textField: UITextField!

            beforeEach {
                textField = UITextField()
            }

            describe("get") {

                context("When a style was set") {

                    beforeEach {
                        textField.fontTextStyle = .body
                    }

                    it("should return that style") {
                        expect(textField.fontTextStyle).to(equal(UIFontTextStyle.body))
                    }
                    
                }

                context("When no style was set") {

                    it("should return .none") {
                        expect(textField.fontTextStyle).to(beNil())
                    }
                    
                }

                context("When a style was set but then font property was changed") {

                    beforeEach {
                        textField.fontTextStyle = .body
                        textField.font = UIFont.systemFont(ofSize: 30)
                    }

                    it("should return .none") {
                        expect(textField.fontTextStyle).to(beNil())
                    }
                    
                }

            }

            describe("set") {

                beforeEach {
                    textField.fontTextStyle = .body
                }

                context("When a style is set") {

                    it("should change the fontTextStyle") {
                        expect(textField.fontTextStyle).to(equal(UIFontTextStyle.body))
                    }

                    it("should change the font as well") {
                        expect(textField.font).to(equal(UIFont.preferredFont(forTextStyle: .body)))
                    }

                }

            }

        }

    }

}
