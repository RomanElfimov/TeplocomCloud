//
//  SensorSettingsWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

final class SensorSettingsWorker {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    // Добавление датчика
    public func setUnallocatedTempSensor(parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {
        /*
        networkLayer.setUnallocatedTempSensor(parameters: parameters) { result in
            guard let result = result else { return }
            completion(result)
        }
         */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }

    // Получение настроек датчика
    public func getTemperatureSensorSettings(sensorId: String, completion: @escaping(TemperatureSensorBackendModel) -> Void) {
        /*
        networkLayer.getTemperatureSensorSettings(sensorId: sensorId) { sensorSettings in
            guard let sensorSettings = sensorSettings else { return }
            completion(sensorSettings)
        }
        */

        let mockSettings = TemperatureSensorBackendModel(clientName: "Тест 1",
                                                         lowerLimit: -700,
                                                         upperLimit: 85000,
                                                         notify: true,
                                                         role: "Комната")
        completion(mockSettings)
    }

    // Изменение настроек датчика
    public func editTemperatureSensorSettings(sensorId: String, parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {

        /*
        networkLayer.editTemperatureSensorSettings(sensorId: sensorId, parameters: parameters) { status in
            guard let statusCode = statusCode else { return }
            statusCodeCompletion(statusCode
        } completion: { _ in }
        */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }
}
