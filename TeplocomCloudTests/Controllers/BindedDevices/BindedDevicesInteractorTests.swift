//
//  BindedDevicesInteractorTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 13.10.2022.
//

import XCTest
@testable import TeplocomCloud

class BindedDevicesInteractorTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: BindedDevicesInteractor!
    private var presenter: BindedDevicesPresentationLogicSpy!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let bindedDevicesInteractor = BindedDevicesInteractor()
        let bindedDevicesPresenter = BindedDevicesPresentationLogicSpy()

        bindedDevicesInteractor.presenter = bindedDevicesPresenter

        sut = bindedDevicesInteractor
        presenter = bindedDevicesPresenter
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }

    // MARK: - Public Method

    func testMakeRequest() {
        sut.makeRequest(event: .fetchBindedDevices)
        XCTAssertTrue(presenter.isCalledPresenter)
    }

}
