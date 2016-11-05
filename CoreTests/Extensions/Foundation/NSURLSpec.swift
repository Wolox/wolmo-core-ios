//
//  NSURLSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class NSURLSpec: QuickSpec {
    
    override public func spec() {
        
        let remoteURL = NSURL(string: "https://www.google.com.ar")!
        
        let localURL: NSURL = {
            let fileManager = NSFileManager.defaultManager()
            return fileManager.URLsForDirectory(.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last!
        }()
            
        describe("#/") {
            
            context("when the path to append is a string") {
                
                it("should append the path component to the base URL") {
                    let rawURL = remoteURL / "Hello"
                    expect(rawURL!.absoluteString).to(equal(remoteURL.absoluteString! + "/Hello"))
                }
            }
            
            context("When the path to append is an int") {
                
                it("should append the path component to the base URL") {
                    let rawURL = remoteURL / 1
                    expect(rawURL!.absoluteString).to(equal(remoteURL.absoluteString! + "/1"))
                }
            }
            
        }
        
        describe("#isHTTPProtocol") {
            
            context("When the URL is of type HTTP") {
                
                it("should return true") {
                    expect(remoteURL.isHTTPProtocol).to(beTrue())
                }
            }
            
            context("When the URL isn't of type HTTP") {
                
                it("should return false") {
                    expect(localURL.isHTTPProtocol).to(beFalse())
                }
            }
        }
        
        describe("#contains(subDirectory:)") {
            
            context("When the directory contains the subDirectory") {
                
                it("should return true") {
                    expect(localURL.contains(subDirectory: "Documents")).to(beTrue())
                }
            }
            
            context("When the directory doesn't contain the subDirectory") {
             
                it("should return false") {
                    expect(localURL.contains(subDirectory: "foo")).to(beFalse())
                }
            }
        }
    }
}
