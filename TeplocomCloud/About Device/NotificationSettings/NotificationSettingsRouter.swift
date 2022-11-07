//
//  NotificationSettingsRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol NotificationSettingsRoutingLogic {
    func dismiss()
}

// MARK: - Router

final class NotificationSettingsRouter {
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension NotificationSettingsRouter: NotificationSettingsRoutingLogic {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
