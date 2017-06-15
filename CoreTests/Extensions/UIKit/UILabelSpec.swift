//
//  UILabelSpec.swift
//  Core
//
//  Created by Daniela Riesgo on 6/5/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

fileprivate class MyFontProvider: UIFontProvider {

    func appFontName(for style: UIFontTextStyle) -> String {
        switch style {
        case UIFontTextStyle.headline: return "Helvetica-Bold"
        case UIFontTextStyle.title1: return "jwdbf"
        default: return "Helvetica"
        }
    }

}

public class UILabelSpec: QuickSpec {

    override public func spec() {

        beforeSuite {
            UIFont.fontProvider = MyFontProvider()
        }

        describe("#fontTextStyle") {

            var label: UILabel!

            beforeEach {
                label = UILabel()
            }

            describe("get") {

                context("When a style was set") {

                    beforeEach {
                        label.fontTextStyle = .body
                    }

                    it("should return that style") {
                        expect(label.fontTextStyle).to(equal(UIFontTextStyle.body))
                    }

                }

                context("When no style was set") {

                    it("should return .none") {
                        expect(label.fontTextStyle).to(beNil())
                    }

                }

                context("When a style was set but then font property was changed") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.font = UIFont.systemFont(ofSize: 30)
                    }

                    it("should return .none") {
                        expect(label.fontTextStyle).to(beNil())
                    }

                }

                context("When a font was set after setting various styles") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.fontTextStyle = .title2
                        label.font = UIFont.systemFont(ofSize: 30)
                    }

                    it("should return .none") {
                        expect(label.fontTextStyle).to(beNil())
                    }

                }

            }

            describe("set") {

                context("When a style is set") {

                    context("that has a custom font name") {

                        beforeEach {
                            label.fontTextStyle = .headline
                        }

                        it("should change the fontTextStyle") {
                            expect(label.fontTextStyle).to(equal(UIFontTextStyle.headline))
                        }

                        it("should change the font as specified in appFontName(for:)") {
                            expect(label.font.pointSize).to(equal(UIFont.preferredFont(forTextStyle: .headline).pointSize))
                            expect(label.font.fontName).to(equal("Helvetica-Bold"))
                        }

                    }

                    context("that has the base font") {

                        beforeEach {
                            label.fontTextStyle = .body
                        }

                        it("should change the fontTextStyle") {
                            expect(label.fontTextStyle).to(equal(UIFontTextStyle.body))
                        }

                        it("should change the font as specified in appFontName(for:)") {
                            expect(label.font.pointSize).to(equal(UIFont.preferredFont(forTextStyle: .body).pointSize))
                            expect(label.font.fontName).to(equal("Helvetica"))
                        }

                    }

                    context("that is associated with an invalid font name") {

                        it("should throw a runtime error") {
                            expect(label.fontTextStyle = .title1).to(throwAssertion())
                        }

                    }

                }

                context("When a style is set after another one") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.fontTextStyle = .title2
                    }

                    it("should return the new textStyle") {
                        expect(label.fontTextStyle).to(equal(UIFontTextStyle.title2))
                    }
                    
                }

                context("When a style is set after font property was changed") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.font = UIFont.systemFont(ofSize: 30)
                        label.fontTextStyle = .title2
                    }

                    it("should return the new textStyle") {
                        expect(label.fontTextStyle).to(equal(UIFontTextStyle.title2))
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
