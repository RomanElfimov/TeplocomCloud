//
//  BoilerManagementWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.05.2022.
//

import Foundation

final class ThermostatService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Methods

    public func fetchBoilerSettings(completion: @escaping(BoilerBackendModel) -> Void) {
        /*
        networkLayer.getBoilerSettings { result in
            guard let result = result else { return }
            completion(result)
        }
        */

        let mockBoilerSettings = BoilerBackendModel(boilerState: true, centralHeatingTemperature: 7500, mode: "thermostat", roomTemp: 2400, sensorRole: "indoor", setPoint: 2700, useSchedule: false)
        completion(mockBoilerSettings)

    }

    public func editBoilerSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {

        /*
        networkLayer.editBoilerSettings(parameters: parameters) { statusCode in
            guard let statusCode = statusCode else { return }
            statusCodeCompletion(statusCode)
        } completion: { _ in }
        */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }

}
