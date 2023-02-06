//
//  PhoneNumberChangeModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

enum PhoneNumberChange {

    enum Model {
        struct Request {
            enum RequestType {
                case fetchPhoneNumberChange(newPhoneParameters: [String: String])
            }
        }

        struct Response {
            enum ResponseType {
                case presentPhoneNumberChange
                case error(description: String)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayPhoneNumberChange
                case error(description: String)
            }
        }

        struct Router {
            enum RoutingType {
                case showSecondPhoneChangeScreen
            }
        }
    }
}
