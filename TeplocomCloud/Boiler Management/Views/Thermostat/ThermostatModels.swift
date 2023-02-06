//
//  BoilerManagementModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.05.2022.
//

import Foundation

enum ThermostatManagement {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchBoilerSettings
                case editBoilerSettings(parameters: [String: Any])
            }
        }

        struct Response {
            enum ResponseType {
                case presentBoilerSettings(data: BoilerBackendModel)
                case editBoilerSettings(statusCode: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayBoilerSettings(data: BoilerViewModel)
                case editBoilerSettings(statusCode: Int)
            }
        }

        struct Router {
            enum RoutingLogic {
                case dismiss
                case expertSettings
            }
        }
    }
}
