//
//  AboutDeviceRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol AboutDeviceRoutingLogic {
    func dismiss()
    func showNotificationSettings()
}

// MARK: - Router

final class AboutDeviceRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension AboutDeviceRouter: AboutDeviceRoutingLogic {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }

    func showNotificationSettings() {
        let notifyVC = NotificationSettingsViewController()
        let nav = UINavigationController(rootViewController: notifyVC)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.tintColor = .white
        viewController?.present(nav, animated: true, completion: nil)
    }
}
