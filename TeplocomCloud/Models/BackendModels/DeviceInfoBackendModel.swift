//
//  DeviceInfoBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 19.02.2022.
//

import Foundation

struct DeviceInfoBackendModel: Decodable {
    let deviceClientName: String
    let currentFirmwareVersion: String?
    let availableFirmwareVersion: String?
}
