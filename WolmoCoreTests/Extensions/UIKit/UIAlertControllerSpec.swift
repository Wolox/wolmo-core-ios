//
//  UIAlertControllerSpec.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/15/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class UIAlertControllerSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#init") {
            
            context("When providing a ConfirmationAlertViewModel") {
                
                var confirmationAlertViewModel: ConfirmationAlertViewModel!
                
                var alertController: UIAlertController!
                
                beforeEach {
                    confirmationAlertViewModel = ConfirmationAlertViewModel(
                        title: "title",
                        message: "message",
                        dismissButtonTitle: "dismiss",
                        dismissAction: { _ in },
                        confirmButtonTitle: "confirm",
                        confirmAction: { _ in })
                    
                    alertController = UIAlertController(alertViewModel: confirmationAlertViewModel)
                    
                }
                
                it("should return confirmationAlertViewModel's title") {
                    expect(alertController.title).to(equal(confirmationAlertViewModel.title))
                }
                
                it("should return confirmationAlertViewModel's message") {
                    expect(alertController.message).to(equal(confirmationAlertViewModel.message))
                }
                
                it("should return confirmationAlertViewModel's confirm button title") {
                    expect(alertController.actions[0].title).to(equal(confirmationAlertViewModel.dismissButtonTitle))
                }
                
                it("should return confirmationAlertViewModel's dismiss button title") {
                    expect(alertController.actions[1].title).to(equal(confirmationAlertViewModel.confirmButtonTitle))
                }
                
                it("should have two possible actions: dismiss and confirm") {
                    expect(alertController.actions.count).to(equal(2))
                }
            }
        }
    }
}
