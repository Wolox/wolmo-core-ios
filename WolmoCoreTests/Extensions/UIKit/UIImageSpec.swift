//
//  UIImageSpec.swift
//  WolmoCore
//
//  Created by Nahuel Gladstein on 6/12/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Quick
import Nimble
import WolmoCore

public class UIImageSpec: QuickSpec {
    public func hasMatchingWidth(sizeOne: CGSize, sizeTwo: CGSize) -> Bool {
        return sizeOne.width.rounded() == sizeTwo.width.rounded()
    }
    
    public func hasMatchingHeight(sizeOne: CGSize, sizeTwo: CGSize) -> Bool {
        return sizeOne.height.rounded() == sizeTwo.height.rounded()
    }
    
    override public func spec() {
        var originalImage: UIImage!
        
        describe("#resized") {
            beforeEach {
                let bundle = Bundle(for: type(of: self))
                originalImage = UIImage(named: "50by50", in: bundle, compatibleWith: .none)
                // The original size of the image is 50x50, so it's aspect ratio is 1:1
            }
            
            context("When the wanted size is bigger") {
                context("And has the same aspect ratio") {
                    it("should return a resized image with a size equal to the wanted size, thus having the same aspect ratio") {
                        let wantedSize = CGSize(width: 100, height: 100)
                        let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: true)
                        expect(originalImage.aspectRatio).to(equal(resizedImage.aspectRatio))
                        expect(resizedImage.size).to(equal(wantedSize))
                    }
                }
                context("And has a different aspect ratio") {
                    context("And the user wants to maintain the original aspect ratio") {
                        it("should return an image with the same aspect ratio and a size close to the wanted one") {
                            let wantedSize = CGSize(width: 250, height: 346)
                            let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: true)
                            expect(originalImage.aspectRatio).to(equal(resizedImage.aspectRatio))
                            expect(self.hasMatchingWidth(sizeOne: resizedImage.size, sizeTwo: wantedSize)).to(beTrue())
                        }
                    }
                    context("And the user wants to stretch the image to match the wanted size") {
                        it("should return an image with a size equal to the wanted one") {
                            let wantedSize = CGSize(width: 250, height: 346)
                            let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: false)
                            expect(resizedImage.size).to(equal(wantedSize))
                        }
                    }
                }
            }
            context("When the wanted size is smaller") {
                context("And has the same aspect ratio") {
                    it("should return a resized image with a size equal to the wanted size, thus having the same aspect ratio") {
                        let wantedSize = CGSize(width: 10, height: 10)
                        let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: true)
                        expect(originalImage.aspectRatio).to(equal(resizedImage.aspectRatio))
                        expect(resizedImage.size).to(equal(wantedSize))
                    }
                }
                context("And has a different aspect ratio") {
                    context("And the user wants to maintain the original aspect ratio") {
                        it("should return an image with the same aspect ratio and a size close to the wanted one matching the wanted width") {
                            let wantedSize = CGSize(width: 15, height: 29)
                            let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: true)
                            expect(originalImage.aspectRatio).to(equal(resizedImage.aspectRatio))
                            expect(self.hasMatchingWidth(sizeOne: resizedImage.size, sizeTwo: wantedSize)).to(beTrue())
                        }
                        
                        it("should return an image with the same aspect ratio and a size close to the wanted one matching wanted the height") {
                            let wantedSize = CGSize(width: 43, height: 21)
                            let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: true)
                            expect(originalImage.aspectRatio).to(equal(resizedImage.aspectRatio))
                            expect(self.hasMatchingHeight(sizeOne: resizedImage.size, sizeTwo: wantedSize)).to(beTrue())
                        }
                    }
                    context("And the user wants to stretch the image to match the wanted size") {
                        it("should return an image with a size equal to the wanted one") {
                            let wantedSize = CGSize(width: 15, height: 29)
                            let resizedImage = originalImage.resized(toSize: wantedSize, maintainAspectRatio: false)
                            expect(resizedImage.size).to(equal(wantedSize))
                        }
                    }
                }
            }
        }
    }
}
