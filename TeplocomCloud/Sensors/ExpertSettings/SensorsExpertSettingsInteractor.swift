//
//  SensorsExpertSettingsInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.10.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol SensorsExpertSettingsBusinessLogic {
    func makeRequest(event: SensorsExpertSettings.Model.Request.RequestType)
}

// MARK: - Store Protocol

protocol SensorsExpertSettingsStoreProtocol: AnyObject {
    var sensorId: String { get set }
}

// MARK: - Interactor

final class SensorsExpertSettingsInteractor: SensorsExpertSettingsStoreProtocol {

    // MARK: - External vars

    public var sensorId: String = "777"

    public var presenter: SensorsExpertSettingsPresentationLogic?

    // MARK: - Internal vars

    private var service: SensorsExpertSettingsService?
}

// MARK: - Business Logic Extension

extension SensorsExpertSettingsInteractor: SensorsExpertSettingsBusinessLogic {
    func makeRequest(event: SensorsExpertSettings.Model.Request.RequestType) {
        if service == nil {
            service = SensorsExpertSettingsService()
        }

        switch event {
        case .fetchSensorsExpertSettings:
            service?.getTemperatureSensorExpertSettings(sensorId: sensorId, completion: { [weak self] result in
                self?.presenter?.presentData(event: .fetchSensorsExpertSettings(data: result))
            })
        case . editSensorsExpertSettings(let parameters):
            service?.editTemperatureSensorExpertSettings(sensorId: sensorId, parameters: parameters, statusCodeCompletion: { [weak self] status in
                self?.presenter?.presentData(event: .editSensorsExpertSettingseditSensorsExpertSettings(statusCode: status))
            })
        }
    }
}
