//
//  ConfirmationAlertViewModel.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import WolmoCore

public class ConfirmationAlertViewModelSpec: QuickSpec {
    override public func spec() {
        var defaultConfirmationAlertViewModel: ConfirmationAlertViewModel!
        var confirmationAlertViewModel: ConfirmationAlertViewModel!
        var dismissActionCalled: Bool!
        var confirmActionCalled: Bool!
        
        beforeEach {
            defaultConfirmationAlertViewModel = ConfirmationAlertViewModel(title: "title",
                                                                           message: "message")
            confirmationAlertViewModel = ConfirmationAlertViewModel(title: "title",
                                                                    message: "message",
                                                                    dismissButtonTitle: "cancel",
                                                                    dismissAction: { _ in dismissActionCalled = true },
                                                                    confirmButtonTitle: "confirm",
                                                                    confirmAction: { _ in confirmActionCalled = true })
            dismissActionCalled = false
            confirmActionCalled = false
        }
        
        describe("#title") {
            it("should return the confirmationAlertViewModel's title") {
                expect(confirmationAlertViewModel.title).to(equal("title"))
            }
        }
        
        describe("#message") {
            it("should return the confirmationAlertViewModel's message") {
                expect(confirmationAlertViewModel.message).to(equal("message"))
            }
        }
        
        describe("#dismissButtonTitle") {
            context("When using the default parameter") {
                it("should match the localized value of #DefaultDismissButtonTitleKey") {
                    let defaultTitle = ConfirmationAlertViewModel.DefaultDismissButtonTitleKey.localized()
                    let title = defaultConfirmationAlertViewModel.dismissButtonTitle
                    expect(defaultTitle).to(equal(title))
                }
            }
            
            context("When providing a #dismissButtonTitle") {
                it("should return the #dismissButtonTitle provided") {
                    let title = confirmationAlertViewModel.dismissButtonTitle
                    expect(title).to(equal("cancel"))
                }
            }
        }
        
        describe("#confirmButtonTitle") {
            context("When using the default parameter") {
                it("should match the localized value of #DefaultConfirmButtonTitleKey") {
                    let defaultTitle = ConfirmationAlertViewModel.DefaultConfirmButtonTitleKey.localized()
                    let title = defaultConfirmationAlertViewModel.confirmButtonTitle
                    expect(defaultTitle).to(equal(title))
                }
            }
            
            context("When providing a #confirmButtonTitle") {
                it("should return the #confirmButtonTitle provided") {
                    let title = confirmationAlertViewModel.confirmButtonTitle
                    expect(title).to(equal("confirm"))
                }
            }
        }
        
        describe("#dismissAction") {
            context("When using the default parameter") {
                it("should do nothing") {
                    defaultConfirmationAlertViewModel.dismissAction(defaultConfirmationAlertViewModel)
                    expect(dismissActionCalled).to(beFalse())
                }
            }
            
            context("When providing a #dismissAction") {
                it("should execute the #dismissAction provided") {
                    confirmationAlertViewModel.dismissAction(defaultConfirmationAlertViewModel)
                    expect(dismissActionCalled).to(beTrue())
                }
            }

        }
        
        describe("#confirmAction") {
            context("When using the default parameter") {
                it("should do nothing") {
                    defaultConfirmationAlertViewModel.confirmAction(defaultConfirmationAlertViewModel)
                    expect(confirmActionCalled).to(beFalse())
                }
            }
            
            context("When providing a #dismissAction") {
                it("should execute the #dismissAction provided") {
                    confirmationAlertViewModel.confirmAction(defaultConfirmationAlertViewModel)
                    expect(confirmActionCalled).to(beTrue())
                }
            }
        }
        
        describe("#DefaultDismissButtonTitleKey") {
            // TODO: Complete this spec when adding localization
        }
        
        describe("#DefaultConfirmButtonTitleKey") {
            // TODO: Complete this spec when adding localization
        }
    }
}
