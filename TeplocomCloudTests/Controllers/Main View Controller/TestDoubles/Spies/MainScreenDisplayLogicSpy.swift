//
//  MainScreenDisplayLogicSpy.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation
@testable import TeplocomCloud

class MainScreenDisplayLogicSpy: MainScreenDisplayLogic {

    // MARK: - Public Properties

    private(set) var isCalledViewController = false
    private(set) var boilerStateOnOff: Bool = false

    // MARK: - Public Methods

    func displayData(event: MainScreen.Model.ViewModel.ViewModelData) {
        isCalledViewController = true
    }
}
