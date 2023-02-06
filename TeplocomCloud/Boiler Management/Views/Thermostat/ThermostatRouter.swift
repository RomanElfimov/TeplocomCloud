//
//  BoilerManagementRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol ThermostatRoutingLogic {
    func navigateTo(event: ThermostatManagement.Model.Router.RoutingLogic)
}

// MARK: - Router

final class ThermostatRouter {

    // MARK: - External vars

    weak var view: ThermostatView?
}

// MARK: - Routing Logic Extension

extension ThermostatRouter: ThermostatRoutingLogic {

    func navigateTo(event: ThermostatManagement.Model.Router.RoutingLogic) {
        switch event {

        case .dismiss:
            view?.dismissDelegate?.hideBoilerView()

        case .expertSettings:
            let expertVC = BoilerExpertSettingsViewController()
            let navExpertVC = UINavigationController(rootViewController: expertVC)
            navExpertVC.modalPresentationStyle = .fullScreen
            view?.presentDelegate?.presentController(with: navExpertVC)
        }
    }
}
