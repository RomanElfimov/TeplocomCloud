//
//  OpenThermInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol OpenThermBusinessLogic: AnyObject {
    func makeRequest(event: OpenTherm.Model.Request.RequestType)
}

// MARK: - Interactor

final class OpenThermInteractor {

    // MARK: - External vars

    public var presenter: OpenThermPresentationLogic?

    // MARK: - Internal vars

    private var service: BoilerExpertSettingsService?
}

// MARK: - Business Logic Extension

extension OpenThermInteractor: OpenThermBusinessLogic {
    func makeRequest(event: OpenTherm.Model.Request.RequestType) {
        if service == nil {
            service = BoilerExpertSettingsService()
        }

        switch event {
        case .fetchOpenThermSettings:
            service?.fetchBoilerOpenThermSettings(completion: { [weak self] result in
                self?.presenter?.presentData(event: .fetchOpenThermSettings(data: result))
            })
        case .editOpenThermSettings(parameters: let parameters):
            service?.editBoilerOpenThermSettings(parameters: parameters, statusCodeCompletion: { [weak self] status in
                self?.presenter?.presentData(event: .editOpenThermSettings(statusCode: status))
            })
        }
    }
}
