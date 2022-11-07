//
//  NotificationSettingsModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

struct NotificationSettingsModel: Decodable {
    /// Интервал оповещения
    let notifyInterval: Int
    /// Количество повторных посещений
    let notifyQuantity: Int
    /// Уведомлять по SMS
    let notifyBySms: Bool
    /// Уведомлять звонком
    let notifyByCall: Bool
}
