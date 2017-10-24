//
//  ProgressHUDDelegate.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/19/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import MBProgressHUD

/**
 ProgressHUDDelegate abstracts the logic of presenting a progress HUD, usually used in blocking operation, just as sign up.
 */
public protocol ProgressHUDDelegate: class {
    
    /**
     Shows a progress hud.
     
     - parameter labelText: A label text to be shown under the progress hud.
    */
    func showProgressHud(withText text: String?)
    
    /**
     Hides the progress hud.
    */
    func hideProgressHud()
    
}

extension UIViewController: ProgressHUDDelegate {
    
    /**
     Show a progress hud attached to the viewController's view.
     - parameter labelText: A label text to be shown under the progress hud.
     - Warning: Showing a progress hud freezes the viewController's view.
     */
    public func showProgressHud(withText text: String? = .none) {
        let progressHUD: MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        
        if let labelText = text {
            progressHUD.label.text = labelText
        }
    }
    
    /**
     Hides the view associated with the ViewController.
     */
    public func hideProgressHud() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}
