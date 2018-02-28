//
//  ErrorAlertViewModelSpec.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import WolmoCore

public class ErrorAlertViewModelSpec: QuickSpec {
    
    override public func spec() {
        
        var defaultErrorAlertViewModel: ErrorAlertViewModel!
        
        var errorAlertViewModel: ErrorAlertViewModel!
        
        var dismissActionCalled: Bool!
        
        beforeEach {
            defaultErrorAlertViewModel = ErrorAlertViewModel(
                title: "title",
                message: "message")
            
            errorAlertViewModel = ErrorAlertViewModel(
                title: "title",
                message: "message",
                dismissButtonTitle: "cancel",
                dismissAction: { _ in dismissActionCalled = true })
            
            dismissActionCalled = false
        }
        
        describe("#title") {
            
            it("should return the confirmationAlertViewModel's title") {
                expect(errorAlertViewModel.title).to(equal("title"))
            }
            
        }
        
        describe("#message") {
            
            it("should return the confirmationAlertViewModel's message") {
                expect(errorAlertViewModel.message).to(equal("message"))
            }
        }
        
        describe("#dismissButtonTitle") {
            
            context("When using the default parameter") {
                
                it("should match the localized value of #DefaultDismissButtonTitleKey") {
                    let defaultTitle = ErrorAlertViewModel.DefaultDismissButtonTitleKey.localized()
                    let title = defaultErrorAlertViewModel.dismissButtonTitle
                    expect(defaultTitle).to(equal(title))
                }
            }
            
            context("When providing a #dismissButtonTitle") {
                
                it("should return the #dismissButtonTitle provided") {
                    let title = errorAlertViewModel.dismissButtonTitle
                    expect(title).to(equal("cancel"))
                }
            }
        }
        
        describe("#dismissAction") {
            
            context("When using the default parameter") {
                
                it("should do nothing") {
                    defaultErrorAlertViewModel.dismissAction(defaultErrorAlertViewModel)
                    expect(dismissActionCalled).to(beFalse())
                }
            }
            
            context("When providing a #dismissAction") {
                
                it("should execute the #dismissAction provided") {
                    errorAlertViewModel.dismissAction(errorAlertViewModel)
                    expect(dismissActionCalled).to(beTrue())
                }
            }
            
        }
        
        describe("#DefaultDismissButtonTitleKey") {
            // TODO: Complete this spec when adding localization
        }
        
    }
}
