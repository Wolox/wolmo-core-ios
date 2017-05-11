//
//  ErrorAlertViewModel.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
 ErrorAlertViewModel models a `UIAlertController` used to report and error alert.
 */
public struct ErrorAlertViewModel {
    
    public let title: String
    public let message: String
    public let dismissButtonTitle: String
    public let dismissAction: (ErrorAlertViewModel) -> Void
    
    /**
     Initialize a new ErrorAlertViewModel with the provided parameters.
     
     - parameter title: The alert title.
     - parameter message: The alert message.
     - parameter dismissButtonTitle: The dismiss button title.
     - parameter dismissAction: The dismiss button action.
     */
    public init(
        title: String,
        message: String,
        dismissButtonTitle: String = DefaultDismissButtonTitleKey.localized(),
        dismissAction: @escaping (ErrorAlertViewModel) -> Void = { _ in }) {
        self.title = title
        self.message = message
        self.dismissAction = dismissAction
        self.dismissButtonTitle = dismissButtonTitle
    }
    
    /**
     Default title key for dismiss button. It will fetch the localized value from the corresponding strings file
     in the main bundle. So you'll have to add this key and give it a value in your Localizable.strings file.
     You can provide a different key by changing this property.
     
     - seealso: Localizable.String
     */
    public static var DefaultDismissButtonTitleKey: String = "error-alert-view.dismiss.title"
}
