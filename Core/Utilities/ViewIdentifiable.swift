//
//  ViewIdentifiable.swift
//  Core
//
//  Created by Pablo Giorgi on 4/13/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit

/**
 Identifies a view
 */
public protocol IdentifiableView {
    
    static var viewIdentifier: String { get }
    
}

extension UIView: IdentifiableView {
    /**
     Returns the identifier of the class. It is the name of the class.
     */
    public static var viewIdentifier: String { return String(describing: self) }
    
}
