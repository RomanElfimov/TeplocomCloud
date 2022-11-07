//
//  TwoPhoneChangePresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol TwoPhoneChangePresentationLogic {
    func presentData(response: TwoPhoneChange.Model.Response.ResponseType)
}

// MARK: - Presenter

final class TwoPhoneChangePresenter {

    // MARK: - External var

    weak var viewController: TwoPhoneChangeDisplayLogic?
}

// MARK: - PresentationLogic Extension

extension TwoPhoneChangePresenter: TwoPhoneChangePresentationLogic {
    func presentData(response: TwoPhoneChange.Model.Response.ResponseType) {
        switch response {

        case .presentSMSCode:
            viewController?.displayData(viewModel: .displaySMSCode)

        case .error(let description):
            viewController?.displayData(viewModel: .error(description: description))
        }
    }
}
