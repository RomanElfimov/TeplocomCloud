//
//  SensorsExpertSettingsRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.10.2022.
//

import UIKit

// MARK: - RoutingLogic Protocol

protocol SensorsExpertSettingsRoutingLogic {
    func navigateToSensorSettings()
}

// MARK: - DataPassingProtocol

protocol SensorsExpertSettingsDataPassingProtocol {
    var dataStore: SensorsExpertSettingsStoreProtocol? { get }
}

// MARK: - Router Class

final class SensorsExpertSettingsRouter: SensorsExpertSettingsDataPassingProtocol {

    // MARK: - External vars

    weak var dataStore: SensorsExpertSettingsStoreProtocol?
    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Protocol Extension

extension SensorsExpertSettingsRouter: SensorsExpertSettingsRoutingLogic {
    func navigateToSensorSettings() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
