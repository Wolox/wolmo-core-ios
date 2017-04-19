//
//  UIViewController.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /**
     Toggles the visibility of the status and tabBar.
     */
    public var hideBars: Bool {
        set {
            setBarsHidden(newValue)
        }
        
        get {
            return false
        }
    }
    
    /**
     Loads the childViewController into the specified containerView.
     
     It can be done after self's view is initialized, as it uses constraints to determine the childViewController size.
     Take into account that self will retain the childViewController, so if for any other reason the childViewController is retained in another place, this would
     lead to a memory leak. In that case, one should call unloadViewController().
     
     - parameter childViewController: The controller to load.
     - parameter into: The containerView into which the controller will be loaded.
     - parameter viewPositioning: Back or Front. Default: Front
     */
    public func load(childViewController: UIViewController, into containerView: UIView, viewPositioning: ViewPositioning = .front) {
        childViewController.willMove(toParentViewController: self)
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
        childViewController.view.add(into: containerView, viewPositioning: viewPositioning)
    }
    
    /**
     Unloads a childViewController and its view from its parentViewController.
     */
    public func unloadFromParentViewController() {
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
    /**
     Unloads all childViewController and their view from self.
     */
    public func unloadChildViewControllers() {
        for childController in self.childViewControllers {
            childController.unloadFromParentViewController()
        }
    }
    
}

private extension UIViewController {
    
    func setBarsHidden(_ hidden: Bool) {
        tabBarController?.tabBar.isHidden = hidden
        UIApplication.shared.isStatusBarHidden = hidden
    }
    
}
