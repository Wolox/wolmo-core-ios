//
//  IdentifiableSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

class IdentifiableTableViewCellMock: UITableViewCell {}

class IdentifiableCollectionViewCellMock: UICollectionViewCell {}

class IdentifiableClass: Identifiable {
    
    static var identifier: String {
        return "CustomIdentifier"
    }
    
}

public class IdentifiableSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#identifier") {
            
            context("for collection view cell") {
                
                it("the default conformance is already provided and it match with the class name") {
                    expect(IdentifiableCollectionViewCellMock.identifier).to(equal("IdentifiableCollectionViewCellMock"))
                }
                
            }
            
            context("for table view cell") {
                
                it("the default conformance is already provided and it match with the class name") {
                    expect(IdentifiableTableViewCellMock.identifier).to(equal("IdentifiableTableViewCellMock"))
                }
                
            }
            
            context("for custom identifier") {
                
                it("should return that custom identifier") {
                    expect(IdentifiableClass.identifier).to(equal("CustomIdentifier"))
                }
                
            }
            
        }
    }
}
