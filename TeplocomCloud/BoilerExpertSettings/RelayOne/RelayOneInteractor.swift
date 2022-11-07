//
//  RelayOneInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol RelayOneBusinessLogic {
    func makeRequest(event: RelayOne.Model.Request.RequestType)
}

// MARK: - Interactor

final class RelayOneInteractor {
    public var presenter: RelayOnePresentationLogic?
    private var service: BoilerExpertSettingsService?
}

// MARK: - Business Logic Extension

extension RelayOneInteractor: RelayOneBusinessLogic {
    func makeRequest(event: RelayOne.Model.Request.RequestType) {
        if service == nil {
            service = BoilerExpertSettingsService()
        }

        switch event {
        case .fetchExpertSettings:
            service?.fetchBoilerExpertSettings(completion: { [weak self] result in
                self?.presenter?.presentData(event: .fetchExpertSettings(data: result))
            })

        case .editExpertSettings(parameters: let parameters):
            service?.editBoilerExpertSettings(parameters: parameters, statusCodeCompletion: { [weak self] status in
                self?.presenter?.presentData(event: .editExpertSettings(statusCode: status))
            })
        }
    }
}
