//
//  UIAlertController.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    /**
     Builds a UIAlertController from a ConfirmationAlertViewModel
     
     - parameter alertViewModel: Models a ConfirmationAlertViewModel
     - seealso: ConfirmationAlertViewModel
    */
    public convenience init(alertViewModel: ConfirmationAlertViewModel) {
        self.init(title: alertViewModel.title,
                  message: alertViewModel.message,
                  preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: alertViewModel.confirmButtonTitle, style: .default) { _ in
            alertViewModel.confirmAction(alertViewModel)
        }
        
        let dismissAction = UIAlertAction(title: alertViewModel.dismissButtonTitle, style: .default) { _ in
            alertViewModel.dismissAction(alertViewModel)
        }
        
        addAction(dismissAction)
        addAction(confirmAction)
    }
    
    /**
     Builds a UIAlertController from an ErrorAlertViewModel
     
     - parameter alertViewModel: Models an ErrorAlertViewModel
     - seealso: ErrorAlertViewModel
     */
    public convenience init(alertViewModel: ErrorAlertViewModel) {
        self.init(title: alertViewModel.title,
                  message: alertViewModel.message,
                  preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: alertViewModel.dismissButtonTitle, style: .default) { _ in
            alertViewModel.dismissAction(alertViewModel)
        }
        addAction(dismissAction)
        
    }
    
}
