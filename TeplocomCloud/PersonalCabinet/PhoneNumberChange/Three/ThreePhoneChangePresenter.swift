//
//  ThreePhoneChangePresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

// MARK: - Presetation Logic protocol

protocol ThreePhoneChangePresentationLogic {
    func presentData(response: ThreePhoneChange.Model.Response.ResponseType)
}

// MARK: - Presenter

final class ThreePhoneChangePresenter {

    // MARK: - External var

    weak var viewController: ThreePhoneChangeDisplayLogic?
}

// MARK: - Extension PresentationLogic

extension ThreePhoneChangePresenter: ThreePhoneChangePresentationLogic {
    func presentData(response: ThreePhoneChange.Model.Response.ResponseType) {

        switch response {

        case .presentSMSCode:
            viewController?.displayData(viewModel: .displaySMSCode)

        case .error(let description):
            viewController?.displayData(viewModel: .error(description: description))
        }
    }
}
