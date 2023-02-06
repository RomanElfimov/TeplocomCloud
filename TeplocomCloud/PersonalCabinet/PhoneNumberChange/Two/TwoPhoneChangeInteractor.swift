//
//  TwoPhoneChangeInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

// MARK: - Business Logic Protocol

protocol TwoPhoneChangeBusinessLogic {
    func makeRequest(request: TwoPhoneChange.Model.Request.RequestType)
}

// MARK: - Interactor

final class TwoPhoneChangeInteractor {

    // MARK: - External vars

    var service: TwoPhoneChangeService?
    var presenter: TwoPhoneChangePresentationLogic?
}

// MARK: - Business Logic Extension

extension TwoPhoneChangeInteractor: TwoPhoneChangeBusinessLogic {
    func makeRequest(request: TwoPhoneChange.Model.Request.RequestType) {
        if service == nil {
            service = TwoPhoneChangeService()
        }

        switch request {

        case .fetchSMSCode(let parameters):
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
