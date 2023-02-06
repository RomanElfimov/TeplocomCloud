//
//  PhoneNumberChangeInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

// MARK: - Business Logic protocol

protocol PhoneNumberChangeBusinessLogic {
    func makeRequest(request: PhoneNumberChange.Model.Request.RequestType)
}

// MARK: - Interactor

final class PhoneNumberChangeInteractor {

    // MARK: - External vars

    var service: PhoneNumberChangeService?
    var presenter: PhoneNumberChangePresentationLogic?
}

// MARK: - Extension BusinessLogic

extension PhoneNumberChangeInteractor: PhoneNumberChangeBusinessLogic {
    func makeRequest(request: PhoneNumberChange.Model.Request.RequestType) {
        if service == nil {
            service = PhoneNumberChangeService()
        }

        switch request {

        case .fetchPhoneNumberChange(newPhoneParameters: let newPhoneParameters):
            service?.fetchPhoneNumberChange(parameters: newPhoneParameters, completion: { [weak self] result in
                if let error = result?.error {
                    print("Error in fetchAuthCode: \(error)")
                    self?.presenter?.presentData(response: .error(description: error))
                } else {
                    self?.presenter?.presentData(response: .presentPhoneNumberChange)
                }
            })
        }
    }
}
