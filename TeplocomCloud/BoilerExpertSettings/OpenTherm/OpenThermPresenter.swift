//
//  OpenThermPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol OpenThermPresentationLogic {
    func presentData(event: OpenTherm.Model.Response.ResponseType)
}

// MARK: - Presenter

final class OpenThermPresenter {

    // MARK: - External vars

    weak var viewController: OpenThermDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension OpenThermPresenter: OpenThermPresentationLogic {
    func presentData(event: OpenTherm.Model.Response.ResponseType) {
        switch event {

        case .fetchOpenThermSettings(data: let data):
            let viewModel = BoilerOpenThermSettingsBackendModel(maxDomesticHotWaterTemperature: data.maxDomesticHotWaterTemperature / 100,
                                                                minDomesticHotWaterTemperature: data.minDomesticHotWaterTemperature  / 100,
                                                                setPointDomesticHotWater: data.setPointDomesticHotWater  / 100,
                                                                maxHeatingMediumTemperature: data.maxHeatingMediumTemperature  / 100,
                                                                minHeatingMediumTemperature: data.minHeatingMediumTemperature  / 100,
                                                                maximumBurnerModulation: data.maximumBurnerModulation,
                                                                configurationDomesticHotWater: data.configurationDomesticHotWater)
            viewController?.displayData(event: .fetchOpenThermSettings(data: viewModel))
        case .editOpenThermSettings(let statusCode):
            viewController?.displayData(event: .editOpenThermSettings(statusCode: statusCode))
        }
    }
}
