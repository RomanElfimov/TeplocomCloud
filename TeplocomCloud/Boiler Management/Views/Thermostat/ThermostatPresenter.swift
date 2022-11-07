//
//  BoilerManagementPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.05.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol ThermostatPresentationLogic {
    func presentData(event: ThermostatManagement.Model.Response.ResponseType)
}

// MARK: - Presenter

final class ThermostatPresenter {

    // MARK: - External vars

    weak var viewController: ThermostatLogic?
}

// MARK: - Presentation Logic Extension

extension ThermostatPresenter: ThermostatPresentationLogic {
    func presentData(event: ThermostatManagement.Model.Response.ResponseType) {
        switch event {

        case .presentBoilerSettings(let data):
            let centralTemp = "\(data.centralHeatingTemperature / 100) ˚C"
            let roomTemp = data.roomTemp != nil ? "\(String(describing: data.roomTemp! / 100)) ˚C" : "-/-"

            viewController?.displayData(event: .displayBoilerSettings(data: BoilerViewModel(sensorRole: data.sensorRole, setPoint: data.setPoint/100, centralHeatingTemperature: centralTemp, roomTemperature: roomTemp)))

        case .editBoilerSettings(let statusCode):
            viewController?.displayData(event: .editBoilerSettings(statusCode: statusCode))
        }
    }
}
