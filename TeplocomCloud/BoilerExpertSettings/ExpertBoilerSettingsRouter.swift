//
//  ExpertBoilerSettingsRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.05.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol ExpertBoilerSettingsRoutingLogic {
    func dismiss()
}

// MARK: - Router

final class ExpertBoilerSettingsRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension ExpertBoilerSettingsRouter: ExpertBoilerSettingsRoutingLogic {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
