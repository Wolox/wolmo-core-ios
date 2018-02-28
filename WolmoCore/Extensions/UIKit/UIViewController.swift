//
//  UIViewController.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UIViewController {
    
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
        childViewController.view.add(into: containerView, in: viewPositioning)
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

// MARK: - Navigation Bar

public extension UIViewController {

    /**
     Configures the navigation bar to have a particular image as back button.
     - parameter image: The image of the back button.
     - warning: This function must be called when self is inside a navigation controller. 
            If not it will arise a runtime fatal error.
     */
    public func setNavigationBarBackButton(_ image: UIImage) {
        guard let navigationController = navigationController else { fatalError("There is no navigation controller.") }
        
        navigationController.navigationBar.topItem?.title = ""
        navigationController.navigationBar.backIndicatorImage = image
        navigationController.navigationBar.backIndicatorTransitionMaskImage = image
    }
    
    /**
     Configures the navigation bar color.
     - parameter color: The new color of the navigation bar. 
            This represents the navigation bar background color.
     - warning: This function must be called when self is inside a navigation controller. 
            If not it will arise a runtime fatal error.
     */
    public func setNavigationBarColor(_ color: UIColor) {
        guard let navigationController = navigationController else { fatalError("There is no navigation controller.") }
        
        navigationController.navigationBar.barTintColor = color
    }
    
    /**
     Configures the navigation bar tint color.
     - parameter color: The new tint color of the navigation bar. 
            This represents the color of the left and right button items.
     - warning: This function must be called when self is inside a navigation controller.
            If not it will arise a runtime fatal error.
     */
    public func setNavigationBarTintColor(_ color: UIColor) {
        guard let navigationController = navigationController else { fatalError("There is no navigation controller.") }
        
        navigationController.navigationBar.tintColor = color
    }
    
    /**
     Configures the navigation bar style.
     - parameter style: The new style of the navigation bar.
     - warning: This function must be called when self is inside a navigation controller.
            If not it will arise a runtime fatal error.
     */
    public func setNavigationBarStyle(_ style: UIBarStyle) {
        guard let navigationController = navigationController else { fatalError("There is no navigation controller.") }
        
        navigationController.navigationBar.barStyle = style
    }
    
    /**
     Sets a collection of buttons as the navigation bar left buttons.
     - parameter buttons: the Array of buttons to use.
     */
    public func setNavigationLeftButtons(_ buttons: [UIBarButtonItem]) {
        navigationItem.leftBarButtonItems = buttons
    }
    
    /**
     Sets a collection of buttons as the navigation bar right buttons.
     - parameter buttons: the Array of buttons to use.
     */
    public func setNavigationRightButtons(_ buttons: [UIBarButtonItem]) {
        navigationItem.rightBarButtonItems = buttons
    }

    /**
     Adds and configures a label to use as title of the navigation bar.
     - parameter title: the string of the label.
     - parameter font: the font to use for the label.
     - parameter color: the color of the text.
     */
    public func setNavigationBarTitle(_ title: String, font: UIFont, color: UIColor) {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.font = font
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.text = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
    
    /**
     Adds an ImageView with the image passed as the titleView of the navigation bar.
     - parameter image: The image to set as title.
     */
    public func setNavigationBarTitleImage(_ image: UIImage) {
        navigationItem.titleView = UIImageView(image: image)
    }
    
}
