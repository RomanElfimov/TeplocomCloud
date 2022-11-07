//
//  SensorSettingsRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol SensorSettingsRoutingLogic {
    func navigateToExpertSettings(sensorId: String)
    func dismiss()
}

// MARK: - Data Passing Protocol

protocol SensorSettingsDataPassingProtocol {
    var dataStore: SensorSettingsStoreProtocol? { get }
}

final class SensorSettingsRouter: SensorSettingsDataPassingProtocol {

    // MARK: - External vars

    weak var viewController: UIViewController?
    weak var dataStore: SensorSettingsStoreProtocol?
}

// MARK: - Routing Logic Extension

extension SensorSettingsRouter: SensorSettingsRoutingLogic {
    func navigateToExpertSettings(sensorId: String) {
        let expertSettingsVC = SensorsExpertSettingsViewController()
        let naVC = UINavigationController(rootViewController: expertSettingsVC)
        naVC.modalPresentationStyle = .fullScreen
        expertSettingsVC.router?.dataStore?.sensorId = sensorId
        viewController?.present(naVC, animated: true)
    }

    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
