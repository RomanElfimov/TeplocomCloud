//
//  PhoneNumberChangePresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol PhoneNumberChangePresentationLogic {
    func presentData(response: PhoneNumberChange.Model.Response.ResponseType)
}

// MARK: - Presenter

final class PhoneNumberChangePresenter {

    // MARK: - External var

    weak var viewController: PhoneNumberChangeDisplayLogic?
}

// MARK: - Extension PresentationLogic

extension PhoneNumberChangePresenter: PhoneNumberChangePresentationLogic {
    func presentData(response: PhoneNumberChange.Model.Response.ResponseType) {

        switch response {

        case .presentPhoneNumberChange:
            viewController?.displayData(viewModel: .displayPhoneNumberChange)

        case .error(description: let description):
            viewController?.displayData(viewModel: .error(description: description))
        }
    }
}
