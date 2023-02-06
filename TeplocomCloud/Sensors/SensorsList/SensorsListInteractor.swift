//
//  SensorsListInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol SensorsListBusinessLogic {
    func makeRequest(event: SensorsList.Model.Request.RequestType)
}

// MARK: - Interactor

final class SensorsListInteractor {

    // MARK: - External vars

    var presenter: SensorsListPresentationLogic?

    // MARK: - Internal vars

    private var service: SensorsListWorker?
}

// MARK: - Business Logic Extension

extension SensorsListInteractor: SensorsListBusinessLogic {
    func makeRequest(event: SensorsList.Model.Request.RequestType) {
        if service == nil {
            service = SensorsListWorker()
        }

        switch event {
        case .fetchSensorsList:

            service?.fetchTemperatureSensorsList(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentSensors(data: result))
            })
        }
    }
}
