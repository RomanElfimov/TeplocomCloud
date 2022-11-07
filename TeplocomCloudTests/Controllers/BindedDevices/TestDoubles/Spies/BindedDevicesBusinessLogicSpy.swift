//
//  BindedDevicesBusinessLogicSpy.swift
//  TeplocomCloudTests
//
//  Created by Роман Елфимов on 13.10.2022.
//

import Foundation
@testable import TeplocomCloud

class BindedDevicesBusinessLogicSpy: BindedDevicesBusinessLogic, BindedDevicesStoreProtocol {

    // MARK: - Public Properties

    var isFromAuthScreen: Bool = false
    private(set) var iscCalledInteractor = false

    // MARK: - Public Methods

    func makeRequest(event: BindedDevices.Model.Request.RequestType) {
        iscCalledInteractor = true
    }

}
