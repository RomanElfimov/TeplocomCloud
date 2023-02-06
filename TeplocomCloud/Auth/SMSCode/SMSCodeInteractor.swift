//
//  SMSCodeInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

// MARK: - Business Logic protocol

protocol SMSCodeBusinessLogic {
    func makeRequest(request: SMSCode.Model.Request.RequestType)
}

// MARK: - Store Protocol

protocol SMSCodeDetailsStoreProtocol: AnyObject {

    // MARK: - External vars

    var phoneNumber: String { get set }
}

// MARK: - Interactor

final class SMSCodeInteractor: SMSCodeDetailsStoreProtocol {

    // MARK: - External vars

    var phoneNumber: String = "77777"
    var service: SMSCodeService?
    var presenter: SMSCodePresentationLogic?
}

// MARK: - Extension BusinessLogic

extension SMSCodeInteractor: SMSCodeBusinessLogic {

    func makeRequest(request: SMSCode.Model.Request.RequestType) {
        if service == nil {
            service = SMSCodeService()
        }

        switch request {

        case .getPhoneNumber:
            presenter?.presentData(response: .presentPhoneNumber(phoneNumber: phoneNumber))

        case .logIn(let parameters):
            service?.fetchLogin(parameters: parameters, completion: { [weak self] result in
                if let error = result.error {
                    print("Error in fetchAuthCode: \(error)")
                    self?.presenter?.presentData(response: .error(description: error))
                } else {
                    self?.presenter?.presentData(response: .presentLogIn(model: result))
                }
            })
        }
    }
}
