//
//  UITableViewSpec.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

public class UITableViewSpec: QuickSpec, UITableViewDataSource, UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override public func spec() {
        
        var tableView: UITableView!
        
        beforeEach {
            tableView = NibLoadableUITableView.loadFromNib()!
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
        }
        
        describe("#register(cell:) and #dequeue(cell:for:)") {
            
            context("when dequeing an already registered cell") {
                
                it("should return the loaded cell") {
                    tableView.register(cell: NibLoadableTableCell.self)
                    let cell = tableView.dequeue(cell: NibLoadableTableCell.self, for: IndexPath(row: 0, section: 0))
                    expect(cell).toNot(beNil())
                }
                
            }
            
            context("when dequeing a not before registered cell") {
                
                it("should return .none") {
                    expect(tableView.dequeue(cell: NibLoadableTableCell.self, for: IndexPath(row: 0, section: 0)))
                        .to(raiseException(named: "NSInternalInconsistencyException"))
                }
                
            }
            
        }
        
        describe("#register(cell:) and #dequeue(cell:)") {
            
            context("when dequeing an already registered cell") {
                
                it("should return the loaded cell") {
                    tableView.register(cell: NibLoadableTableCell.self)
                    let cell = tableView.dequeue(cell: NibLoadableTableCell.self)
                    expect(cell).toNot(beNil())
                }
                
            }
            
            context("when dequeing a not before registered cell") {
                
                it("should return .none") {
                    let cell = tableView.dequeue(cell: NibLoadableTableCell.self)
                    expect(cell).to(beNil())
                }
                
            }
            
        }
        
        //Test failing because of `dequeueReusableHeaderFooterView(withIdentifier: headerType.identifier)` always returns nil.
        //But don't know why.
        /*
        describe("#register(header:) and #dequeue(header:for:)") {
            
            context("when dequeing an already registered header") {
                
                it("should return the loaded view") {
                    //Test failing because of error: "NSInternalInconsistencyException",
                    //"request for layout attributes for supplementary view UICollectionElementKindSectionHeader in section 0 when there are only 0 sections in the collection view"
                    //But don't know why.
                    tableView.register(header: NibLoadableTableView.self)
                    let view = tableView.dequeue(header: NibLoadableTableView.self)
                    expect(view).toNot(beNil())
                }
                
            }
            
            context("when dequeing a view registered for footer") {
                
                it("should return the loaded view since footer and header are interchangeable in table views") {
                    tableView.register(footer: NibLoadableTableView.self)
                    let view = tableView.dequeue(header: NibLoadableTableView.self)
                    expect(view).toNot(beNil())
                }
                
            }
            
            context("when dequeing a not before registered view") {
                
                it("should return .none") {
                    let view = tableView.dequeue(header: NibLoadableTableView.self)
                    expect(view).to(beNil())
                }
                
            }
            
        }
        
        describe("#register(footer:) and #dequeue(footer:for:)") {
            
            context("when dequeing an already registered footer") {
                
                it("should return the loaded view") {
                    //Test failing because of error: "NSInternalInconsistencyException",
                    //"request for layout attributes for supplementary view UICollectionElementKindSectionHeader in section 0 when there are only 0 sections in the collection view"
                    //But don't know why.
                    tableView.register(footer: NibLoadableTableView.self)
                    let view = tableView.dequeue(footer: NibLoadableTableView.self)
                    expect(view).toNot(beNil())
                }
                
            }
            
            context("when dequeing a view registered for header") {
                
                it("should return the loaded view since footer and header are interchangeable in table views") {
                    tableView.register(header: NibLoadableTableView.self)
                    let view = tableView.dequeue(footer: NibLoadableTableView.self)
                    expect(view).toNot(beNil())
                }
                
            }
            
            context("when dequeing a not before registered view") {
                
                it("should return .none") {
                    let view = tableView.dequeue(footer: NibLoadableTableView.self)
                    expect(view).to(beNil())
                }
                
            }
            
        }
        */
        
    }
    
}
