//
//  HotDataBackendModelTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 06.10.2022.
//

import XCTest
@testable import TeplocomCloud

class HotDataBackendModelTests: XCTestCase {

    // MARK: - System Under Test

    var sut: HotDataBackendModel!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = HotDataBackendModel(installedFirmwareVersion: "Foo", needUpdateFirmware: true, firmwareReflashingNow: true, gsmBalance: 0, gsmRssi: 1, powerSupplyVoltage: true, batteryVoltage: false, centralHeating: 2, domesticHotWater: 3, indoor: 4, outdoor: "Bar", mode: "Baz", setPoint: 5, boilerState: true)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Model Not Nil

    func testInitModeWithNonOptionalValues() {
        sut = HotDataBackendModel(installedFirmwareVersion: "Foo", needUpdateFirmware: true, firmwareReflashingNow: true, gsmBalance: 0, gsmRssi: 1, powerSupplyVoltage: true, batteryVoltage: false, centralHeating: 2, domesticHotWater: 3, indoor: 4, outdoor: "Bar", mode: "Baz", setPoint: 5, boilerState: true)
        XCTAssertNotNil(sut)
    }

    func testInitModeWithNonOptionalValuesAndSetPoint() {
        sut = HotDataBackendModel(installedFirmwareVersion: "Foo", needUpdateFirmware: true, firmwareReflashingNow: true, gsmBalance: 0, gsmRssi: 1, powerSupplyVoltage: true, batteryVoltage: false, centralHeating: 2, domesticHotWater: 3, indoor: 4, outdoor: "Bar", mode: "Baz", setPoint: 5, boilerState: true)
        XCTAssertNotNil(sut)
    }

    func testInitModeWithNonOptionalValuesAndSetPointAndBoilerState() {
        sut = HotDataBackendModel(installedFirmwareVersion: "Foo", needUpdateFirmware: true, firmwareReflashingNow: true, gsmBalance: 0, gsmRssi: 1, powerSupplyVoltage: true, batteryVoltage: false, centralHeating: 2, domesticHotWater: 3, indoor: 4, outdoor: "Bar", mode: "Baz", setPoint: 5, boilerState: true)
        XCTAssertNotNil(sut)
    }

    // MARK: - Given Data Sets To

    func testWhenGivenInstalledFirmwareVersionSetsToInstalledFirmwareVersion() {
        XCTAssertEqual(sut.installed_firmware_version, "Foo")
    }

    func testWhenGivenNeedUpdateFirmwareSetsToNeedUpdateFirmware() {
        XCTAssertEqual(sut.need_update_firmware, true)
    }

    func testWhenGivenFirmwareReflashingNowSetsToFirmwareReflashingNow() {
        XCTAssertEqual(sut.firmware_reflashing_now, true)
    }

    func testWhenGivenGSMBalanceSetsToGSMBalance() {
        XCTAssertEqual(sut.gsmBalance, 0)
    }

    func testWhenGivenGSMRssiSetsToGSMRssi() {
        XCTAssertEqual(sut.gsmRssi, 1)
    }

    func testWhenGivenPowerSupplyVoltageSetsToPowerSupplyVoltage() {
        XCTAssertEqual(sut.powerSupplyVoltage, true)
    }

    func testWhenGivenBatteryVoltageSetsToBatteryVoltage() {
        XCTAssertEqual(sut.batteryVoltage, false)
    }

    func testWhenGivenCentralHeatingSetsToCentralHeating() {
        XCTAssertEqual(sut.centralHeating, 2)
    }

    func testWhenGivenDomesticHotWaterSetsToDomesticHotWater() {
        XCTAssertEqual(sut.domesticHotWater, 3)
    }

    func testWhenGivenIndoorSetsToIndoor() {
        XCTAssertEqual(sut.indoor, 4)
    }

    func testWhenGivenOutdoorSetsToOutdoor() {
        XCTAssertEqual(sut.outdoor, "Bar")
    }

    func testWhenGivenModeSetsToMode() {
        XCTAssertEqual(sut.mode, "Baz")
    }

    func testWhenGivenSetPointSetsToSetPoint() {
        XCTAssertEqual(sut.setPoint, 5)
    }

    func testWhenGivenBoilerStateSetsToBoilerState() {
        XCTAssertEqual(sut.boilerState, true)
    }
}
