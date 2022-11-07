//
//  BindedDevicesPresentationLogicSpy.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 13.10.2022.
//

import Foundation
@testable import TeplocomCloud

class BindedDevicesPresentationLogicSpy: BindedDevicesPresentationLogic {

    // MARK: - Public Methods

    private(set) var isCalledPresenter = false

    // MARK: - Public Methods

    func presentData(event: BindedDevices.Model.Response.ResponseType) {
        isCalledPresenter = true
    }
}
