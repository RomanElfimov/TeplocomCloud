//
//  SignInModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.08.2021.
//

import Foundation

enum SignIn {
    enum Model {

        struct Request {
            enum RequestType {
                case fetchAuthCode(parameters: [String: String])
            }
        }

        struct Response {
            enum ResponseType {
                case presentAuthCode(model: AuthCodeBackendModel)
                case error(description: String)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayAuthCode(viewModel: AuthCodeBackendModel)
                case error(description: String)
            }
        }

        struct Router {
            enum RoutingType {
                case showSMSCodeScreen(phoneNumber: String)
            }
        }

    }
}
