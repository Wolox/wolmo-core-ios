//
//  AVPlayerItem.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import AVFoundation
import ReactiveSwift
import enum Result.NoError

public extension AVPlayerItem {
    
    /**
     Moves the playback cursor to a given time.
     
     - parameter time: The time to which to seek.
     
     - seealso: seekToTime(time, completionHandler)
     */
    public func seek(to time: CMTime) -> SignalProducer<Bool, NoError> {
        return SignalProducer { observer, _ in
            self.seek(to: time) {
                observer.send(value: $0)
                observer.sendCompleted()
            }
        }
    }
    
}
