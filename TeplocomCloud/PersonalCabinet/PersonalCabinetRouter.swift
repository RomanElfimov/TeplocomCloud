//
//  PersonalCabinetRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol PersonalCabinetRoutingLogic {
    func navigateToDetail(navigationType: PersonalCabinet.Model.Router.RoutingLogic)
}

// MARK: - Router

final class PersonalCabinetRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension PersonalCabinetRouter: PersonalCabinetRoutingLogic {

    func navigateToDetail(navigationType: PersonalCabinet.Model.Router.RoutingLogic) {
        switch navigationType {

        case .navigateToEmailManagement(let email, let isVerified):
            let emailManagementVC = EmailManagementViewController()
            let navVC = UINavigationController(rootViewController: emailManagementVC)
            navVC.modalPresentationStyle = .fullScreen

            emailManagementVC.router?.dataStore?.email = email
            emailManagementVC.router?.dataStore?.isEmailVerified = isVerified
            viewController?.navigationController?.pushViewController(emailManagementVC, animated: true)

        case .navigateToPhoneNumberChange:
            let phoneNumberChangeVC = PhoneNumberChangeViewController()
            viewController?.navigationController?.pushViewController(phoneNumberChangeVC, animated: true)
            viewController?.navigationController?.navigationItem.backButtonDisplayMode = .minimal
        }
    }
}
