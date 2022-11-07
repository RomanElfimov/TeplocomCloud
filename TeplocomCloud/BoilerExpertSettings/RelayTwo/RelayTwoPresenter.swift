//
//  RelayTwoPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol RelayTwoPresentationLogic {
    func presentData(event: RelayTwo.Model.Response.ResponseType)
}

// MARK: - Presenter

final class RelayTwoPresenter {

    // MARK: - External vars

    weak var viewController: RelayTwoDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension RelayTwoPresenter: RelayTwoPresentationLogic {
    func presentData(event: RelayTwo.Model.Response.ResponseType) {
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
