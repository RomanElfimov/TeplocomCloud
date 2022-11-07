//
//  OffViewRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import Foundation

// MARK: - Routing Logic Protocol

protocol OffViewRoutingLogic {
    func dismiss()
}

// MARK: - Router

final class OffViewRouter {
    weak var view: OffView?
}

// MARK: - Presentation Logic Extension

extension OffViewRouter: OffViewRoutingLogic {
    func dismiss() {
        view?.dismissDelegate?.hideBoilerView()
    }
}
