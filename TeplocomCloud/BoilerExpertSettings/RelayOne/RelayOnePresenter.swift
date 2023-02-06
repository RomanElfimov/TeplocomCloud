//
//  RelayOnePresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol RelayOnePresentationLogic {
    func presentData(event: RelayOne.Model.Response.ResponseType)
}

// MARK: - Presenter

final class RelayOnePresenter {

    // MARK: - External vars

    weak var viewController: RelayOneDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension RelayOnePresenter: RelayOnePresentationLogic {
    func presentData(event: RelayOne.Model.Response.ResponseType) {
        switch event {
        case .fetchExpertSettings(data: let data):

            let viewModel = BoilerExpertSettingsViewModel(boilerControlProtocol: data.boilerControlProtocol,
                                                          hysteresis: Float(data.hysteresis / 100),
                                                          normalState: data.normalState,
                                                          stateOnLeakage: data.stateOnLeakage,
                                                          switchingOnTheBoilerCirculationPump: Float(data.switchingOnTheBoilerCirculationPump / 60))
            viewController?.displayData(event: .fetchExpertSettings(data: viewModel))

        case .editExpertSettings(statusCode: let statusCode):
            viewController?.displayData(event: .editExpertSettings(statusCode: statusCode))
        }
    }
}
