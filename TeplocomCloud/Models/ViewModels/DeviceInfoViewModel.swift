//
//  DeviceInfoViewModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation

struct DeviceInfoViewModel {
    /// Пользовательское имя устройства
    let deviceName: String
    /// Текущая версия прошивки
    let currentFirmwareVersion: String
    /// Версия, на которую можно обновиться
    let availableFirmwareVersion: String
}
