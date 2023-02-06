//
//  SensorsListRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol SensorsListRoutingLogic {
    func navigateTo(navigateType: SensorsList.Model.Router.RoutingLogic)
}

// MARK: - Router

final class SensorsListRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension SensorsListRouter: SensorsListRoutingLogic {
    func navigateTo(navigateType: SensorsList.Model.Router.RoutingLogic) {
        switch navigateType {

        case .addNewSensor:
            let sensorLoaderVC = SensorLoaderViewController()
            viewController?.present(sensorLoaderVC, animated: true)

        case .editSensor(_, let sensorId):
            let sensorSettingsVC = SensorSettingsViewController()
            let sensorSettingsNavVC = UINavigationController(rootViewController: sensorSettingsVC)
            sensorSettingsNavVC.modalPresentationStyle = .fullScreen
            sensorSettingsVC.router?.dataStore?.sensorID = sensorId
            viewController?.present(sensorSettingsNavVC, animated: true, completion: nil)
        }
    }

}
