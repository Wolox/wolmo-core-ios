//
//  NSURL.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
 Appends a string to an URL.
 
 - parameter baseURL: base URL.
 - parameter pathComponent: path that will be appended.
 
 - returns: The new NSURL, with pathComponent appended to baseURL
 */
public func / (baseURL: NSURL, pathComponent: String) -> NSURL? {
    return baseURL.URLByAppendingPathComponent(pathComponent)
}

/**
 Appends an int to an URL.
 
 - parameter baseURL: base URL.
 - parameter pathComponent: Int number that will be appended.
 
 - returns: The new NSURL, with pathComponent appended to baseURL
 */
public func / (baseURL: NSURL, pathComponent: Int) -> NSURL? {
    return baseURL / String(pathComponent)
}

public extension NSURL {
    
    /**
     Returns if the URL is of type HTTP protocol.
    */
    public var isHTTPProtocol: Bool {
        
        guard let absoluteString = absoluteString else {
            return false
        }
        
        return absoluteString
                .lowercaseString
                .substringToIndex(absoluteString.startIndex.advancedBy(5)) // We want HTTP (4) or HTTPS(5)
                .rangeOfString("http") != nil
    }
    
    /**
     Returns if the URL contains the specified subDirectory.
     
     - parameter subDirectory: The subDirectory to look for.
    */
    public func contains(subDirectory subDirectory: String) -> Bool {
        return pathComponents?.contains(subDirectory) ?? false
    }
    
}
