//
//  SensorsExpertSettingsModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.10.2022.
//

import Foundation

enum SensorsExpertSettings {
    enum Model {

        struct Request {
            enum RequestType {
                case fetchSensorsExpertSettings
                case editSensorsExpertSettings(parameters: [String: Any])
            }
        }

        struct Response {
            enum ResponseType {
                case fetchSensorsExpertSettings(data: TemperatureSensorExpertSettingsBackendModel)
                case editSensorsExpertSettingseditSensorsExpertSettings(statusCode: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case fetchSensorsExpertSettings(data: TemperatureSensorExpertSettingsViewModel)
                case editSensorsExpertSettingseditSensorsExpertSettings(statusCode: Int)
            }
        }
    }
}
