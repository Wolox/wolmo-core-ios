//
//  ResultSpec.swift
//  CoreTests
//
//  Created by Daniela Riesgo on 1/19/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Quick
import Nimble
import Result
import ReactiveSwift
import Core

public class ResultSpec: QuickSpec {

    override public func spec() {

        describe("#event") {

            context("When it's a value") {

                it("should return the value as a signal event") {
                    let result = Result<Int, NSError>(value: 3)
                    let test = result.event
                    expect(test.value).to(equal(3))
                }

            }

            context("When it's an error") {

                it("should return the error as a signal event") {
                    let error = NSError(domain: "MyDomain", code: 2, userInfo: .none)
                    let result = Result<Int, NSError>(error: error)
                    let test = result.event
                    expect(test.error).to(equal(error))
                }

            }

        }

    }

}
