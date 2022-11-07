//
//  SensorLoaderPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

// MARK: - Presentation Logic Protocol

protocol SensorLoaderPresentaionLogic {
    func presentData(event: SensorLoader.Model.Response.ResponseType)
}

// MARK: - Presenter Class

final class SensorLoaderPresenter {

    // MARK: - External vars

    weak var viewController: SensorLoaderDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension SensorLoaderPresenter: SensorLoaderPresentaionLogic {
    func presentData(event: SensorLoader.Model.Response.ResponseType) {
        switch event {
        case .presentUnallocatedSensor(let data):
            viewController?.displayData(event: .displayUnallocatedSensor(result: data))
        }
    }
}
