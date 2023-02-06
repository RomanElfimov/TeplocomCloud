//
//  SensorTypeRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol SensorTypeRoutingLogic {
    func navigateToSensorSettings(sensorType: String)
}

// MARK: - Router class

final class SensorTypeRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension SensorTypeRouter: SensorTypeRoutingLogic {
    func navigateToSensorSettings(sensorType: String) {
        let sensorSettingsVC = SensorSettingsViewController()
        let sensorSettingsNavVC = UINavigationController(rootViewController: sensorSettingsVC)
        sensorSettingsNavVC.modalPresentationStyle = .fullScreen
        sensorSettingsVC.router?.dataStore?.sensorType = sensorType
        viewController?.present(sensorSettingsNavVC, animated: true, completion: nil)
    }
}
