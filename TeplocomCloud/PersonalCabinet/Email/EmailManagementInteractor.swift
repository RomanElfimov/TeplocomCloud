//
//  EmailManagementInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

// MARK: - Business Logic Protocol

protocol EmailManagementBusinessLogic {
    func makeRequest(request: EmailManagement.Model.Request.RequestType)
}

// MARK: - Store Protocol

protocol EmailManagementStoreProtocol: AnyObject {
    var email: String { get set }
    var isEmailVerified: Bool { get set }
}

// MARK: - Interactor

final class EmailManagementInteractor: EmailManagementStoreProtocol {

    // MARK: - External vars

    var email: String = "7777"
    var isEmailVerified: Bool = true

    var service: EmailManagementService?
    var presenter: EmailManagementPresentationLogic?
}

// MARK: - Business Logic Extension

extension EmailManagementInteractor: EmailManagementBusinessLogic {
    func makeRequest(request: EmailManagement.Model.Request.RequestType) {
        if service == nil {
            service = EmailManagementService()
        }

        switch request {
        case .getEmailData:
            presenter?.presentData(response: .presentEmailInfo(email: email, isVerified: isEmailVerified))

        case .changeEmail(let newEmailParameters):
            service?.changeEmail(parameters: newEmailParameters, completion: { [weak self] newEmail in
                if let error = newEmail.error {
                    print("Error in changeEmail: \(error)")
                } else {
                    self?.presenter?.presentData(response: .presentChangeEmail(response: newEmail))
                }
            })

        case .verifyEmail(let emailParameters):
            service?.changeEmail(parameters: emailParameters, completion: { [weak self] newEmail in
                if let error = newEmail.error {
                    print("Error in changeEmail: \(error)")
                    self?.presenter?.presentData(response: .error(description: error))
                } else {
                    self?.presenter?.presentData(response: .presentVerifyEmail)
                }
            })
        }
    }

}
