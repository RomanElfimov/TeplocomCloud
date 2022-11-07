//
//  SensorSettingsInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol SensorSettingsBusinessLogic {
    func makeRequest(event: SensorSettings.Model.Request.RequestType)
}

// MARK: - Store Protocol

protocol SensorSettingsStoreProtocol: AnyObject {
    var sensorType: String { get set }
    var sensorID: String { get set }
}

// MARK: - Interactor

final class SensorSettingsInteractor: SensorSettingsStoreProtocol {

    // MARK: - External vars

    var sensorType: String = ""
    var sensorID: String = ""

    var presenter: SensorSettingsPresentationLogic?

    // MARK: - Internal vars

    private var service: SensorSettingsWorker?
}

// MARK: - Business Logic Extension

extension SensorSettingsInteractor: SensorSettingsBusinessLogic {
    func makeRequest(event: SensorSettings.Model.Request.RequestType) {
        if service == nil {
            service = SensorSettingsWorker()
        }

        switch event {
            // Добавление датчика
        case .getSensorInfo:
            presenter?.presentData(event: .presentSensorInfo(sensorId: sensorID, sensorType: sensorType))

        case .addNewSensor(let parameters):
            service?.setUnallocatedTempSensor(parameters: parameters, statusCodeCompletion: { [weak self] status in
                self?.presenter?.presentData(event: .presentAddNewSensor(status: status))
            })

            // Получение настроек датчика
        case .fetchSensorSettings:
            service?.getTemperatureSensorSettings(sensorId: sensorID, completion: { [weak self] sensorSettings in
                self?.presenter?.presentData(event: .presentSensorSettings(data: sensorSettings))
            })

            // Изменение настроек датчика
        case .editSensor(let parameters):
            service?.editTemperatureSensorSettings(sensorId: sensorID, parameters: parameters, statusCodeCompletion: { [weak self] status in
                self?.presenter?.presentData(event: .presentEditSensor(status: status))
            })
        }
    }
}
