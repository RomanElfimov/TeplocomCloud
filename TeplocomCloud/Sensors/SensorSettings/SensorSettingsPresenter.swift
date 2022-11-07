//
//  SensorSettingsPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol SensorSettingsPresentationLogic {
    func presentData(event: SensorSettings.Model.Response.ResponseType)
}

// MARK: - Presenter

final class SensorSettingsPresenter {

    // MARK: - External vars

    weak var viewController: SensorSettingsDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension SensorSettingsPresenter: SensorSettingsPresentationLogic {
    func presentData(event: SensorSettings.Model.Response.ResponseType) {
        switch event {

        case .presentSensorInfo(let sensorId, let sensorType):
            viewController?.displayData(event: .displaySensorInfo(sensorId: sensorId, sensorType: sensorType))
        case .presentAddNewSensor(let statusCode):
            viewController?.displayData(event: .displayAddNewSensor(status: statusCode))

        case .presentEditSensor(let status):
            viewController?.displayData(event: .displayEditSensor(status: status))

        case .presentSensorSettings(let data):
            let viewModel = TemperatureSensorViewModel(clientName: data.clientName,
                                                       lowerLimit: "\(data.lowerLimit / 100) ˚C", upperLimit: "\(data.upperLimit / 100) ˚C", notify: data.notify, role: data.role)
            viewController?.displayData(event: .displaySensorSettings(data: viewModel))

        }
    }
}
