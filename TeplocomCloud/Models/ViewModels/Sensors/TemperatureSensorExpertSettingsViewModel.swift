//
//  TemperatureSensorExpertSettingsViewModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation

struct TemperatureSensorExpertSettingsViewModel {
    let roundWindow: String
    let defaultValue: String
    let notifyOnLowerLimit: Bool
    let notifyOnUpperLimit: Bool
    let notifyOnFailure: Bool
    let notifyInterval: String
    let notifyQuantity: String
}
