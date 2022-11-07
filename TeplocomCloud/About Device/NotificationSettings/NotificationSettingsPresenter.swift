//
//  NotificationSettingsPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol NotificationSettingsPresentationLogic {
    func presentData(event: NotificationSettings.Model.Response.ResponseType)
}

// MARK: - Presenter

final class NotificationSettingsPresenter {

    // MARK: - External var

    weak var viewController: NotificationSettingsDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension NotificationSettingsPresenter: NotificationSettingsPresentationLogic {
    func presentData(event: NotificationSettings.Model.Response.ResponseType) {
        switch event {

        case .fetchSettings(data: let data):
            viewController?.displayData(event: .fetchSettings(data: data))

        case .editSettings(status: let status):
            viewController?.displayData(event: .editSettings(status: status))
        }
    }
}
