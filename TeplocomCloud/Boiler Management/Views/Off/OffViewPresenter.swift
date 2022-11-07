//
//  OffViewPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol OffViewPresentationLogic {
    func presentData(event: OffViewModel.Model.Response.ResponseType)
}

// MARK: - Presenter

final class OffViewPresenter {

    // MARK: - External var

    weak var view: OffViewDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension OffViewPresenter: OffViewPresentationLogic {
    func presentData(event: OffViewModel.Model.Response.ResponseType) {
        switch event {

        case .editBoilerSettings(let statusCode):
            view?.displayData(event: .editBoilerSettings(statusCode: statusCode))
        }
    }
}
