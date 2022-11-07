//
//  ThermostatViewTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 08.10.2022.
//

import XCTest
@testable import TeplocomCloud

class ThermostatViewTests: XCTestCase {

    // MARK: - System Under Test

    var sut: ThermostatView!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = ThermostatView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    // Содержатся ли элементы интерфейса во view 

    func testHasSensorRoleSegmentControl() {
        XCTAssertNotNil(sut.sensorRoleSegmentControl)
        XCTAssertTrue(sut.sensorRoleSegmentControl.isDescendant(of: sut))
    }

    func testHasCurrentTemperatureDescriptionLabel() {
        XCTAssertNotNil(sut.currentTemperatureDescriptionLabel)
        XCTAssertTrue(sut.currentTemperatureDescriptionLabel.isDescendant(of: sut))
    }

    func testHasCurrentTemperatureValueLabel() {
        XCTAssertNotNil(sut.currentTemperatureValueLabel)
        XCTAssertTrue(sut.currentTemperatureValueLabel.isDescendant(of: sut))
    }

    func testHasTemperatureSettingDescriptionLabel() {
        XCTAssertNotNil(sut.temperatureSettingDescriptionLabel)
        XCTAssertTrue(sut.temperatureSettingDescriptionLabel.isDescendant(of: sut))
    }

    func testHasTemperatureSettingPicker() {
        XCTAssertNotNil(sut.temperatureSettingPicker)
        XCTAssertTrue(sut.temperatureSettingPicker.isDescendant(of: sut))
    }

    func testHasComfortButton() {
        XCTAssertNotNil(sut.comfortButton)
        XCTAssertTrue(sut.comfortButton.isDescendant(of: sut))
    }

    func testHasEcoButton() {
        XCTAssertNotNil(sut.ecoButton)
        XCTAssertTrue(sut.ecoButton.isDescendant(of: sut))
    }

    func testHasExpertSettingsButton() {
        XCTAssertNotNil(sut.expertSettingsButton)
        XCTAssertTrue(sut.expertSettingsButton.isDescendant(of: sut))
    }

    func testHasBottomView() {
        XCTAssertNotNil(sut.bottomView)
        XCTAssertTrue(sut.bottomView.isDescendant(of: sut))
    }

    func testHasConfirmButton() {
        XCTAssertNotNil(sut.confirmButton)
        XCTAssertTrue(sut.confirmButton.isDescendant(of: sut))
    }

    // Содержат ли элементы интерфейса информацию модели данных

    func setupModelAndAppearanceTransition() {
        let model = BoilerViewModel(sensorRole: "indoor", setPoint: 2, centralHeatingTemperature: "Foo", roomTemperature: "Bar")
        sut.setupUI(with: model)
    }

    func testSetsSensorRoleSegmentControl() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.sensorRoleSegmentControl.selectedSegmentIndex, 0)
    }

    func testSetsCurrentTemperatureValueLabel() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.currentTemperatureValueLabel.text, "Bar")
    }

    func testSetsTemperatureSettingPicker() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.temperatureSettingPicker.selectedRow(inComponent: 0), 2)
    }

    // У элементов интерфейса есть acitons

    func testExpertSettingsButtonHasAction() {
        let expertSettingsButton = sut.expertSettingsButton
        guard let actions = expertSettingsButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }

        XCTAssertTrue(actions.contains("expertSettingsButtonTapped"))
    }

    func testConfirmButtonHasAction() {
        let confirmButton = sut.confirmButton
        guard let actions = confirmButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }

        XCTAssertTrue(actions.contains("confirmButtonTapped"))
    }

    func testSensorRoleSegmentControlHasAction() {
        let sensorRoleSegmentControl = sut.sensorRoleSegmentControl
        guard let actions = sensorRoleSegmentControl.actions(forTarget: sut, forControlEvent: .valueChanged) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("sensorRoleSegmentControlTapped:"))
    }

    func testComfortButtonHasAction() {
        let comfortButton = sut.comfortButton
        guard let actions = comfortButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }

        XCTAssertTrue(actions.contains("comfortButtonTapped"))
    }

    func testecoButtonHasAction() {
        let ecoButton = sut.ecoButton
        guard let actions = ecoButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }

        XCTAssertTrue(actions.contains("ecoButtonTapped"))
    }
}
