//
//  MainScreenPresentationLogicSpy.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 12.10.2022.
//

import XCTest
@testable import TeplocomCloud

class MainScreenPresentationLogicSpy: MainScreenPresentationLogic {

    // MARK: - Public Properties

    private(set) var isCalledPresenter = false

    // MARK: - Public Methods

    func presentData(event: MainScreen.Model.Response.ResponseType) {
        isCalledPresenter = true
    }

}
