//
//  DeviceHotDataBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import UIKit

struct HotDataBackendModel: Decodable {
    let installed_firmware_version: String
    let need_update_firmware: Bool
    let firmware_reflashing_now: Bool
    let gsmBalance: Int
    let gsmRssi: Int
    let powerSupplyVoltage: Bool
    let batteryVoltage: Bool
    let centralHeating: Int
    let domesticHotWater: Int
    let indoor: Int
    let outdoor: String
    let mode: String
    let setPoint: Int? // nil
    let boilerState: Bool

    init(installedFirmwareVersion: String, needUpdateFirmware: Bool, firmwareReflashingNow: Bool, gsmBalance: Int, gsmRssi: Int, powerSupplyVoltage: Bool, batteryVoltage: Bool, centralHeating: Int, domesticHotWater: Int, indoor: Int, outdoor: String, mode: String, setPoint: Int? = nil, boilerState: Bool) {
        self.installed_firmware_version = installedFirmwareVersion
        self.need_update_firmware = needUpdateFirmware
        self.firmware_reflashing_now = firmwareReflashingNow
        self.gsmBalance = gsmBalance
        self.gsmRssi = gsmRssi
        self.powerSupplyVoltage = powerSupplyVoltage
        self.batteryVoltage = batteryVoltage
        self.centralHeating = centralHeating
        self.domesticHotWater = domesticHotWater
        self.indoor = indoor
        self.outdoor = outdoor
        self.mode = mode
        self.setPoint = setPoint
        self.boilerState = boilerState
    }
}
