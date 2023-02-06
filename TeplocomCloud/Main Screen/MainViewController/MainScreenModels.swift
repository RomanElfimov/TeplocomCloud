//
//  MainScreenModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import Foundation

enum MainScreen {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchHotData
                case switchBoiler
            }
        }

        struct Response {
            enum ResponseType {
                case presentHotData(data: HotDataBackendModel)
                case presentSwitchBoiler(statusCode: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayHotData(data: HotDataViewModel)
                case displaySwitchBoiler(statusCode: Int)
            }
        }
    }
}
