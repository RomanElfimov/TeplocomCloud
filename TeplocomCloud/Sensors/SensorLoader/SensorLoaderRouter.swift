//
//  SensorLoaderRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol SensorLoaderRoutingLogic {
    func navigateToSensorType()
}

// MARK: - Router class

final class SensorLoaderRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension SensorLoaderRouter: SensorLoaderRoutingLogic {
    func navigateToSensorType() {

        DispatchQueue.main.async {
            let sensorTypeNavVC = UINavigationController(rootViewController: SensorTypeViewController())
            sensorTypeNavVC.modalPresentationStyle = .fullScreen
            self.viewController?.present(sensorTypeNavVC, animated: true, completion: nil)
        }
    }
}
