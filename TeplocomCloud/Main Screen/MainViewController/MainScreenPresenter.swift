//
//  MainScreenPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import UIKit

// MARK: - Presentation Logic Protocol

protocol MainScreenPresentationLogic {
    func presentData(event: MainScreen.Model.Response.ResponseType)
}

// MARK: - Presenter

final class MainScreenPresenter {

    // MARK: - External vars

    weak var viewController: MainScreenDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension MainScreenPresenter: MainScreenPresentationLogic {
    func presentData(event: MainScreen.Model.Response.ResponseType) {
        switch event {
        case .presentHotData(let data):

            // Уставка температуры
            let setPoint = data.setPoint != nil ? "\(data.setPoint! / 100) ˚C" : "-/-"

            // Какое устанавливаем изображение в зависимости от уровня сигнала
            var simSignalImage = UIImage()

            if data.gsmRssi >= -50 {
                simSignalImage = UIImage(named: "GSMQuality")!
            } else if (data.gsmRssi >= -60) && (data.gsmRssi < -50) {
                simSignalImage = UIImage(named: "GSMQuality2")!
            } else if (data.gsmRssi >= -70) && (data.gsmRssi < -60) {
                simSignalImage = UIImage(named: "GSMQuality3")!
            } else if data.gsmRssi < -70 {
                simSignalImage = UIImage(named: "GSMQuality4")!
            }

            let viewModel = HotDataViewModel(simBalance: "\(data.gsmBalance / 100) ₽",
                                             simSignalLevel: simSignalImage,
                                             supplyVoltage: data.powerSupplyVoltage,
                                             batteryVoltage: data.batteryVoltage,
                                             centralHeatingTemp: "\(data.centralHeating / 100)˚",
                                             domesticHotWaterTemp: "\(data.domesticHotWater / 100)˚",
                                             indoorTemp: "\(data.indoor / 100)˚",
                                             outdoorTemp: "\(data.outdoor)˚",
                                             mode: data.mode,
                                             setPoint: setPoint,
                                             boilerState: data.boilerState)

            viewController?.displayData(event: .displayHotData(data: viewModel))

        case .presentSwitchBoiler(statusCode: let statusCode):
            viewController?.displayData(event: .displaySwitchBoiler(statusCode: statusCode))
        }
    }
}
