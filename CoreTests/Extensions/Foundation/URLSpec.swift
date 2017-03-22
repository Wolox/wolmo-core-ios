//
//  URLSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class URLSpec: QuickSpec {
    
    override public func spec() {
        
        // Ts are in capital letters to make sure the search is case insensitive:
        let remoteURL = URL(string: "hTTps://www.google.com.ar")!
        
        let localURL: URL = {
            let fileManager = FileManager.default
            return fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
        }()
        
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
        
        describe("#isHTTPSProtocol") {
            
            context("When the URL is of type HTTPS") {
                
                it("should return true") {
                    expect(remoteURL.isHTTPProtocol).to(beTrue())
                }
            }
            
            context("When the URL isn't of type HTTPS") {
                
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
