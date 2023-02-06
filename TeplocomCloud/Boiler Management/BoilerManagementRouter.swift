//
//  BoilerManagementRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol BoilerManagementRoutingLogic {
    func dismiss()
}

// MARK: - Router

final class BoilerManagementRouter {
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension BoilerManagementRouter: BoilerManagementRoutingLogic {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
