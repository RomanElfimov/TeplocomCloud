//
//  Presenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.08.2021.
//

import Foundation

// MARK: - Presetation Logic protocol

protocol SignInPresentationLogic {
    func presentData(response: SignIn.Model.Response.ResponseType)
}

// MARK: - Presenter

final class SignInPresenter {

    // MARK: - External var

    weak var viewController: SignInDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension SignInPresenter: SignInPresentationLogic {
    func presentData(response: SignIn.Model.Response.ResponseType) {
        switch response {

        case .presentAuthCode(model: let model):
            viewController?.displayData(viewModel: .displayAuthCode(viewModel: model))

        case .error(let description):
            viewController?.displayData(viewModel: .error(description: description))
        }
    }
}
