//
//  EmailManagementRouter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

// MARK: - Routing Logic Protocol

protocol EmailManagementRoutingLogic {}

// MARK: - Data Passing Protocol

protocol EmailManagementDataPassingProtocol {
    var dataStore: EmailManagementStoreProtocol? { get }
}

// MARK: - Router

final class EmailManagementRouter: EmailManagementDataPassingProtocol {

    // MARK: - External vars

    weak var dataStore: EmailManagementStoreProtocol?
}

// MARK: - Routing Logic Extension

extension EmailManagementRouter: EmailManagementRoutingLogic {}
