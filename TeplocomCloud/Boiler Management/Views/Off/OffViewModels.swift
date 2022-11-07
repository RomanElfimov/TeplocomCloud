//
//  OffViewModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import Foundation

enum OffViewModel {
    enum Model {
        struct Request {
            enum RequestType {
                case editBoilerSettings(parameters: [String: Any])
            }
        }

        struct Response {
            enum ResponseType {
                case editBoilerSettings(statusCode: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case editBoilerSettings(statusCode: Int)
            }
        }
    }
}
