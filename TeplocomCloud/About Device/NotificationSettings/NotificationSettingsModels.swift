//
//  NotificationSettingsModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

enum NotificationSettings {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchSettings
                case editSettings(parameters: [String: Any])
            }
        }

        struct Response {
            enum ResponseType {
                case fetchSettings(data: NotificationSettingsModel)
                case editSettings(status: Int)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case fetchSettings(data: NotificationSettingsModel)
                case editSettings(status: Int)
            }
        }
    }
}
