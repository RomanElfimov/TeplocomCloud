//
//  MainScreenInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol MainScreenBusinessLogic {
    func makeRequest(event: MainScreen.Model.Request.RequestType)
}

// MARK: - Interactor

final class MainScreenInteractor {

    // MARK: - External vars

    public var presenter: MainScreenPresentationLogic?

    // MARK: - Internal vars

    private var service: MainScreenService?
}

// MARK: - Business Logic Extension

extension MainScreenInteractor: MainScreenBusinessLogic {
    func makeRequest(event: MainScreen.Model.Request.RequestType) {
        if service == nil {
            service = MainScreenService()
        }

        switch event {
        case .fetchHotData:
            service?.fetchHotData(completion: { [weak self] result in
                self?.presenter?.presentData(event: .presentHotData(data: result))
            })

        case .switchBoiler:
            service?.switchBoilerState(statusCodeCompletion: { [weak self] statusCode in
                self?.presenter?.presentData(event: .presentSwitchBoiler(statusCode: statusCode))
            })
        }
    }
}
