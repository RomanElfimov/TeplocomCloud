//
//  RelayTwoModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

enum RelayTwo {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchExpertSettings
                case editExpertSettings(parameters: [String: Any])
            }
        }

        struct Response {
            enum ResponseType {
                case fetchExpertSettings(data: BoilerExpertSettingsBackendModel)
                case editExpertSettings(statusCode: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case fetchExpertSettings(data: BoilerExpertSettingsViewModel)
                case editExpertSettings(statusCode: Int)
            }
        }
    }
}
