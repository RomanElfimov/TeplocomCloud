//
//  BindedDevicesTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 06.10.2022.
//

import XCTest
@testable import TeplocomCloud

class BindedDevicesBackendModelTests: XCTestCase {

    // MARK: - System Under Test

    var sut: BindedDevicesBackendModel!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = BindedDevicesBackendModel(clientName: "Foo", description: "Bar", status: true, type: "Baz", uid: "Foo")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Model Not Nil

    func testInitModelWithData() {
        XCTAssertNotNil(sut)
    }

    // MARK: - Given Data Sets To

    func testWhenGivenClientNameSetsToClientName() {
        XCTAssertEqual(sut.clientName, "Foo")
    }

    func testWhenGivenDescriptionSetsToDescription() {
        XCTAssertEqual(sut.description, "Bar")
    }

    func testWhenGivenStatusSetsToStatus() {
        XCTAssertEqual(sut.status, true)
    }

    func testWhenGivenTypeSetsToType() {
        XCTAssertEqual(sut.type, "Baz")
    }

    func testWhenGivenUIDSetsToUID() {
        XCTAssertEqual(sut.uid, "Foo")
    }

}
