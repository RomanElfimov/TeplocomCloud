//
//  BoilerExpertSettingsViewModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation

struct BoilerExpertSettingsViewModel {
    /// Протокол управления котлом
    let boilerControlProtocol: String
    /// Гистерезис
    let hysteresis: Float
    /// Состояние клапана
    let normalState: String?
    /// Отключение котла по контактному датчику
    let stateOnLeakage: Bool
    /// Включение циркуляционного насоса котла
    let switchingOnTheBoilerCirculationPump: Float
}
