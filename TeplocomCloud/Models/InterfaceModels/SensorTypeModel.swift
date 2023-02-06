//
//  SensorTypeModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

/// Enum for adding sensor
enum SensorTypeModel: Int, CustomStringConvertible {

    case indoorTemp
    case outdoorTemp
    case domesticHotWaterTemp
    case gvcTemp
    case leakageTemp
    case undefinedSensor

    var description: String {
        switch self {
        case .indoorTemp:
            return "Теплоноситель"
        case .outdoorTemp:
            return "ГВС"
        case .domesticHotWaterTemp:
            return "Комната"
        case .gvcTemp:
            return "Улица"
        case .leakageTemp:
            return "Информационный"
        case .undefinedSensor:
            return "Неопределенный"
        }
    }

    var image: UIImage {
        switch self {
        case .indoorTemp:
            return UIImage(named: "indoorTemp") ?? UIImage()
        case .outdoorTemp:
            return UIImage(named: "outdoorTemp") ?? UIImage()
        case .domesticHotWaterTemp:
            return UIImage(named: "domesticHotWaterTemp") ?? UIImage()
        case .gvcTemp:
            return UIImage(named: "gvcTemp") ?? UIImage()
        case .leakageTemp:
            return UIImage(named: "leakageTemp") ?? UIImage()
        case .undefinedSensor:
            return UIImage(named: "leakageTemp") ?? UIImage()
        }
    }
}
