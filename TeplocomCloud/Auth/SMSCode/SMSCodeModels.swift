//
//  SMSCodeModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

enum SMSCode {

    enum Model {

        struct Request {
            enum RequestType {
                case getPhoneNumber
                case logIn(parameters: [String: String])
            }
        }

        struct Response {
            enum ResponseType {
                case presentPhoneNumber(phoneNumber: String)
                case presentLogIn(model: LoginBackendModel)
                case error(description: String)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayPhoneNumber(phoneNumber: String)
                case displayLogIn(viewModel: LoginBackendModel)
                case error(description: String)
            }
        }

        struct Router {
            enum RoutingType {
                case showBindedDevicesListScreen
            }
        }
    }
}
