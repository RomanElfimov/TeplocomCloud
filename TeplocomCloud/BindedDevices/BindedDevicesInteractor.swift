//
//  BindedDevicesInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.02.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol BindedDevicesBusinessLogic {
    func makeRequest(event: BindedDevices.Model.Request.RequestType)
}

// MARK: - Store Protocol

protocol BindedDevicesStoreProtocol: AnyObject {
    var isFromAuthScreen: Bool { get set }
}

// MARK: - Interactor

final class BindedDevicesInteractor: BindedDevicesStoreProtocol {

    // MARK: - External vars

    var isFromAuthScreen: Bool = false
    var presenter: BindedDevicesPresentationLogic?

    // MARK: - Internal vars

    private var service: BindedDevicesWorker?
}

// MARK: - Display Logic Extention

extension BindedDevicesInteractor: BindedDevicesBusinessLogic {
    func makeRequest(event: BindedDevices.Model.Request.RequestType) {
        if service == nil {
            service = BindedDevicesWorker()
        }

        switch event {

        case .fetchBindedDevices:
            service?.fetchBindedDevices(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentBindedDevices(data: result))
            })
        }
    }
}
