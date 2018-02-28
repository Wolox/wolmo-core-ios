//
//  URL.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public extension URL {
    
    /**
     Returns if the URL is of type HTTP protocol.
    */
    public var isHTTPProtocol: Bool {
        return absoluteString.lowercased().hasPrefix("http")
    }
    
    /**
     Returns if the URL is of type HTTPS protocol.
     */
    public var isHTTPSProtocol: Bool {
        return absoluteString.lowercased().hasPrefix("https")
    }
    
    /**
     Returns if the URL contains the specified subDirectory.
     
     - parameter subDirectory: The subDirectory to look for.
    */
    public func contains(subDirectory: String) -> Bool {
        return pathComponents.contains(subDirectory) 
    }
    
}

extension URL: ExpressibleByStringLiteral {
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        guard let url = URL(string: "\(value)") else {
            fatalError("The URL \(value) is invalid")
        }
        self = url
    }
    
}
