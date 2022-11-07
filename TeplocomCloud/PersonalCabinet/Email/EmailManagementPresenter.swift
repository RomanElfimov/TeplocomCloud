//
//  EmailManagementPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol EmailManagementPresentationLogic {
    func presentData(response: EmailManagement.Model.Response.ResponseType)
}

// MARK: - Presenter

final class EmailManagementPresenter {

    // MARK: - External vars

    weak var viewController: EmailManagementDisplayLogic?

    // MARK: - Private Methods

    private func createViewModel(personalData: PersonalInfoBackendModel) -> ChangeEmailViewModel {
        return ChangeEmailViewModel(email: personalData.email ?? "")
    }
}

// MARK: - Presentation Logic Extension

extension EmailManagementPresenter: EmailManagementPresentationLogic {
    func presentData(response: EmailManagement.Model.Response.ResponseType) {
        switch response {

        case .presentEmailInfo(let email, let isVerified):
            viewController?.displayData(viewModel: .displayEmailInfo(email: email, isVerified: isVerified))

        case .presentChangeEmail(let response):
            let viewModel = createViewModel(personalData: response)
            viewController?.displayData(viewModel: .displayChangedEmail(viewModel: viewModel))

        case .presentVerifyEmail:
            viewController?.displayData(viewModel: .displayVerifiedEmail)

        case .error(let error):
            viewController?.displayData(viewModel: .error(description: error))
        }
    }
}
