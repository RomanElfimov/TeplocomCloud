//
//  BindedDevicesDisplayLogicSpy.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 13.10.2022.
//

import Foundation
@testable import TeplocomCloud

class BindedDevicesDisplayLogicSpy: BindedDevicesDispayLogic {

    // MARK: - Public Properties

    private(set) var isCalledController = false
    private(set) var bindedDevicesArray: [BindedDevicesViewModel] = []

    // MARK: - Public Methods

    func displayData(event: BindedDevices.Model.ViewModel.ViewModelData) {
        switch event {
        case .displayBindedDevices(let data):
            bindedDevicesArray = data
        }

        isCalledController = true
    }
}
