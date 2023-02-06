//
//  SensorSettingsModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

enum SensorSettings {
    enum Model {
        struct Request {
            enum RequestType {
                case getSensorInfo
                case addNewSensor(parameters: [String: Any])

                case editSensor(parameters: [String: Any])
                case fetchSensorSettings
            }
        }

        struct Response {
            enum ResponseType {
                case presentSensorInfo(sensorId: String, sensorType: String)
                case presentAddNewSensor(status: Int)

                case presentEditSensor(status: Int)
                case presentSensorSettings(data: TemperatureSensorBackendModel)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displaySensorInfo(sensorId: String, sensorType: String)
                case displayAddNewSensor(status: Int)

                case displayEditSensor(status: Int)
                case displaySensorSettings(data: TemperatureSensorViewModel)
            }
        }
    }
}
