//
//  MenuControllerRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

// MARK: - Routing Logic Protocol

protocol MenuRoutingLogic {
    func navigate(to controller: UIViewController)
}

// MARK: - Router class

final class MenuRouter {

    // MARK: - External vars

    weak var viewController: UIViewController?
}

// MARK: - Routing Logic Extension

extension MenuRouter: MenuRoutingLogic {

    func navigate(to controller: UIViewController) {
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.tintColor = .white
        viewController?.present(nav, animated: true, completion: nil)
    }
}
