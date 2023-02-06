//
//  TemperatureSensorsModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 19.02.2022.
//

import Foundation

struct TemperatureSensorsListBackendModel: Decodable, Equatable {
    let id: String
    let role: String
    let title: String
}

struct TemperatureSensorBackendModel: Decodable {
    let clientName: String
    let lowerLimit: Int
    let upperLimit: Int
    let notify: Bool
    let role: String
}
