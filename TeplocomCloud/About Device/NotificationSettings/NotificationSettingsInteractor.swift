//
//  NotificationSettingsInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

// MARK: - Business Logic Protocol

protocol NotificationSettingsBusinessLogic {
    func makeRequest(event: NotificationSettings.Model.Request.RequestType)
}

// MARK: - Interactor

final class NotificationSettingsInteractor {

    // MARK: - External vars

    public var presenter: NotificationSettingsPresentationLogic?

    // MARK: - Internal vars

    private var service: NotificationSettingsService?
}

// MARK: - Business Logic Extension

extension NotificationSettingsInteractor: NotificationSettingsBusinessLogic {
    func makeRequest(event: NotificationSettings.Model.Request.RequestType) {
        if service == nil {
            service = NotificationSettingsService()
        }

        switch event {
        case .fetchSettings:
            service?.fetchNotificationSettings(completion: { [weak self] result in
                self?.presenter?.presentData(event: .fetchSettings(data: result))
            })
        case .editSettings(parameters: let parameters):
            service?.editNotificationSettings(parameters: parameters, statusCodeCompletion: { [weak self] statusCode in
                self?.presenter?.presentData(event: .editSettings(status: statusCode))
            })
        }
    }
}
