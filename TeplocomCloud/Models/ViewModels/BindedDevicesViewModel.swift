//
//  BindedDevicesViewModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import Foundation

/// Получение устройств связанных с пользователем
struct BindedDevicesViewModel: Equatable {
    /// Пользовательское имя устройства
    let name: String
    let status: Bool
    let uid: String
}
