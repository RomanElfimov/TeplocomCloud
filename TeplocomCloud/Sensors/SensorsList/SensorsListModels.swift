//
//  SensorsListModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import Foundation

enum SensorsList {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchSensorsList
            }
        }

        struct Response {
            enum ResposneType {
                case presentSensors(data: [TemperatureSensorsListBackendModel])
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displaySensorsList(data: [TemperatureSensorsListBackendModel])
            }
        }

        struct Router {
            enum RoutingLogic {
                case addNewSensor
                case editSensor(sensorType: String, sensorID: String)
            }

        }
    }
}
