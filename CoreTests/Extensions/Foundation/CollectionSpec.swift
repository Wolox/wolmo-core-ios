//
//  CollectionSpec.swift
//  Core
//
//  Created by Daniela Riesgo on 3/27/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

import Nimble
import Quick
import Core

public class CollectionSpec: QuickSpec {

    override public func spec() {
        
        describe("#isNotEmpty") {
            
            context("when using an Array") {
                
                var collection: [Int]!
                
                context("when collection is empty") {
                    
                    beforeEach {
                        collection = []
                    }
                    
                    it("returns false") {
                        expect(collection.isNotEmpty).to(beFalse())
                    }
                    
                }
                
                context("when collection is not empty") {
                    
                    beforeEach {
                        collection = [1, 2, 3]
                    }
                    
                    it("returns true") {
                        expect(collection.isNotEmpty).to(beTrue())
                    }
                    
                }
                
            }

            describe("#first(where:)") {

                let array = [1, 2, 3]

                context("When an element satisfies the condition") {

                    it("should return that element") {
                        expect(array.first(where: { (elem) -> Bool in
                            elem == 1
                        })).to(equal(1))
                    }

                    context("When another element satisfies the condition") {

                        it("should return the first one") {
                            expect(array.first(where: { (elem) -> Bool in
                                elem % 2 == 1
                            })).to(equal(1))
                        }

                    }

                }

                context("When none of the elements satisfies the condition") {

                    it("should return nil") {
                        expect([1, 2, 3].first(where: { (elem) -> Bool in
                            elem == 5
                        })).to(beNil())
                    }

                }
            }
            
        }
        
    }
    
}
