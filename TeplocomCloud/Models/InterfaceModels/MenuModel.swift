//
//  MenuModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 29.01.2022.
//

import UIKit

/// Enum for menu options
enum MenuModel: Int, CustomStringConvertible {

    case BackToDevicesList
    case PersonalCabinet
    case BoilerControl
    case AboutDevice
    case Sensors
    case Exit

    var description: String {
        switch self {
        case .BackToDevicesList:
            return "Вернутся к списку устройств"
        case .PersonalCabinet:
            return "Личный кабинет"
        case .BoilerControl:
            return "Управление котлом"
        case .AboutDevice:
            return "Об устройстве"
        case .Sensors:
            return "Датчики"
        case .Exit:
            return "Выйти из аккаунта"
        }
    }

    var image: UIImage {
        switch self {
        case .BackToDevicesList:
            return UIImage(named: "BackToDevicesListIcon") ?? UIImage()
        case .PersonalCabinet:
            return UIImage(named: "PersonalCabinetIcon") ?? UIImage()
        case .BoilerControl:
            return UIImage(named: "BoilerControlIcon") ?? UIImage()
        case .AboutDevice:
            return UIImage(named: "GSMSettingsIcon") ?? UIImage()
        case .Sensors:
            return UIImage(named: "SensorsIcon") ?? UIImage()
        case .Exit:
            return UIImage(systemName: "chevron.backward.square.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!) ?? UIImage()
        }
    }
}
