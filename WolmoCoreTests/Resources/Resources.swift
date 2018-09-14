//
//  Resources.swift
//  WolmoCore
//
//  Created by Daniela Riesgo on 4/19/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class NibLoadableCollectionCell: UICollectionViewCell, NibLoadable { }
class NibLoadableCollectionView: UICollectionReusableView, NibLoadable { }

class NibLoadableTableCell: UITableViewCell, NibLoadable { }
class NibLoadableTableView: UITableViewHeaderFooterView, NibLoadable {

    static var nibName: String {
        return "NibLoadableTableViewCustom"
    }

}

class NibLoadableTableViewCustom: UITableViewHeaderFooterView, NibLoadable {
    
    // Testing with a class that's outside of our framework, it could be any class from outside
    static var nibBundle: Bundle {
        return Bundle(for: UIViewController.self)
    }
    
}

class NibLoadableTableViewCustom2: UITableViewHeaderFooterView, NibLoadable {
    
    static var nibName: String {
        return "NibLoadableTableViewCustom"
    }
    
}

struct NibLoadableStruct: NibLoadable { }

class NibLoadableUICollectionView: UICollectionView, NibLoadable { }
class NibLoadableUITableView: UITableView, NibLoadable { }
