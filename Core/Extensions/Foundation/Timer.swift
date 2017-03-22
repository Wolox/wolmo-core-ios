//
//  Timer.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension Timer {
    
    /**
     schedule: Creates and schedules a one-time `NSTimer` instance.
     
     - parameter delay: The delay before execution.
     - parameter handler: A closure to execute after `delay`.
     
     - note: Timer doesn't need to be invalidated after using this function.
     - seealso: CFRunLoopTimerCreateWithHandler()
     - returns: The newly-created `NSTimer` instance.
     */
    public static func schedule(withDelay delay: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer: Timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    
    /**
     schedule: Creates and schedules a repeating `NSTimer` instance.
     
     - parameter repeatInterval: The interval between each execution of `handler`.
     Note that individual calls may be delayed; subsequent calls to `handler` will be
     based on the time the `NSTimer` was created.
     - parameter handler: A closure to execute after each `repeatInterval`.
     
     - warning: Timer should be invalidated after using this function. 
     Use `timer.invalidate()`
     - returns: The newly-created `NSTimer` instance.
     */
    public static func schedule(repeatInterval interval: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer: Timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    
}
