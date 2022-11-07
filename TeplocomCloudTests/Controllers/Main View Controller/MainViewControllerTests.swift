//
//  MainViewControllerTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 08.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MainViewControllerTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: MainViewController!
    private var interactor: MainScreenBusinessLogicSpy!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let mainController = MainViewController()
        let mainInteractor = MainScreenBusinessLogicSpy()

        mainController.interactor = mainInteractor

        sut = mainController
        interactor = mainInteractor

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    // CleanSwift test
    func testDisplayData() {
        XCTAssertTrue(interactor.isCalledInteractor)
    }

    // Содержатся ли элементы интерфейса во view

    func testHasOutdoorTemp() {
        XCTAssertNotNil(sut.outdoorTemp)
        XCTAssertTrue(sut.outdoorTemp.isDescendant(of: sut.view))
    }

    func testHasGSMDivider() {
        XCTAssertNotNil(sut.gsmDivider)
        XCTAssertTrue(sut.gsmDivider.isDescendant(of: sut.view))
    }

    func testHasGSMDescriptionLabel() {
        XCTAssertNotNil(sut.gsmDescriptionLabel)
        XCTAssertTrue(sut.gsmDescriptionLabel.isDescendant(of: sut.view))
    }

    func testHasFirstGSMImage() {
        XCTAssertNotNil(sut.firstGSMImage)
        XCTAssertTrue(sut.firstGSMImage.isDescendant(of: sut.view))
    }

    func testHasSecondGSMImage() {
        XCTAssertNotNil(sut.secondGSMImage)
        XCTAssertTrue(sut.secondGSMImage.isDescendant(of: sut.view))
    }

    func testHasThirdGSMLabel() {
        XCTAssertNotNil(sut.thirdGSMLabel)
        XCTAssertTrue(sut.thirdGSMLabel.isDescendant(of: sut.view))
    }

    func testHasOpenThermDivider() {
        XCTAssertNotNil(sut.openThermDivider)
        XCTAssertTrue(sut.openThermDivider.isDescendant(of: sut.view))
    }

    func testHasDescriptionOTLabel() {
        XCTAssertNotNil(sut.descriptionOTLabel)
        XCTAssertTrue(sut.descriptionOTLabel.isDescendant(of: sut.view))
    }

    func testHasFirstOTImage() {
        XCTAssertNotNil(sut.firstOTImage)
        XCTAssertTrue(sut.firstOTImage.isDescendant(of: sut.view))
    }

    func testHasSecondOTImage() {
        XCTAssertNotNil(sut.secondOTImage)
        XCTAssertTrue(sut.secondOTImage.isDescendant(of: sut.view))
    }

    func testHasThirdOTImage() {
        XCTAssertNotNil(sut.thirdOTImage)
        XCTAssertTrue(sut.thirdOTImage.isDescendant(of: sut.view))
    }

    func testHasSeparatorKView() {
        XCTAssertNotNil(sut.separatorKView)
        XCTAssertTrue(sut.separatorKView.isDescendant(of: sut.view))
    }

    func testHasDescriptionKLabel() {
        XCTAssertNotNil(sut.descriptionKLabel)
        XCTAssertTrue(sut.descriptionKLabel.isDescendant(of: sut.view))
    }

    func testHasFirstKImage() {
        XCTAssertNotNil(sut.firstKImage)
        XCTAssertTrue(sut.firstKImage.isDescendant(of: sut.view))
    }

    func testHasSecondKImage() {
        XCTAssertNotNil(sut.secondKImage)
        XCTAssertTrue(sut.secondKImage.isDescendant(of: sut.view))
    }

    func testHasThirdKLabel() {
        XCTAssertNotNil(sut.thirdKLabel)
        XCTAssertTrue(sut.thirdKLabel.isDescendant(of: sut.view))
    }

    func testHasSeparatorTView() {
        XCTAssertNotNil(sut.separatorTView)
        XCTAssertTrue(sut.separatorTView.isDescendant(of: sut.view))
    }

    func testHasDescriptionTLabel() {
        XCTAssertNotNil(sut.descriptionTLabel)
        XCTAssertTrue(sut.descriptionTLabel.isDescendant(of: sut.view))
    }

    func testHasFirstTLabel() {
        XCTAssertNotNil(sut.firstTLabel)
        XCTAssertTrue(sut.firstTLabel.isDescendant(of: sut.view))
    }

    func testHasFirstTImage() {
        XCTAssertNotNil(sut.firstTImage)
        XCTAssertTrue(sut.firstTImage.isDescendant(of: sut.view))
    }

    func testHasSecondTLabel() {
        XCTAssertNotNil(sut.secondTLabel)
        XCTAssertTrue(sut.secondTLabel.isDescendant(of: sut.view))
    }

    func testHasSecondTImage() {
        XCTAssertNotNil(sut.secondTImage)
        XCTAssertTrue(sut.secondTImage.isDescendant(of: sut.view))
    }

    func testHasThirdTLabel() {
        XCTAssertNotNil(sut.thirdTLabel)
        XCTAssertTrue(sut.thirdTLabel.isDescendant(of: sut.view))
    }

    func testHasThirdTImage() {
        XCTAssertNotNil(sut.thirdTImage)
        XCTAssertTrue(sut.thirdTImage.isDescendant(of: sut.view))
    }

    func testHasManualActivationLabel() {
        XCTAssertNotNil(sut.manualActivationLabel)
        XCTAssertTrue(sut.manualActivationLabel.isDescendant(of: sut.view))
    }

    func testHasManualActivationButton() {
        XCTAssertNotNil(sut.manualActivationButton)
        XCTAssertTrue(sut.manualActivationButton.isDescendant(of: sut.view))
    }

    // Содержат ли элементы интерфейса информацию модели данных

    func setupModelAndAppearanceTransition() {
        let model = HotDataViewModel(simBalance: "Foo", simSignalLevel: UIImage(systemName: "arrow.left")!, supplyVoltage: true, batteryVoltage: false, centralHeatingTemp: "Foo", domesticHotWaterTemp: "Bar", indoorTemp: "Baz", outdoorTemp: "Foo", mode: "Bar", setPoint: "Baz", boilerState: true)

        sut.configureUI(with: model)
    }

    func testSetsFirstGSMImage() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.firstGSMImage.image, UIImage(systemName: "arrow.left"))
    }

    func testSetsThirdGSMLabel() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.thirdGSMLabel.text, "Foo")
    }

    func testSetsThirdKLabel() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.thirdKLabel.text, "Baz")
    }

    func testSestsFirstTLabel() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.firstTLabel.text, "Foo")
    }

    func testSetsSecondTLabel() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.secondTLabel.text, "Baz")
    }

    func testSetsThirdTLabel() {
        setupModelAndAppearanceTransition()
        XCTAssertEqual(sut.thirdTLabel.text, "Bar")
    }

    // Тесты navigation bar

    // У navigation bar есть кнопка
    func testMainVCHasMenuBarButtonWithTarget() {
        let target = sut.navigationItem.leftBarButtonItem?.target
        XCTAssertEqual(target as? MainViewController, sut)
    }

    // По кнопке из navigation bar выполнняется действие
    func testMenuButtonPresentsMenuVC() {
        // При нажатии не отображается никакой дополнительный контроллер
        XCTAssertNil(sut.presentedViewController)

        guard
            let menuButton = sut.navigationItem.leftBarButtonItem,
            let action = menuButton.action else {
            XCTFail()
            return
        }

        // Добавим sut в качестве root vc у window
        UIApplication.shared.keyWindow?.rootViewController = sut

        sut.performSelector(onMainThread: action, with: menuButton, waitUntilDone: true)
        XCTAssertNotNil(sut.presentedViewController) // по нажатию на кнопку появился контроллер
        XCTAssertTrue(sut.presentedViewController is MenuViewController)

        // Проверяем, что у MenuViewController есть элементы интерфейса
        let menuController = sut.presentedViewController as! MenuViewController
        XCTAssertNotNil(menuController.tableView)
    }
}
