//
//  MainScreenBusinessLogicSpy.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 12.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MainScreenBusinessLogicSpy: MainScreenBusinessLogic {

    // MARK: - Public Properties

    private(set) var isCalledInteractor = false

    // MARK: - Public Methods

    func makeRequest(event: MainScreen.Model.Request.RequestType) {
        isCalledInteractor = true
    }
}
