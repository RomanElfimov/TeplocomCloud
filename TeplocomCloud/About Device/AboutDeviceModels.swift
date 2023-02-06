//
//  AboutDeviceModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

enum AboutDevice {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchNeedUpdateFirmware
                case fetchDeviceInfo
                case editDeviceInfo(parameters: [String: String])
                case reflashFirmware
            }
        }

        struct Response {
            enum ResponseType {
                case presentNeedUpdateFirmware(data: HotDataBackendModel)
                case presentDeviceInfo(data: DeviceInfoBackendModel)
                case editDeviceInfo(status: Int)
                case reflashFirmware(status: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayNeedUpdateFirmware(data: NeedUpdateFirmwareViewModel)
                case displayDeviceInfo(data: DeviceInfoViewModel)
                case editDeviceInfo(status: Int)
                case reflashFirmware(status: Int)
            }
        }
    }
}
