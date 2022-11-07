//
//  LoginBackendModelTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 06.10.2022.
//

import XCTest
@testable import TeplocomCloud

class LoginBackendModelTests: XCTestCase {

    // MARK: - System Under Test

    var sut: LoginBackendModel!
    var esiaSut: ServiceFeedbackModel!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        esiaSut = ServiceFeedbackModel(jwt: "Foo", refreshToken: "Bar", error: "Baz")
        sut = LoginBackendModel(confirmedEmail: true, esia: esiaSut, registered: true, error: "Foo")
    }

    override func tearDown() {
        sut = nil
        esiaSut = nil
        super.tearDown()
    }

    // MARK: - Model Not Nil

    func testInitModelWithConfirmedEmail() {
        sut = LoginBackendModel(confirmedEmail: true)
        XCTAssertNotNil(sut)
    }

    func testInitModelWithConfirmedEmailAndEsia() {
        sut = LoginBackendModel(confirmedEmail: true, esia: esiaSut)
        XCTAssertNotNil(sut)
    }

    func testInitModelWithConfirmedEmailAndEsiaAndRegistered() {
        sut = LoginBackendModel(confirmedEmail: true, esia: esiaSut, registered: true)
        XCTAssertNotNil(sut)
    }

    func testInitModelWithConfirmedEmailAndEsiaAndRegisteredAndError() {
        sut = LoginBackendModel(confirmedEmail: true, esia: esiaSut, registered: true, error: "Foo")
        XCTAssertNotNil(sut)
    }

    // MARK: - Given Data Sets To

    func testWhenGivenConfimedEmailSetsToConfimedEmail() {
        XCTAssertEqual(sut.confirmedEmail, true)
    }

    func testWhenGivenEsiaSetsToEsia() {
        XCTAssertEqual(sut.esia, esiaSut)
    }

    func testWhenGivenRegisteredSetsToRegistered() {
        XCTAssertEqual(sut.registered, true)
    }

    func testWhenGivenErrorSetsToError() {
        XCTAssertEqual(sut.error, "Foo")
    }
}
