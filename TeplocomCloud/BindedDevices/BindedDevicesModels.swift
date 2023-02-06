//
//  BindedDevicesModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.02.2022.
//

import Foundation

enum BindedDevices {

    enum Model {
        struct Request {
            enum RequestType {
                case fetchBindedDevices
            }
        }

        struct Response {
            enum ResponseType {
                case presentBindedDevices(data: [BindedDevicesBackendModel])
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayBindedDevices(data: [BindedDevicesViewModel])
            }
        }
    }
}
