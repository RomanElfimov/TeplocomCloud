//
//  MainScreenInteractorTests.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 12.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MainScreenInteractorTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: MainScreenInteractor!
    private var presenter: MainScreenPresentationLogicSpy!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        let mainScreenInteractor = MainScreenInteractor()
        let mainScreenPresenter = MainScreenPresentationLogicSpy()

        mainScreenInteractor.presenter = mainScreenPresenter

        sut = mainScreenInteractor
        presenter = mainScreenPresenter
    }

    override func tearDown() {
        sut = nil
        presenter = nil

        super.tearDown()
    }

    // MARK: - Public Methods

    func testMakeRequest() {
        sut.makeRequest(event: .fetchHotData)
        XCTAssertTrue(presenter.isCalledPresenter)
    }

}
