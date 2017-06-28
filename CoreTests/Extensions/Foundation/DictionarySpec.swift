//
//  DictionarySpec.swift
//  Core
//
//  Created by Daniela Riesgo on 3/22/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class DictionarySpec: QuickSpec {
    
    override public func spec() {
        
        describe("#appending(contentsOf:)") {
            
            var dict1: [Int: String]!
            var dict2: [Int: String]!
            
            context("when dictionaries have all different keys") {
                
                beforeEach {
                    dict1 = [2: "dos", 3: "tres"]
                    dict2 = [4: "four"]
                }
                
                it("should return a new dictionary with the union of the original ones") {
                    let dict3 = dict1.appending(contentsOf: dict2)
                    expect(dict3.count).to(equal(3))
                    expect(dict3[2]).to(equal("dos"))
                    expect(dict3[3]).to(equal("tres"))
                    expect(dict3[4]).to(equal("four"))
                }
                
                it("should not change the original ones") {
                    let _ = dict1.appending(contentsOf: dict2)
                    expect(dict1).to(equal([2: "dos", 3: "tres"]))
                    expect(dict2).to(equal([4: "four"]))
                }
                
            }
            
            context("when both dictionaries have some keys in common") {
                
                beforeEach {
                    dict1 = [2: "two", 3: "three"]
                    dict2 = [3: "tres", 4: "cuatro"]
                }
                
                it("should return a new dictionary with the union of the original ones") {
                    let dict3 = dict1.appending(contentsOf: dict2)
                    expect(dict3.count).to(equal(3))
                    expect(dict3[2]).to(equal("two"))
                    expect(dict3[3]).to(equal("tres"))
                    expect(dict3[4]).to(equal("cuatro"))
                }
                
                it("should not change the original ones") {
                    let _ = dict1.appending(contentsOf: dict2)
                    expect(dict1).to(equal([2: "two", 3: "three"]))
                    expect(dict2).to(equal([3: "tres", 4: "cuatro"]))
                }
                
            }
            
        }
        
        describe("#append(contentsOf:)") {
            
            var dict1: [Int: String]!
            var dict2: [Int: String]!
            
            context("when dictionaries have no same keys") {
                
                beforeEach {
                    dict1 = [2: "dos", 3: "tres"]
                    dict2 = [4: "four"]
                }
                
                it("should return a new dictionary with the union of the original ones") {
                    dict1.append(contentsOf: dict2)
                    expect(dict1.count).to(equal(3))
                    expect(dict1[2]).to(equal("dos"))
                    expect(dict1[3]).to(equal("tres"))
                    expect(dict1[4]).to(equal("four"))
                }
                
            }
            
            context("when both dictionaries have some keys in common") {
                
                beforeEach {
                    dict1 = [2: "two", 3: "three"]
                    dict2 = [3: "tres", 4: "cuatro"]
                }
                
                it("should return a new dictionary with the union of the original ones") {
                    dict1.append(contentsOf: dict2)
                    expect(dict1.count).to(equal(3))
                    expect(dict1[2]).to(equal("two"))
                    expect(dict1[3]).to(equal("tres"))
                    expect(dict1[4]).to(equal("cuatro"))
                }
                
            }
            
        }

        describe("value(forKey:or:)") {

            var dict1: [Int: String]!

            beforeEach {
                dict1 = [1: "one", 2: "two", 3: "three"]
            }

            context("when the key is already in the dictionary") {

                it("should return the key's value") {
                    let value = dict1.value(forKey: 2, or: "dos")
                    expect(value).to(equal("two"))
                }

            }

            context("when the key is not in the dictionary") {

                it("should return the default value") {
                    let value = dict1.value(forKey: 4, or: "cuatro")
                    expect(value).to(equal("cuatro"))
                }
                
            }

        }

        describe("castedValue(forKey:or:)") {

            var dict1: [Int: Any]!

            beforeEach {
                dict1 = [1: "one", 2: 2, 3: [",", ".", ":"]]
            }

            context("when the key is already in the dictionary") {

                context("when the key's value's type is not T") {

                    it("should raise a runtime error") {
                        expect(_ = dict1.castedValue(forKey: 2, or: "two")).to(throwAssertion())
                    }

                }

                context("when the key's value's type is T") {

                    it("should return the key's value") {
                        let value = dict1.castedValue(forKey: 1, or: "uno")
                        expect(value).to(equal("one"))
                    }

                }

            }

            context("when the key is not in the dictionary") {
                
                it("should return the default value") {
                    let value = dict1.castedValue(forKey: 5, or: ["español": "cinco"])
                    expect(value).to(equal(["español": "cinco"]))
                }
                
            }

        }
        
    }

}
