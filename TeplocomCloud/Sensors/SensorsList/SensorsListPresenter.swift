//
//  SensorsListPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol SensorsListPresentationLogic {
    func presentData(event: SensorsList.Model.Response.ResposneType)
}

// MARK: - Presenter

final class SensorsListPresenter {

    // MARK: - External vars

    weak var viewController: SensorsListDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension SensorsListPresenter: SensorsListPresentationLogic {
    func presentData(event: SensorsList.Model.Response.ResposneType) {
        switch event {
        case .presentSensors(let data):

            viewController?.displayData(event: .displaySensorsList(data: data))
        }
    }
}
