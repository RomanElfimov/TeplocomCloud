//
//  ThreePhoneChangeModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

enum ThreePhoneChange {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchSMSCode(parameters: [String: String])
            }
        }

        struct Response {
            enum ResponseType {
                case presentSMSCode
                case error(description: String)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displaySMSCode
                case error(description: String)
            }
        }

        struct Router {
            enum RoutingType {
                case showDetail
            }
        }
    }
}
