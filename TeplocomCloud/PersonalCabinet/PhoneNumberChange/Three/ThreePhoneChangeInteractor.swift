//
//  ThreePhoneChangeInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

// MARK: - Business Logic protocol

protocol ThreePhoneChangeBusinessLogic {
    func makeRequest(request: ThreePhoneChange.Model.Request.RequestType)
}

// MARK: - Interactor

final class ThreePhoneChangeInteractor {

    // MARK: - External vars

    var service: ThreePhoneChangeService?
    var presenter: ThreePhoneChangePresentationLogic?
}

// MARK: - Extension BusinessLogic

extension ThreePhoneChangeInteractor: ThreePhoneChangeBusinessLogic {
    func makeRequest(request: ThreePhoneChange.Model.Request.RequestType) {
        if service == nil {
            service = ThreePhoneChangeService()
        }

        switch request {

        case .fetchSMSCode(parameters: let parameters):
            service?.fetchSMSCode(paramters: parameters, completion: { [weak self] result in
                if let error = result?.error {
                    print("Error in fetchAuthCode: \(error)")
                    self?.presenter?.presentData(response: .error(description: error))
                } else {
                    self?.presenter?.presentData(response: .presentSMSCode)
                }
            })
        }
    }
}
