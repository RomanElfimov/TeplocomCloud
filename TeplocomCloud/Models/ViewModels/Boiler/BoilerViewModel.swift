//
//  BoilerViewModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation

struct BoilerViewModel {
    /// Роль датчика
    let sensorRole: String
    /// Уставка температуры
    let setPoint: Int
    /// Температура теплоносителя
    let centralHeatingTemperature: String
    /// Температура в комнате
    let roomTemperature: String
}
