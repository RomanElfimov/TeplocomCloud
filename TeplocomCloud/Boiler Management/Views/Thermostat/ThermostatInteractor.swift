//
//  BoilerManagementInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.05.2022.
//

import Foundation

// MARK: - BusinessLogic Protocol

protocol ThermostatBusinessLogic {
    func makeRequest(event: ThermostatManagement.Model.Request.RequestType)
}

// MARK: - Interactor 

final class ThermostatInteractor {

    // MARK: - External vars

    public var presenter: ThermostatPresentationLogic?

    // MARK: - Internal vars

    private var service: ThermostatService?
}

// MARK: - Business Logic Extension

extension ThermostatInteractor: ThermostatBusinessLogic {
    func makeRequest(event: ThermostatManagement.Model.Request.RequestType) {
        if service == nil {
            service = ThermostatService()
        }

        switch event {
        case .fetchBoilerSettings:

            service?.fetchBoilerSettings(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentBoilerSettings(data: result))
            })

        case .editBoilerSettings(let parameters):
            service?.editBoilerSettings(parameters: parameters, statusCodeCompletion: { [weak self] statusCode in
                self?.presenter?.presentData(event: .editBoilerSettings(statusCode: statusCode))
            })
        }
    }
}
