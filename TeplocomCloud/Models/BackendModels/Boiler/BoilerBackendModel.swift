//
//  BoilerBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.05.2022.
//

import Foundation

struct BoilerBackendModel: Decodable {
    let boilerState: Bool
    let centralHeatingTemperature: Int
    let mode: String
    let roomTemp: Int?
    let sensorRole: String
    let setPoint: Int
    let useSchedule: Bool
}
