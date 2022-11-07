//
//  HandleViewRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import Foundation

// MARK: - Routing Logic Protocol

protocol HandleViewRoutingLogic {
    func dismiss()
}

// MARK: - Router

final class HandleViewRouter {

    // MARK: - External vars

    weak var view: HandleView?
}

// MARK: - Routing Logic Extension

extension HandleViewRouter: HandleViewRoutingLogic {
    func dismiss() {
        view?.dismissDelegate?.hideBoilerView()
    }
}
