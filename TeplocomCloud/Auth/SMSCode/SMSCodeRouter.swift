//
//  SMSCodeRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol SMSCodeRoutingLogic {
    func showMainScreen(navigateType: SMSCode.Model.Router.RoutingType)
}

// MARK: - Data Passing Protocol

protocol SMSCodeDataPassingProtocol {
    var dataStore: SMSCodeDetailsStoreProtocol? { get }
}

// MARK: - Router

final class SMSCodeRouter: SMSCodeDataPassingProtocol {

    // MARK: - External vars

    weak var dataStore: SMSCodeDetailsStoreProtocol?
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension SMSCodeRouter: SMSCodeRoutingLogic {
    func showMainScreen(navigateType: SMSCode.Model.Router.RoutingType) {
        switch navigateType {
        case .showBindedDevicesListScreen:

            let bindedDevicesVC = BindedDevicesViewController()
            bindedDevicesVC.router?.dataStore?.isFromAuthScreen = true

            let navVC = UINavigationController(rootViewController: bindedDevicesVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.navigationBar.tintColor = .white

            viewController?.present(navVC, animated: true, completion: nil)
        }
    }
}
