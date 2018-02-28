//
//  AVAsset.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import AVFoundation
import ReactiveSwift
import Result

public extension AVAsset {
    
    /**
     Tells the asset to load the values of any of the specified keys that are not already loaded.
     
     - parameter keys: The keys to load
     
     - returns: SignalProducer which sends a dictionary of the key and the status for each key.
        It can be an AVKeyValueStatus or an Error.
     - seealso: loadValuesAsynchronouslyForKeys(keys, completionHandler)
    */
    public func loadValuesAsynchronously(forKeys keys: [String]) -> SignalProducer<[String: Result<AVKeyValueStatus, NSError>], NoError> {
        return SignalProducer { observer, _ in
            self.loadValuesAsynchronously(forKeys: keys, completionHandler: { 
                var keysStatus: [String: Result<AVKeyValueStatus, NSError>] = [:]
                
                for key in keys {
                    var error: NSError?
                    
                    let status = self.statusOfValue(forKey: key, error: &error)
                    
                    // The documentation states that if a .Failed is received, then statusOfValueForKey reports it in error parameter.
                    if status == .failed, let error = error {
                        keysStatus[key] = Result(error: error)
                    } else {
                        keysStatus[key] = Result(status)
                    }
                }
                observer.send(value: keysStatus)
                observer.sendCompleted()
            })
        }
    }
}
