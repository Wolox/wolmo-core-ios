//
//  BundleSpec.swift
//  Core
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class BundleSpec: QuickSpec {
    
    override public func spec() {
        
        let bundle = Bundle(for: BundleSpec.self)
        
        describe("#loadNib(named:)") {
            
            context("when there is a nib for it in that bundle and it's of the expected type") {
                
                it("should return the object loaded from the nib") {
                    let loaded: NibLoadableCollectionCell? = bundle.loadNib(named: "NibLoadableCollectionCell")
                    expect(loaded).toNot(beNil())
                }
                
            }
            
            context("when the nib exists in the bundle, but it is from another type") {
                
                it("should return .none") {
                    let loaded: NibLoadableTableViewCustom2? = bundle.loadNib(named: "NibLoadableTableViewCustom")
                    expect(loaded).to(beNil())
                }
                
            }
            
            context("when the nib is not in the bundle") {
                
                it("should return .none") {
                    expect(bundle.loadNib(named: "NibLoadableStruct"))
                        .to(raiseException(named: "NSInternalInconsistencyException"))
                }
                
            }
            
        }
        
        describe("#subscript") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is a string") {
                    
                    context("when it has inverted commas") {
                        
                        it("should return the value") {
                            let value = bundle["My Personal String Key With inverted commas"]
                            expect(value).toNot(beNil())
                            expect(value as? String).to(equal("This is a string with some \"quotation\""))
                        }
                        
                    }
                    
                    context("when the string is simple") {
                        
                        it("should return the value") {
                            let value = bundle["My Personal String Key"]
                            expect(value).toNot(beNil())
                            expect(value as? String).to(equal("My key's value"))
                        }
                        
                    }
                    
                }
                
                context("when the value is a number") {
                    
                    it("should return the value") {
                        let value = bundle["My Personal Number Key"]
                        expect(value).toNot(beNil())
                        expect(value as? Int).to(equal(5))
                    }
                    
                }
                
                context("when the value is a boolean") {
                    
                    it("shouldn't return the value") {
                        let value = bundle["My Personal Boolean Key"]
                        expect(value).toNot(beNil())
                        expect(value as? Bool).to(equal(true))
                    }
                    
                }
                
                context("when the value is a date") {
                    
                    it("shouldn't return the value") {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
                        let date = dateFormatter.date(from: "2017-04-20T18:34:41Z")!
                        let value = bundle["My Personal Date Key"]
                        expect(value).toNot(beNil())
                        expect(value as? Date).to(equal(date))
                    }
                    
                }
                
                context("when the value is a data") {
                    
                    it("shouldn't return the value") {
                        let value = bundle["My Personal Data Key"]
                        expect(value).toNot(beNil())
                        expect(value as? Data).to(equal(Data()))
                    }
                    
                }
                
                context("when the value is a array") {
                    
                    it("shouldn't return the value") {
                        let value = bundle["My Personal Array Key"]
                        expect(value).toNot(beNil())
                        expect(value as? [String]).to(equal(["1asg7", "2153a"]))
                    }
                    
                }
                
                context("when the value is a dictionary") {
                    
                    it("shouldn't return the value") {
                        let value = bundle["My Personal Dictionary Key"]
                        expect(value).toNot(beNil())
                        expect(value as? [String: Int]).to(equal(["0": 5, "1": 7]))
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value = bundle["Nonexistant Key !"]
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getString(from:)") {
            
            context("when the key exists in bundle's info plist") {

                context("when the value is the expected type") {
                    
                    context("when the string has inverted commas") {
                        
                        it("should return the value") {
                            let value = bundle.getString(from: "My Personal String Key With inverted commas")
                            expect(value).toNot(beNil())
                            expect(value).to(equal("This is a string with some \"quotation\""))
                        }
                        
                    }

                    context("when the string has only inverted commas") {

                        it("should return the value") {
                            let value = bundle.getString(from: "My Just inverted commas key")
                            expect(value).toNot(beNil())
                            expect(value).to(equal("\"\""))
                        }

                    }

                    context("when the string is empty") {

                        it("should return .none") {
                            let value = bundle.getString(from: "My Empty string key")
                            expect(value).to(beNil())
                        }
                        
                    }
                    
                    context("when the string is simple") {
                        
                        it("should return the value") {
                            let value = bundle.getString(from: "My Personal String Key")
                            expect(value).toNot(beNil())
                            expect(value).to(equal("My key's value"))
                        }
                        
                    }
                    
                }
                
                context("when the value is not the expected type") {

                    context("when the value is empty") {

                        it("should return .none for array") {
                            let value = bundle.getString(from: "My Empty array key")
                            expect(value).to(beNil())
                        }

                        it("should return .none for data") {
                            let value = bundle.getString(from: "My Empty data key")
                            expect(value).to(beNil())
                        }

                    }

                    context("wnhen the value is not empty") {

                        it("should return .none") {
                            let value = bundle.getString(from: "My Personal Number Key")
                            expect(value).to(beNil())
                        }

                    }

                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value = bundle.getString(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getInt(from:)") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is the expected type") {
                    
                    it("should return the value") {
                        let value = bundle.getInt(from: "My Personal Number Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(5))
                    }
                    
                }
                
                context("when the value can be converted to expected type") {
                    
                    it("should return the value") {
                        let value = bundle.getInt(from: "My Personal Float Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(7))
                    }
                    
                }
                
                context("when the value is not the expected type") {
                    
                    it("should return .none") {
                        let value = bundle.getInt(from: "My Personal Boolean Key")
                        expect(value).to(beNil())
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value = bundle.getInt(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getFloat(from:)") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is the expected type") {
                    
                    it("should return the value") {
                        let value = bundle.getFloat(from: "My Personal Number Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(5.0))
                    }
                    
                }
                
                context("when the value is not the expected type") {
                    
                    it("should return .none") {
                        let value = bundle.getFloat(from: "My Personal String Key")
                        expect(value).to(beNil())
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value = bundle.getFloat(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getDate(from:)") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is the expected type") {
                    
                    it("should return the value") {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
                        let date = dateFormatter.date(from: "2017-04-20T18:34:41Z")!
                        let value = bundle.getDate(from: "My Personal Date Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(date))
                    }
                    
                }
                
                context("when the value is not the expected type") {
                    
                    it("should return .none") {
                        let value = bundle.getDate(from: "My Personal String Key")
                        expect(value).to(beNil())
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value = bundle.getDate(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getData(from:)") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is the expected type") {
                    
                    it("should return the value") {
                        let data = Data(base64Encoded: "")
                        let value = bundle.getData(from: "My Personal Data Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(data))
                    }
                    
                }
                
                context("when the value is not the expected type") {
                    
                    it("should return .none") {
                        let value = bundle.getData(from: "My Personal Date Key")
                        expect(value).to(beNil())
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value = bundle.getData(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getArray(from:)") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is the expected type") {
                    
                    it("should return the value") {
                        let array = ["1asg7", "2153a"]
                        let value: [String]? = bundle.getArray(from: "My Personal Array Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(array))
                    }
                    
                }
                
                context("when the value is not the expected type") {
                    
                    it("should return .none") {
                        let value: [String]? = bundle.getArray(from: "My Personal Dictionary Key")
                        expect(value).to(beNil())
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value: [String]? = bundle.getArray(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
        describe("#getDictionary(from:)") {
            
            context("when the key exists in bundle's info plist") {
                
                context("when the value is the expected type") {
                    
                    it("should return the value") {
                        let dictionary: [String: Float] = ["0": 5.0, "1": 7.0]
                        let value: [String: Float]? = bundle.getDictionary(from: "My Personal Dictionary Key")
                        expect(value).toNot(beNil())
                        expect(value).to(equal(dictionary))
                    }
                    
                }
                
                context("when the value is not the expected type") {
                    
                    it("should return .none") {
                        let value: [String: Float]? = bundle.getDictionary(from: "My Personal String Key")
                        expect(value).to(beNil())
                    }
                    
                }
                
            }
            
            context("when the key doesn't exist in the bundle") {
                
                it("should return .none") {
                    let value: [String: Float]? = bundle.getDictionary(from: "Nonexistant Key !")
                    expect(value).to(beNil())
                }
                
            }
            
        }
        
    }

}
