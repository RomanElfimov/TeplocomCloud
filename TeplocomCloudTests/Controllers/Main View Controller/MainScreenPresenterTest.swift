//
//  MainScreenPresenterTest.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 12.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MainScreenPresenterTest: XCTestCase {

    // MARK: - Private Properties

    private var sut: MainScreenPresenter!
    private var viewController: MainScreenDisplayLogicSpy!

    // MARK: - Lifecycle

    override func setUp() {
      super.setUp()
        let mainPresenter = MainScreenPresenter()
        let mainViewController = MainScreenDisplayLogicSpy()

        mainPresenter.viewController = mainViewController

        sut = mainPresenter
        viewController = mainViewController
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testPresentData() {
        let data = HotDataBackendModel(installedFirmwareVersion: "Foo", needUpdateFirmware: false, firmwareReflashingNow: false, gsmBalance: 0, gsmRssi: 1, powerSupplyVoltage: true, batteryVoltage: false, centralHeating: 2, domesticHotWater: 3, indoor: 4, outdoor: "Foo", mode: "Bar", boilerState: false)
        sut.presentData(event: .presentHotData(data: data))

        XCTAssertTrue(viewController.isCalledViewController)
        XCTAssertEqual(viewController.boilerStateOnOff, false)
    }
}
