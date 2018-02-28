//
//  PathAppendableSpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 3/22/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

struct AppendableMockStruct: PathAppendable {
    let x: Int
}

class AppendableMockClass: PathAppendable, CustomStringConvertible {
    
    var description: String {
        return "Class new description"
    }
    
}

class AppendableMockOriginalClass: PathAppendable {
    
    func toPath() -> String {
        return "Original Class With Own Path"
    }
    
}


public class PathAppendableSpec: QuickSpec {

    override public func spec() {
        
        let remoteURL = URL(string: "https://www.google.com.ar")!
        
        describe("#/ for URLs") {
            
            context("When the path to append comes from default implementation of protocol") {
                
                context("when the path to append is a string") {
                    
                    it("should append the path component to the base URL") {
                        let rawURL = remoteURL / "Hello"
                        expect(rawURL.absoluteString).to(equal(remoteURL.absoluteString + "/Hello"))
                    }
                    
                }
                
                context("When the path to append is an int") {
                    
                    it("should append the path component to the base URL") {
                        let int: Int = 1
                        let rawURL = remoteURL / int
                        expect(rawURL.absoluteString).to(equal(remoteURL.absoluteString + "/1"))
                    }
                    
                }
                
                context("When the path to append is an uint") {
                    
                    it("should append the path component to the base URL") {
                        let uint: UInt = 3
                        let rawURL = remoteURL / uint
                        expect(rawURL.absoluteString).to(equal(remoteURL.absoluteString + "/3"))
                    }
                    
                }
                
                context("When the path to append uses default implementation of String(describing:)") {
                    
                    it("should append the path component's name to the base URL") {
                        let value = AppendableMockStruct(x: 3)
                        let rawURL = remoteURL / value
                        expect(rawURL.absoluteString).to(equal(remoteURL.absoluteString + "/AppendableMockStruct(x:%203)"))
                    }
                    
                }
                
                context("When the path to append uses a custom `CustomStringConvertible` implementation") {
                    
                    it("should append the path component's `description` to the base URL") {
                        let value = AppendableMockClass()
                        let rawURL = remoteURL / value
                        expect(rawURL.absoluteString).to(equal(remoteURL.absoluteString + "/Class%20new%20description"))
                    }
                    
                }
                
            }
            
            context("When the path to append uses a custom protocol implementation") {
                
                it("should append the path component's `toPath` result to the base URL") {
                    let value = AppendableMockOriginalClass()
                    let rawURL = remoteURL / value
                    expect(rawURL.absoluteString).to(equal(remoteURL.absoluteString + "/Original%20Class%20With%20Own%20Path"))
                }
                
            }
            
        }
        
        describe("#/ for strings") {
            
            let baseString = "BaseString"
            
            context("When the path to append comes from default implementation of protocol") {
                
                context("when the path to append is a string") {
                    
                    it("should append the path component to the base string") {
                        let newString = baseString / "Hello"
                        expect(newString).to(equal(baseString + "/Hello"))
                    }
                    
                }
                
                context("When the path to append is an int") {
                    
                    it("should append the path component to the base string") {
                        let int: Int = 1
                        let newString = baseString / int
                        expect(newString).to(equal(baseString + "/1"))
                    }
                    
                }
                
                context("When the path to append is an uint") {
                    
                    it("should append the path component to the base string") {
                        let uint: UInt = 3
                        let newString = baseString / uint
                        expect(newString).to(equal(baseString + "/3"))
                    }
                    
                }
                
                context("When the path to append uses default implementation of String(describing:)") {
                    
                    it("should append the path component's name to the base string") {
                        let value = AppendableMockStruct(x: 5)
                        let newString = baseString / value
                        expect(newString).to(equal(baseString + "/AppendableMockStruct(x: 5)"))
                    }
                    
                }
                
                context("When the path to append uses a custom `CustomStringConvertible` implementation") {
                    
                    it("should append the path component's `description` to the base string") {
                        let value = AppendableMockClass()
                        let newString = baseString / value
                        expect(newString).to(equal(baseString + "/Class new description"))
                    }
                    
                }
                
            }
            
            context("When the path to append uses a custom protocol implementation") {
                
                it("should append the path component's `toPath` result to the base string") {
                    let value = AppendableMockOriginalClass()
                    let newString = baseString / value
                    expect(newString).to(equal(baseString + "/Original Class With Own Path"))
                }
                
            }
            
        }
        
    }

}
