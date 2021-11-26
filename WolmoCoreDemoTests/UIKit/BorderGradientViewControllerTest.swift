//
//  BorderGradientViewControllerTest.swift
//  WolmoCoreDemoTests
//
//  Created by nicolas.e.manograsso on 25/11/2021.
//  Copyright © 2021 Wolox. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import WolmoCoreDemo

class BorderGradientViewControllerTest: XCTestCase {
    func testView() {
        let sut = BorderGradientViewController()
        assertSnapshot(matching: sut, as: .image(on: .iPhone8))
    }
}
