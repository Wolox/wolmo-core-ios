//
//  TimerSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class TimerSpec: QuickSpec {
    
    override public func spec() {
        
        var timer: Timer!
        
        afterEach {
            timer!.invalidate()
            timer = .none
        }
        
        describe("#schedule(withDelay:)") {
            
            it("should trigger handler after delay") { waitUntil(timeout: 2) { done in
                timer = Timer.schedule(withDelay: 1) { _ in
                    done()
                }
            }}
        }
        
        describe("#schedule(repeatInterval:)") {
            
            it("should repeteadly trigger handler after delay") { waitUntil(timeout: 5) { done in
                var timesCalled = 0
                
                timer = Timer.schedule(repeatInterval: 1) { _ in
                    timesCalled += 1
                    if timesCalled == 2 {
                        done()
                    }
                }
            }}
        }
    }
}
