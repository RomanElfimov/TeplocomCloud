//
//  BoilerOpenThermSettingsBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

struct BoilerOpenThermSettingsBackendModel: Decodable {
    /// Максимальная температура ГВС
    let maxDomesticHotWaterTemperature: Int
    /// Минимальная температура ГВС
    let minDomesticHotWaterTemperature: Int
    /// Уставка ГВС
    let setPointDomesticHotWater: Int
    /// Максимальная температура теплоносителя
    let maxHeatingMediumTemperature: Int
    /// Минимальная температура теплоносителя
    let minHeatingMediumTemperature: Int
    /// Максимальная модуляция горелки
    let maximumBurnerModulation: Int
    /// Конфигурация ГВС - instantaneousWaterHeater; indirectHeatingBoiler
    let configurationDomesticHotWater: String
}
