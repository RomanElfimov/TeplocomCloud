//
//  AboutDeviceInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol AboutDeviceBusinessLogic {
    func makeRequest(event: AboutDevice.Model.Request.RequestType)
}

// MARK: - Interactor

final class AboutDeviceInteractor {

    // MARK: - External vars

    public var presenter: AboutDevicePresentationLogic?

    // MARK: - Internal vars

    private var service: AboutDeviceService?
}

// MARK: - Business Logic Extension

extension AboutDeviceInteractor: AboutDeviceBusinessLogic {
    func makeRequest(event: AboutDevice.Model.Request.RequestType) {
        if service == nil {
            service = AboutDeviceService()
        }

        switch event {
        case .fetchNeedUpdateFirmware:
            service?.fetchHotData(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentNeedUpdateFirmware(data: result))
            })

        case .fetchDeviceInfo:
            service?.fetchDeviceInfo(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentDeviceInfo(data: result))
            })

        case .editDeviceInfo(parameters: let parameters):
            service?.editDeviceInfo(parameters: parameters, statusCodeCompletion: { [weak self] statusCode in
                self?.presenter?.presentData(event: .editDeviceInfo(status: statusCode))
            })

        case .reflashFirmware:
            service?.reflashFirmware(statusCodeCompletion: { [weak self] statusCode in
                self?.presenter?.presentData(event: .reflashFirmware(status: statusCode))
            })
        }
    }
}
