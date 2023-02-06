//
//  TemperatureSensorExpertSettingsBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation

struct TemperatureSensorExpertSettingsBackendModel: Decodable {
    /// Установить значение при аварии
    let defaultValue: Int
    /// Задержка уведомления перед первым оповещением
    let notifyDelay: Int
    /// Интервал оповещения
    let notifyInterval: Int
    /// Оповещение при аварии
    let notifyOnFailure: Bool
    /// Оповещение при достижение минимума
    let notifyOnLowerLimit: Bool
    /// Оповещение при достижение максимума
    let notifyOnUpperLimit: Bool
    /// Оповещение при обрыве
    let notifyOnWireBreak: Bool
    /// Количество повторных посещений
    let notifyQuantity: Int
    /// Окно интеграции
    let roundWindow: Int
}
