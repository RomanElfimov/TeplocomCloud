//
//  OffViewInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol OffViewBusinessLogic {
    func makeRequest(event: OffViewModel.Model.Request.RequestType)
}

// MARK: - Interactor

final class OffViewInteractor {

    // MARK: - External var

    public var presenter: OffViewPresentationLogic?

    // MARK: - Internal var

    private var service: OffViewService?
}

// MARK: - Business Logic Extension

extension OffViewInteractor: OffViewBusinessLogic {
    func makeRequest(event: OffViewModel.Model.Request.RequestType) {
        if service == nil {
            service = OffViewService()
        }

        switch event {

        case .editBoilerSettings(let parameters):
            service?.editBoilerSettings(parameters: parameters, statusCodeCompletion: { [weak self] statusCode in
                self?.presenter?.presentData(event: .editBoilerSettings(statusCode: statusCode))
            })
        }
    }
}
