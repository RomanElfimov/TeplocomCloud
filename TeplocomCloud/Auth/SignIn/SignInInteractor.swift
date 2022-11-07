//
//  SignInInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.08.2021.
//

import UIKit

// MARK: - Business Logic protocol

protocol SignInBusinessLogic {
    func makeRequest(request: SignIn.Model.Request.RequestType)
}

// MARK: - Interactor

final class SignInInteractor {

    // MARK: - External vars

    var presenter: SignInPresentationLogic?
    var service: SignInService?
}

// MARK: - Business Logic Extension

extension SignInInteractor: SignInBusinessLogic {

    func makeRequest(request: SignIn.Model.Request.RequestType) {
        if service == nil {
            service = SignInService()
        }

        switch request {
        case .fetchAuthCode(parameters: let parameters):
            service?.fetchAuthCode(parameters: parameters, completion: { [weak self] result in
                if let error = result.error {
                    print("Error in fetchAuthCode: \(error)")
                    self?.presenter?.presentData(response: .error(description: error))
                } else {
                    self?.presenter?.presentData(response: .presentAuthCode(model: result))
                }
            })
        }
    }

}
