//
//  NibLoadableSpec.swift
//  Core
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Core
import MBProgressHUD

public class NibLoadableSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#nibName") {

            context("when using default implementation") {
                
                it("should be the class' simple name") {
                    expect(NibLoadableCollectionCell.nibName).to(equal("NibLoadableCollectionCell"))
                    expect(NibLoadableCollectionView.nibName).to(equal("NibLoadableCollectionView"))
                    expect(NibLoadableTableCell.nibName).to(equal("NibLoadableTableCell"))
                    expect(NibLoadableStruct.nibName).to(equal("NibLoadableStruct"))
                }
                
            }
            
            context("when using custom implementation") {
                
                it("should return the custom name") {
                    expect(NibLoadableTableView.nibName).to(equal("NibLoadableTableViewCustom"))
                    expect(NibLoadableTableViewCustom.nibName).to(equal("NibLoadableTableViewCustom"))
                    expect(NibLoadableTableViewCustom2.nibName).to(equal("NibLoadableTableViewCustom"))
                }
                
            }
            
        }
        
        describe("#nibBundle") {
            
            context("when using default implementation") {
                
                context("when it's a class") {
                    
                    it("should be the class' bundle") {
                        expect(NibLoadableCollectionCell.nibBundle).to(equal(Bundle(for: NibLoadableCollectionCell.self)))
                        expect(NibLoadableCollectionView.nibBundle).to(equal(Bundle(for: NibLoadableCollectionView.self)))
                        expect(NibLoadableTableCell.nibBundle).to(equal(Bundle(for: NibLoadableTableCell.self)))
                    }
                    
                }
                
                context("when it's not a class") {
                    
                    it("should be the main bundle") {
                        expect(NibLoadableStruct.nibBundle).to(equal(Bundle.main))
                    }
                    
                }
                
            }
            
            context("when using custom implementation") {
                
                it("should return the custom bundle") {
                    expect(NibLoadableTableViewCustom.nibBundle).to(equal(Bundle(for: MBProgressHUD.self)))
                }
                
            }
            
        }
        
        describe("#loadFromNib") {
            
            context("when there is a nib for it in that bundle") {
                
                it("should return the object loaded from the nib") {
                    let loaded: NibLoadableCollectionCell? = NibLoadableCollectionCell.loadFromNib()
                    expect(loaded).toNot(beNil())
                }
                
            }
            
            context("when the nib and bundle exists, but it is from another class") {
                
                it("should return .none") {
                    let loaded: NibLoadableTableViewCustom2? = NibLoadableTableViewCustom2.loadFromNib()
                    expect(loaded).to(beNil())
                }
                
            }
            
            context("when the nib is not in the specified bundle") {
                
                it("should return .none") {
                    expect(NibLoadableTableViewCustom.loadFromNib()).to(raiseException(named: "NSInternalInconsistencyException"))
                }
                
            }
            
            context("when there is no nib under that name") {
                
                it("should return .none") {
                    expect(NibLoadableStruct.loadFromNib()).to(raiseException(named: "NSInternalInconsistencyException"))
                }
                
            }
            
        }
    
    }
    
}
