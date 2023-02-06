//
//  BindedDevicesPresenterTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 13.10.2022.
//

import XCTest
@testable import TeplocomCloud

class BindedDevicesPresenterTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: BindedDevicesPresenter!
    private var viewController: BindedDevicesDisplayLogicSpy!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let bindedDevicesPresenter = BindedDevicesPresenter()
        let bindedDevicesViewController = BindedDevicesDisplayLogicSpy()

        bindedDevicesPresenter.viewController = bindedDevicesViewController

        sut = bindedDevicesPresenter
        viewController = bindedDevicesViewController
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testPresentData() {
        let data = BindedDevicesBackendModel(clientName: "Foo", description: "Bar", status: false, type: "Baz", uid: "Foo")
        sut.presentData(event: .presentBindedDevices(data: [data]))

        let viewModel = BindedDevicesViewModel(name: data.clientName, status: data.status, uid: data.uid)

        XCTAssertTrue(viewController.isCalledController)
        XCTAssertEqual(viewController.bindedDevicesArray, [viewModel])
    }

}
