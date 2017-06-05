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

public class UILabelSpec: QuickSpec {

    override public func spec() {

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
                        label.fontTextStyle = .title1
                        label.font = UIFont.systemFont(ofSize: 30)
                    }

                    it("should return .none") {
                        expect(label.fontTextStyle).to(beNil())
                    }

                }

            }

            describe("set") {

                beforeEach {
                    label.fontTextStyle = .body
                }

                context("When a style is set") {
                    
                    it("should change the fontTextStyle") {
                        expect(label.fontTextStyle).to(equal(UIFontTextStyle.body))
                    }
                    
                    it("should change the font as well") {
                        expect(label.font).to(equal(UIFont.preferredFont(forTextStyle: .body)))
                    }
                    
                }

                context("When a style is set after another one") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.fontTextStyle = .title1
                    }

                    it("should return the new textStyle") {
                        expect(label.fontTextStyle).to(equal(UIFontTextStyle.title1))
                    }
                    
                }

                context("When a style is set after font property was changed") {

                    beforeEach {
                        label.fontTextStyle = .body
                        label.font = UIFont.systemFont(ofSize: 30)
                        label.fontTextStyle = .title1
                    }

                    it("should return the new textStyle") {
                        expect(label.fontTextStyle).to(equal(UIFontTextStyle.title1))
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
