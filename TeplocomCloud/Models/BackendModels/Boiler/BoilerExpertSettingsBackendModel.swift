//
//  BoilerExpertSettingsBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.05.2022.
//

import Foundation

struct BoilerExpertSettingsBackendModel: Decodable {
    let boilerControlProtocol: String
    let hysteresis: Int
    let normalState: String?
    let stateOnLeakage: Bool
    let switchingOnTheBoilerCirculationPump: Int
}
