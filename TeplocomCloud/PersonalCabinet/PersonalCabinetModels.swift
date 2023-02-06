//
//  PersonalCabinetModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

enum PersonalCabinet {

    enum Model {
        struct Request {
            enum RequestType {
                case fetchUserPersonalData
                case editPersonalData(parameters: [String: Any])
                case searchCountries(searchText: String)
                case searchCities(searchText: String)
            }
        }

        struct Response {
            enum ResponseType {
                case presentPersonalData(model: PersonalInfoBackendModel)
                case presentCountries(response: [String])
                case presentCities(response: [String])
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayPersonalData(viewModel: PersonalInfoViewModel)
                case displayCountries(response: [String])
                case displayCities(response: [String])
            }
        }

        struct Router {
            enum RoutingLogic {
                case navigateToEmailManagement(email: String, isVerified: Bool)
                case navigateToPhoneNumberChange
            }
        }
    }

}
