//
//  UITextFieldSpec.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/15/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

fileprivate class MyFontProvider: UIFontProvider {

    func appFontName(for style: UIFontTextStyle) -> String {
        switch style {
        case UIFontTextStyle.headline: return "Helvetica-Bold"
        case UIFontTextStyle.title1: return "jwdbf"
        default: return "Helvetica"
        }
    }
    
}

public class UITextFieldSpec: QuickSpec {
    
    override public func spec() {

        beforeEach {
            UIFont.fontProvider = MyFontProvider()
        }

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

                context("When a font was set after setting various styles") {

                    beforeEach {
                        textField.fontTextStyle = .body
                        textField.fontTextStyle = .headline
                        textField.font = UIFont.systemFont(ofSize: 30)
                    }

                    it("should return .none") {
                        expect(textField.fontTextStyle).to(beNil())
                    }
                    
                }

            }

            describe("set") {

                context("When a style is set") {

                    context("that has a custom font name") {

                        beforeEach {
                            textField.fontTextStyle = .headline
                        }

                        it("should change the fontTextStyle") {
                            expect(textField.fontTextStyle).to(equal(UIFontTextStyle.headline))
                        }

                        it("should change the font as specified in appFontName(for:)") {
                            expect(textField.font?.pointSize).to(equal(UIFont.preferredFont(forTextStyle: .headline).pointSize))
                            expect(textField.font?.fontName).to(equal("Helvetica-Bold"))
                        }

                    }

                    context("that has the base font") {

                        beforeEach {
                            textField.fontTextStyle = .body
                        }

                        it("should change the fontTextStyle") {
                            expect(textField.fontTextStyle).to(equal(UIFontTextStyle.body))
                        }

                        it("should change the font as specified in appFontName(for:)") {
                            expect(textField.font?.pointSize).to(equal(UIFont.preferredFont(forTextStyle: .body).pointSize))
                            expect(textField.font?.fontName).to(equal("Helvetica"))
                        }

                    }

                    context("that is associated with an invalid font name") {

                        // Commenting til Nimble finds a solution for this problem: https://github.com/Quick/Nimble/issues/478
//                        it("should throw a runtime error") {
//                            expect(textField.fontTextStyle = .title1).to(throwAssertion())
//                        }

                    }

                    context("When a style is set after another one") {

                        beforeEach {
                            textField.fontTextStyle = .body
                            textField.fontTextStyle = .title2
                        }

                        it("should return the new textStyle") {
                            expect(textField.fontTextStyle).to(equal(UIFontTextStyle.title2))
                        }

                    }

                    context("When a style is set after font property was changed") {

                        beforeEach {
                            textField.fontTextStyle = .body
                            textField.font = UIFont.systemFont(ofSize: 30)
                            textField.fontTextStyle = .title2
                        }

                        it("should return the new textStyle") {
                            expect(textField.fontTextStyle).to(equal(UIFontTextStyle.title2))
                        }
                        
                    }
                    
                }

            }

        }

    }

}
