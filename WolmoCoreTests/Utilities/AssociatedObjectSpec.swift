//
//  AssociatedObjectSpec.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

private class AssociatableObjectClassMock {
    var x: Int
    
    init(x: Int = 4) {
        self.x = x
    }
}

private struct AssociatableObjectStructMock {
    let x: Int
    
    init(x: Int = 4) {
        self.x = x
    }
}

private var key: Int = 0

public class AssociatedObjectSpec: QuickSpec {
    override public func spec() {
        var associatableObject: AssociatableObjectClassMock! // It has to be an AnyObject (AKA: class)
        var classToAssociate: AssociatableObjectClassMock!
        var structToAssociate: AssociatableObjectStructMock!
        
        beforeEach {
            associatableObject = AssociatableObjectClassMock()
            
            classToAssociate = AssociatableObjectClassMock()
            structToAssociate = AssociatableObjectStructMock()
        }
        
        afterEach {
            setAssociatedObject(associatableObject, key: &key, value: Optional<Int>.none)
        }
        
        describe("setAssociatedObject") {
            context("When the value to associate the object to is a class") {
                it("should set an associated object") {
                    setAssociatedObject(associatableObject, key: &key, value: classToAssociate)
                    let associated: AssociatableObjectClassMock = getAssociatedObject(associatableObject, key: &key)!
                    expect(associated.x).to(equal(classToAssociate.x))
                }
            }
            context("When the value to associate the object to is a struct") {
                it("should set an associated object") {
                    setAssociatedObject(associatableObject, key: &key, value: structToAssociate)
                    let associated: AssociatableObjectStructMock = getAssociatedObject(associatableObject, key: &key)!
                    expect(associated.x).to(equal(structToAssociate.x))
                }
            }
        }
        
        describe("#getAssociatedObject") {
            context("When there is no associated value") {
                it("should return nil") {
                    let value: Int? = getAssociatedObject(associatableObject, key: &key)
                    expect(value).to(beNil())
                }
            }
            context("when there is an associated value") {
                beforeEach {
                    setAssociatedObject(associatableObject, key: &key, value: classToAssociate)
                }
                
                it("should return the associated value") {
                    let a: AssociatableObjectClassMock = getAssociatedObject(associatableObject, key: &key)!
                    expect(a.x).to(equal(classToAssociate.x))
                }
                context("when there is a new associated value") {
                    var newObjectToAssociate: AssociatableObjectClassMock!
                    
                    beforeEach {
                        newObjectToAssociate = AssociatableObjectClassMock(x: 2)
                        setAssociatedObject(associatableObject, key: &key, value: newObjectToAssociate)
                    }
                    
                    it("should return the new associated value") {
                        let a: AssociatableObjectClassMock = getAssociatedObject(associatableObject, key: &key)!
                        expect(a.x).to(equal(newObjectToAssociate.x))
                    }
                }
            }
        }
    }
}
