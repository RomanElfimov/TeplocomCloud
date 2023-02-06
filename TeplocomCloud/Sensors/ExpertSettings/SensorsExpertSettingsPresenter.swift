//
//  SensorsExpertSettingsPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.10.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol SensorsExpertSettingsPresentationLogic {
    func presentData(event: SensorsExpertSettings.Model.Response.ResponseType)
}

// MARK: - Presenter

final class SensorsExpertSettingsPresenter {

    // MARK: - External vars

    weak var viewController: SensorsExpertSettingsDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension SensorsExpertSettingsPresenter: SensorsExpertSettingsPresentationLogic {
    func presentData(event: SensorsExpertSettings.Model.Response.ResponseType) {
        switch event {

        case .fetchSensorsExpertSettings(data: let data):

            let viewModel = TemperatureSensorExpertSettingsViewModel(roundWindow: "\(data.roundWindow / 60) мин.",
                                                                     defaultValue: "\(data.defaultValue / 100) ˚C",
                                                                     notifyOnLowerLimit: data.notifyOnLowerLimit,
                                                                     notifyOnUpperLimit: data.notifyOnUpperLimit,
                                                                     notifyOnFailure: data.notifyOnFailure,
                                                                     notifyInterval: "\(data.notifyInterval / 60) мин.",
                                                                     notifyQuantity: "\(data.notifyQuantity)")
            viewController?.displayData(event: .fetchSensorsExpertSettings(data: viewModel))

        case .editSensorsExpertSettingseditSensorsExpertSettings(statusCode: let statusCode):
            viewController?.displayData(event: .editSensorsExpertSettingseditSensorsExpertSettings(statusCode: statusCode))
        }
    }
}
