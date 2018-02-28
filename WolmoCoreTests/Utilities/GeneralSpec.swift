//
//  GeneralSpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

class SimpleNameMotherClass {}

class SimpleNameChildClass: SimpleNameMotherClass {}

struct SimpleNameStruct {
    let x: Int = 0
    
    struct NestedStruct {
        let y: Int = 1
    }
}

protocol SimpleNameProtocol {}
extension SimpleNameStruct: SimpleNameProtocol {}

public class GeneralSpec: QuickSpec {

    override public func spec() {
        
        describe("#SimpleName(ofType:)") {
                
            context("when the type is a mother class") {
                
                it("should return the class' name") {
                    let simpleName = SimpleName(ofType: SimpleNameMotherClass.self)
                    expect(simpleName).to(equal("SimpleNameMotherClass"))
                }
                
            }
            
            context("when the type is a child class") {
                
                it("should return the class' name") {
                    let simpleName = SimpleName(ofType: SimpleNameChildClass.self)
                    expect(simpleName).to(equal("SimpleNameChildClass"))
                }
                
            }
            
            context("when the type is a struct") {
                
                it("should return the struct's name") {
                    let simpleName = SimpleName(ofType: SimpleNameStruct.self)
                    expect(simpleName).to(equal("SimpleNameStruct"))
                }
                
            }
            
            context("when the type is a protocol") {
                
                it("should return the protocol's name") {
                    let simpleName = SimpleName(ofType: SimpleNameProtocol.self)
                    expect(simpleName).to(equal("SimpleNameProtocol"))
                }
                
            }
            
            context("when the type is nested") {
                
                it("should return the inner class' name") {
                    let simpleName = SimpleName(ofType: SimpleNameStruct.NestedStruct.self)
                    expect(simpleName).to(equal("NestedStruct"))
                }
                
            }
            
        }
        
        describe("#SimpleName(of:)") {
                
            context("when the type is a concrete class") {
                
                it("should return the class' name") {
                    let x = SimpleNameMotherClass()
                    let simpleName = SimpleName(of: x)
                    expect(simpleName).to(equal("SimpleNameMotherClass"))
                }
                
            }
            
            context("when the type is a mother class") {
                    
                it("should return the child class' name") {
                    let x: SimpleNameMotherClass = SimpleNameChildClass()
                    let simpleName = SimpleName(of: x)
                    expect(simpleName).to(equal("SimpleNameChildClass"))
                }
                
            }
            
            context("when the type is a struct") {
                
                it("should return the struct's name") {
                    let x = SimpleNameStruct()
                    let simpleName = SimpleName(of: x)
                    expect(simpleName).to(equal("SimpleNameStruct"))
                }
                
            }
            
            context("when the type is a nested type") {
                
                it("should return the inner struct's name") {
                    let x = SimpleNameStruct.NestedStruct()
                    let simpleName = SimpleName(of: x)
                    expect(simpleName).to(equal("NestedStruct"))
                }
                
            }
            
            context("when the type is a protocol") {
                
                it("should return the concrete name") {
                    let x: SimpleNameProtocol = SimpleNameStruct()
                    let simpleName = SimpleName(of: x)
                    expect(simpleName).to(equal("SimpleNameStruct"))
                }
                
            }
            
            context("when the type is a type") {
                
                it("should return the metatype 'Type'") {
                    let x = SimpleNameStruct.self
                    let simpleName = SimpleName(of: x)
                    expect(simpleName).to(equal("Type"))
                }
                
            }
            
        }
        
    }
    
}
