//
//  PhoneNumberChangeRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol PhoneNumberChangeRoutingLogic {
    func navigateTo(navigationType: PhoneNumberChange.Model.Router.RoutingType)
}

// MARK: - Router

final class PhoneNumberChangeRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension 

extension PhoneNumberChangeRouter: PhoneNumberChangeRoutingLogic {
    func navigateTo(navigationType: PhoneNumberChange.Model.Router.RoutingType) {
        switch navigationType {

        case .showSecondPhoneChangeScreen:
            let twoPhoneChangeVC = TwoPhoneChangeViewController()
            viewController?.navigationController?.pushViewController(twoPhoneChangeVC, animated: true)
        }
    }
}
