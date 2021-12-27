//
//  AlertPresenter.swift
//  SonicWords
//
//  Created by Francisco Depascuali on 5/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
 AlertViewPresenter abstracts the logic of presenting different type of alerts.
 */
public protocol AlertViewPresenter {

    /// Presents a new alert. The alert's information is stored in the ErrorAlertViewModel passed by parameter.
    func presentAlert(_ alertViewModel: ErrorAlertViewModel, completion: (() -> Void)?)
    
    /// Presents a new alert. The alert's information is stored in the ConfirmationAlertViewModel passed by parameter.
    func presentAlert(_ alertViewModel: ConfirmationAlertViewModel, completion: (() -> Void)?)
    
}

extension UIViewController: AlertViewPresenter {
    
    /**
     Presents a new alert. The alert's information is stored in the ErrorAlertViewModel passed by parameter.
     
     - Parameter alertViewModel: ErrorAlertViewModel.
     - Parameter completion: Closure that fires when the alert is shown.
     - Warning: The closure is fired *when* the alert is shown, it is not related to the dismiss/confirmation.
     Dismiss and confirmation callbacks can be set on the `ErrorAlertViewModel`.
     - Seealso: `ErrorAlertViewModel`
     */
    public func presentAlert(_ alertViewModel: ErrorAlertViewModel, completion: (() -> Void)? = .none) {
        let alert = UIAlertController(alertViewModel: alertViewModel)
        present(alert, animated: true, completion: completion)
    }
    
    /**
     Presents a new alert. The alert's information is stored in the ConfirmationAlertViewModel passed by parameter.
     
     - Parameter alertViewModel: ConfirmationAlertViewModel.
     - Parameter completion: Closure that fires when the alert is shown.
     - Warning: The closure is fired *when* the alert is shown, it is not related to the dismiss/confirmation.
     Dismiss and confirmation callbacks can be set on the `ConfirmationAlertViewModel`.
     - Seealso: `ConfirmationAlertViewModel`.
     */
    public func presentAlert(_ alertViewModel: ConfirmationAlertViewModel, completion: (() -> Void)? = .none) {
        let alert = UIAlertController(alertViewModel: alertViewModel)
        present(alert, animated: true, completion: completion)
    }
    
}
