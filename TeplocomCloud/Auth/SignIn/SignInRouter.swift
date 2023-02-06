//
//  SignInRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol SignInRoutingLogic {
    func navigateToSMSCodeScreen(navigateType: SignIn.Model.Router.RoutingType)
}

// MARK: - Router

final class SignInRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension SignInRouter: SignInRoutingLogic {
    func navigateToSMSCodeScreen(navigateType: SignIn.Model.Router.RoutingType) {
        switch navigateType {

        case .showSMSCodeScreen(phoneNumber: let phoneNumber):
            let smsCodeVC = SMSCodeViewController()
            smsCodeVC.router?.dataStore?.phoneNumber = phoneNumber
            viewController?.present(smsCodeVC, animated: true, completion: nil)
        }
    }
}
