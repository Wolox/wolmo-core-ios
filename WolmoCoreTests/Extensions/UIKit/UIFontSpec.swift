//
//  UIFontSpec.swift
//  WolmoCoreTests
//
//  Created by Daniela Riesgo on 04/06/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

fileprivate class CustomFontProvider: UIFontProvider {

    func appFontName(for style: UIFontTextStyle) -> String {
        switch style {
        case .headline: return "Kefa"
        case .body: return "Savoye LET"
        case .title1: return "ask"
        default: return UIFont.preferredFont(forTextStyle: style).fontName
        }
    }

}

fileprivate class CustomFontProvider2: UIFontProvider {

    func appFontName(for style: UIFontTextStyle) -> String {
        switch style {
        case .headline: return "Savoye LET"
        case .body: return "Kefa"
        default: return UIFont.preferredFont(forTextStyle: style).fontName
        }
    }

}

import Foundation
import Quick
import Nimble
import WolmoCore

public class UIFontSpec: QuickSpec {

    override public func spec() {

        var provider: UIFontProvider!
        var provider2: UIFontProvider!

        beforeEach {
            provider = CustomFontProvider()
            provider2 = CustomFontProvider2()
            UIFont.fontProvider = .none
        }

        describe("#fontProvider") {

            describe("get") {

                context("When a fontProvider was set") {

                    beforeEach {
                        UIFont.fontProvider = provider
                    }

                    it("it should return that fontProvider") {
                        expect { UIFont.fontProvider == provider }.to(beTrue())
                    }

                }

                context("When no fontProvider was set") {

                    it("should return .none") {
                        expect(UIFont.fontProvider).to(beNil())
                    }

                }

                context("When one fontProvider was set and removed") {

                    beforeEach {
                        UIFont.fontProvider = provider
                        UIFont.fontProvider = .none
                    }

                    it("should return .none") {
                        expect(UIFont.fontProvider).to(beNil())
                    }

                }

                context("When more than one fontProvider was set") {

                    beforeEach {
                        UIFont.fontProvider = provider
                        UIFont.fontProvider = provider2
                    }

                    it("should return the lasrt fontProvider") {
                        expect { UIFont.fontProvider == provider2 }.to(beTrue())
                    }

                }

            }

        }

        describe("#appFont(for:)") {

            context("when there is no fontProvider set") {

                it("should return the same as UIFont.preferredFont(forTextStyle:)") {
                    let result = UIFont.appFont(for: .body)
                    let expected = UIFont.preferredFont(forTextStyle: .body)
                    expect(result.fontName).to(equal(expected.fontName))
                    expect(result.pointSize).to(equal(expected.pointSize))
                }

            }

            context("when there is a fontProvider set") {

                beforeEach {
                    UIFont.fontProvider = provider
                }

                context("when the font name provided is valid") {

                    it("should return the font named as provided by provided") {
                        let result = UIFont.appFont(for: .body)
                        let expected = UIFont(name: "Savoye LET", size: UIFont.preferredFont(forTextStyle: .body).pointSize)!
                        expect(result.fontName).to(equal(expected.fontName))
                        expect(result.pointSize).to(equal(expected.pointSize))
                    }

                }

                context("when the font name provided is invalid") {

                    it("should return the font named as provided by provided") {
                        // Commenting til Nimble finds a solution for this problem: https://github.com/Quick/Nimble/issues/478
//                        it("should throw a runtime error") {
//                            expect(UIFont.appFont(for: .title1)).to(throwAssertion())
//                        }
                    }

                }

            }

        }

    }

}

