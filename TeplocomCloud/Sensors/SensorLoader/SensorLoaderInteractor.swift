//
//  SensorLoaderInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol SensorLoaderBusinessLogic {
    func makeRequest(event: SensorLoader.Model.Request.RequestType)
}

// MARK: - Interactor Class

final class SensorLoaderInteractor {

    // MARK: - External vars

    var presenter: SensorLoaderPresentaionLogic?

    // MARK: - Internal vars

    var service: SensorLoaderWorker?
}

// MARK: - Business Logic Extension

extension SensorLoaderInteractor: SensorLoaderBusinessLogic {
    func makeRequest(event: SensorLoader.Model.Request.RequestType) {
        if service == nil {
            service = SensorLoaderWorker()
        }

        switch event {

        case .fetchUnallocatedSensor:
            service?.fetchUnallocatedTempSensor(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentUnallocatedSensor(data: result))
            })
        }
    }
}
