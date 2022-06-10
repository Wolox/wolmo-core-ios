//
//  Optional.swift
//  WolmoCore
//
//  Created by juan.martin.gordo on 31/05/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    /// Returns a boolean value determining whether the optional collection is either empty or `nil`.
    public var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
