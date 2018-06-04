//
//  UIColor.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/15/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Quick
import Nimble
import WolmoCore

public class UIColorSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#init") {
            
            context("When the hexString is valid") {
                
                it("should not be nil") {
                    let color = UIColor(hex: "08BBF4")
                    expect(color).toNot(beNil())
                }
                
                context("When the string contains a # prefix") {
                    
                    it("should not be nil") {
                        let color = UIColor(hex: "#08BBF4")
                        expect(color).toNot(beNil())
                    }
                }
                
                context("When the length is 8 (it has alpha)") {
                    
                    it("should not be nil") {
                        let color = UIColor(hex: "#08BBF433")
                        expect(color).toNot(beNil())
                    }
                }
            }
            
            context("When the hexString is invalid") {
                
                context("When the hexString length is greater than 6") {
                    
                    context("When the length is different from 8") {
                        
                        it("should be nil") {
                            let color = UIColor(hex: "#08BBF43")
                            expect(color).to(beNil())
                        }
                    }
                }
                
                context("When the length is less than 6") {
                    
                    it("should be nil") {
                        let color = UIColor(hex: "#08BB")
                        expect(color).to(beNil())
                    }
                }
            }
        }
    }
}
