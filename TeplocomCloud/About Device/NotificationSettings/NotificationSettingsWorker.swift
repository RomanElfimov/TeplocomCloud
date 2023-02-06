//
//  NotificationSettingsWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

final class NotificationSettingsService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Methods

    public func fetchNotificationSettings(completion: @escaping(NotificationSettingsModel) -> Void) {
        /*
        networkLayer.getNotificationSettings { result in
            guard let result = result else { return }
            completion(result)
        }
        */

        let mockNotifSettings = NotificationSettingsModel(notifyInterval: 5,
                                                          notifyQuantity: 2,
                                                          notifyBySms: true,
                                                          notifyByCall: false)
        completion(mockNotifSettings)
    }

    public func editNotificationSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {
        /*
        networkLayer.editNotificationSettings(parameters: parameters) { status in
            guard let status = status else { return }
            statusCodeCompletion(status)
        } completion: { _ in }
        */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }
}
