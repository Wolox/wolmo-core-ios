//
//  UILabelSpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 6/5/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

fileprivate class MyFontProvider: UIFontProvider {

    func appFontName(for style: UIFont.TextStyle) -> String {
        switch style {
        case UIFont.TextStyle.headline: return "Helvetica-Bold"
        case UIFont.TextStyle.title1: return "jwdbf"
        default: return "Helvetica"
        }
    }

}

public class UILabelSpec: QuickSpec {

    override public func spec() {

        beforeEach {
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
                        expect(label.fontTextStyle).to(equal(UIFont.TextStyle.body))
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
                            expect(label.fontTextStyle).to(equal(UIFont.TextStyle.headline))
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
                            expect(label.fontTextStyle).to(equal(UIFont.TextStyle.body))
                        }

                        it("should change the font as specified in appFontName(for:)") {
                            expect(label.font.pointSize).to(equal(UIFont.preferredFont(forTextStyle: .body).pointSize))
                            expect(label.font.fontName).to(equal("Helvetica"))
                        }

                    }

                    context("that is associated with an invalid font name") {

                        // Commenting til Nimble finds a solution for this problem: https://github.com/Quick/Nimble/issues/478
//                        it("should throw a runtime error") {
//                            expect(label.fontTextStyle = .title1).to(throwAssertion())
//                        }

                    }

                }

                context("When a style is set after another one") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.fontTextStyle = .title2
                    }

                    it("should return the new textStyle") {
                        expect(label.fontTextStyle).to(equal(UIFont.TextStyle.title2))
                    }
                    
                }

                context("When a style is set after font property was changed") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.font = UIFont.systemFont(ofSize: 30)
                        label.fontTextStyle = .title2
                    }

                    it("should return the new textStyle") {
                        expect(label.fontTextStyle).to(equal(UIFont.TextStyle.title2))
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
