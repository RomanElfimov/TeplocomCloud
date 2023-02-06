//
//  HotDataViewModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.10.2022.
//

import UIKit

struct HotDataViewModel {
    /// gsmBalance - баланс сим карты
    let simBalance: String
    /// gsmRssi - уровень сигнала сим
    let simSignalLevel: UIImage
    /// powerSupplyVoltage - напряжение от сети
    let supplyVoltage: Bool
    /// batteryVoltage - напряжение батареи
    let batteryVoltage: Bool
    /// Температура теполносителя
    let centralHeatingTemp: String
    /// Температура ГВС
    let domesticHotWaterTemp: String
    /// Температура внутри помещения
    let indoorTemp: String
    /// Температура на улице
    let outdoorTemp: String
    /// Подключенное оборудование
    let mode: String
    /// Температура, установленная пользователем
    let setPoint: String
    /// Состояние котла Вкл. / Выкл.
    let boilerState: Bool

}
