//
//  Presenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

// MARK: - Presetation Logic protocol

protocol SMSCodePresentationLogic {
    func presentData(response: SMSCode.Model.Response.ResponseType)
}

// MARK: - Presenter

final class SMSCodePresenter {

    // MARK: - External var

    weak var viewController: SMSCodeDisplayLogic?
}

// MARK: - Extension PresentationLogic

extension SMSCodePresenter: SMSCodePresentationLogic {
    func presentData(response: SMSCode.Model.Response.ResponseType) {
        switch response {

        case .presentPhoneNumber(phoneNumber: let phoneNumber):
            viewController?.displayData(viewModel: .displayPhoneNumber(phoneNumber: phoneNumber))

        case .presentLogIn(let model):
            viewController?.displayData(viewModel: .displayLogIn(viewModel: model))

        case .error(let description):
            viewController?.displayData(viewModel: .error(description: description))
        }
    }
}
