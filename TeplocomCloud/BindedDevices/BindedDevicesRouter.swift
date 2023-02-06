//
//  BindedDevicesRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

// MARK: - RoutingLogic Protocol

protocol BindedDevicesRoutingLogic {
    func navigateToMain()
}

// MARK: - DataPassingProtocol

protocol BindedDevicesDataPassingProtocol {

    // MARK: - External var

    var dataStore: BindedDevicesStoreProtocol? { get }
}

// MARK: - Router Class

final class BindedDevicesRouter: BindedDevicesDataPassingProtocol {

    // MARK: - External vars

    weak var dataStore: BindedDevicesStoreProtocol?
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Protocol Extension

extension BindedDevicesRouter: BindedDevicesRoutingLogic {

    func navigateToMain() {
        guard let isFromAuth = dataStore?.isFromAuthScreen else { return }

        if isFromAuth {

            let navVC = UINavigationController(rootViewController: MainViewController())
            navVC.modalPresentationStyle = .fullScreen
            viewController?.present(navVC, animated: true, completion: nil)

        } else {

            let mainVC = UINavigationController(rootViewController: MainViewController())
            mainVC.modalPresentationStyle = .fullScreen

            // dismissing to main vc
            self.viewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
