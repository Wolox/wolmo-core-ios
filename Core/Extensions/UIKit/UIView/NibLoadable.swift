//
//  NibLoadable.swift
//  Core
//
//  Created by Francisco Depascuali on 7/6/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/*
 Represents an object which is loaded from a nib.
 */
public protocol NibLoadable {
    
    /**
        Name of Nib to load component from.
        By default, the type's simple name.
     */
    static var nibName: String { get }

    /**
        Bundle from where to load the nib.
        By default, the main bundle;
        except for classes, it defaults to the class' bundle.
    */
    static var nibBundle: Bundle { get }

}

public extension NibLoadable {
    
    static var nibName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    static var nibBundle: Bundle {
        if let classSelf = self as? AnyClass {
            return Bundle(for: classSelf.self)
        }
        return Bundle.main
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
    
    /**
     Loads the nib for the specific component.
     */
    public static func loadFromNib<T>() -> T? {
        return nibBundle.loadNib(named: nibName)
    }
    // Using generics because using Self makes it impossible to
    //   provide default implementations for non-final classes.
    
}

extension UITableViewCell: NibLoadable {}
extension UICollectionReusableView: NibLoadable {}
