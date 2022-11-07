//
//  TwoPhoneChangeRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol TwoPhoneChangeRoutingLogic {
    func navigateToDetail(navigationType: TwoPhoneChange.Model.Router.RoutingType)
}

// MARK: - Router

final class TwoPhoneChangeRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension TwoPhoneChangeRouter: TwoPhoneChangeRoutingLogic {
    func navigateToDetail(navigationType: TwoPhoneChange.Model.Router.RoutingType) {

        switch navigationType {

        case .showThirdPhoneChangeScreen:
            let threePhoneChangeVC = ThreePhoneChangeViewController()
            viewController?.navigationController?.pushViewController(threePhoneChangeVC, animated: true)
        }
    }
}
