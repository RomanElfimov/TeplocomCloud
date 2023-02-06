//
//  BindedDevicesPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.02.2022.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol BindedDevicesPresentationLogic {
    func presentData(event: BindedDevices.Model.Response.ResponseType)
}

// MARK: - Presenter

final class BindedDevicesPresenter {

    // MARK: - External vars

    weak var viewController: BindedDevicesDispayLogic?
}

// MARK: - Presentation Logic Extension

extension BindedDevicesPresenter: BindedDevicesPresentationLogic {
    func presentData(event: BindedDevices.Model.Response.ResponseType) {
        switch event {
        case .presentBindedDevices(let data):

            let viewModel = data.map { model -> BindedDevicesViewModel in
                let vm = BindedDevicesViewModel(name: model.clientName, status: model.status, uid: "\(model.uid)")
                return vm
            }

            viewController?.displayData(event: .displayBindedDevices(data: viewModel))
        }
    }
}
