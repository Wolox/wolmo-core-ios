//
//  ConfirmationAlertViewModel.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
 ConfirmationAlertViewModel models a `UIAlertController` that can be confirmed or dismissed.
 */
public struct ConfirmationAlertViewModel {
    
    public let title: String?
    public let message: String?
    public let dismissButtonTitle: String
    public let confirmButtonTitle: String
    public let dismissAction: (ConfirmationAlertViewModel) -> Void
    public let confirmAction: (ConfirmationAlertViewModel) -> Void
    
    /**
     Initialize a new ConfirmationAlertViewModel with the provided parameters.
     
     - parameter title: The alert title.
     - parameter message: The alert message.
     - parameter dismissButtonTitle: The dismiss button title.
     - parameter dismissAction: The dismiss button action.
     - parameter confirmButtonTitle: The confirm button title.
     - parameter confirmAction: The confirm button action.
     */
    public init(
        title: String? = "",
        message: String? = .none,
        dismissButtonTitle: String = DefaultDismissButtonTitleKey.localized(),
        dismissAction: @escaping (ConfirmationAlertViewModel) -> Void = { _ in },
        confirmButtonTitle: String = DefaultConfirmButtonTitleKey.localized(),
        confirmAction: @escaping (ConfirmationAlertViewModel) -> Void = { _ in }) {
        self.title = title
        self.message = message
        self.confirmAction = confirmAction
        self.dismissAction = dismissAction
        self.dismissButtonTitle = dismissButtonTitle
        self.confirmButtonTitle = confirmButtonTitle
    }
    
    /**
     Default title key for confirm button. It will fetch the localized value from the Localizable.strings file
     in the main bundle. So you'll have to add this key and give it a value in your Localizable.strings file.
     You can provide a different key by changing this property.
     
     - seealso: Localizable.String
     */
    public static var DefaultConfirmButtonTitleKey: String = "confirmation-alert-view.dismiss.title"
    
    /**
     Default title key for dismiss button. It will fetch the localized value from the Localizable.strings file
     in the main bundle. So you'll have to add this key and give it a value in your Localizable.strings file.
     You can provide a different key by changing this property.
     
     - seealso: Localizable.String
     */
    public static var DefaultDismissButtonTitleKey: String = "confirmation-alert-view.confirm.title"
}
