//
//  OpenThermModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

enum OpenTherm {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchOpenThermSettings
                case editOpenThermSettings(parameters: [String: Any])
            }
        }

        struct Response {
            enum ResponseType {
                case fetchOpenThermSettings(data: BoilerOpenThermSettingsBackendModel)
                case editOpenThermSettings(statusCode: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case fetchOpenThermSettings(data: BoilerOpenThermSettingsBackendModel)
                case editOpenThermSettings(statusCode: Int)
            }
        }
    }
}
