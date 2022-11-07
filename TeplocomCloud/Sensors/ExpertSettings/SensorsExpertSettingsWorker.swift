//
//  SensorsExpertSettingsWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.10.2022.
//

import Foundation

final class SensorsExpertSettingsService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService?

    // MARK: - Private Property

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Methods

    public func getTemperatureSensorExpertSettings(sensorId: String, completion: @escaping(TemperatureSensorExpertSettingsBackendModel) -> Void) {

        /*
        networkLayer?.getTemperatureSensorExpertSettings(sensorId: sensorId, completion: { result in
            guard let result = result else { return }
            completion(result)
        })
        */

        let mockData = TemperatureSensorExpertSettingsBackendModel(defaultValue: 5000, notifyDelay: 300000, notifyInterval: 1800, notifyOnFailure: true, notifyOnLowerLimit: true, notifyOnUpperLimit: false, notifyOnWireBreak: true, notifyQuantity: 3, roundWindow: 60)
        completion(mockData)
    }

    public func editTemperatureSensorExpertSettings(sensorId: String, parameters: [String: Any], statusCodeCompletion: @escaping(Int) -> Void) {

        /*
        networkLayer?.editTemperatureSensorExpertSettings(sensorId: sensorId, parameters: parameters, statusCodeCompletion: { statusCode in
            guard let statusCode = statusCode else { return }
            statusCodeCompletion(statusCode)
        }, completion: { _ in })
        */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }

}
