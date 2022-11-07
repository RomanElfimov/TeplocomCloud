//
//  AuthCodeBackendModelTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 06.10.2022.
//

import XCTest
@testable import TeplocomCloud

class AuthCodeBackendModelTests: XCTestCase {

    // MARK: - System Under Test

    var sut: AuthCodeBackendModel!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = AuthCodeBackendModel(floodWait: 0, error: "Foo")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Model Not Nil

    func testInitModelWithFloodWait() {
        sut = AuthCodeBackendModel(floodWait: 0)
        XCTAssertNotNil(sut)
    }

    func testInitModelWithFloodWaitAndError() {
        sut = AuthCodeBackendModel(floodWait: 0, error: "Foo")
        XCTAssertNotNil(sut)
    }

    // MARK: - Given Data Sets To

    func testWhenGivenFloodWaitSetsToFloodWait() {
        XCTAssertEqual(sut.floodWait, 0)
    }

    func testWhenGivenErrorSetsToError() {
        XCTAssertEqual(sut.error, "Foo")
    }
}
