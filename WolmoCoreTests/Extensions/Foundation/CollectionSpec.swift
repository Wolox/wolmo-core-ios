//
//  CollectionSpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 3/27/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import Nimble
import Quick
import WolmoCore

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

        }
        
    }
    
}
