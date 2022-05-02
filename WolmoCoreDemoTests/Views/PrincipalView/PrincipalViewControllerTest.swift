//
//  PrincipalViewControllerTest.swift
//  WolmoCoreDemoTests
//
//  Created by nicolas.e.manograsso on 01/05/2022.
//  Copyright © 2022 Wolox. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import WolmoCoreDemo

final class PrincipalViewControllerTest: XCTestCase {
    func testView() {
        let sut = PrincipalViewController()
        assertSnapshot(matching: sut, as: .image(on: .iPhone8))
    }
}
