//
//  DevicesBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 16.02.2022.
//

import Foundation

/// Получение устройств связанных с пользователем
struct BindedDevicesBackendModel: Decodable {
    let clientName: String
    let description: String
    let status: Bool
    let type: String
    let uid: String
}
