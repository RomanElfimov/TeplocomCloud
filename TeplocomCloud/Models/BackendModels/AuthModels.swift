//
//  AuthModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.08.2021.
//

import Foundation

// MARK: - Auth Code

struct AuthCodeBackendModel: Decodable {
    let floodWait: Int?
    let error: String?

    init(floodWait: Int? = nil, error: String? = nil) {
        self.floodWait = floodWait
        self.error = error
    }
}

// MARK: - Login

struct LoginBackendModel: Decodable {

    let confirmedEmail: Bool?
    let esia: ServiceFeedbackModel?
    let registered: Bool?
    let error: String?

    init(confirmedEmail: Bool? = nil, esia: ServiceFeedbackModel? = nil, registered: Bool? = nil, error: String? = nil) {
        self.confirmedEmail = confirmedEmail
        self.esia = esia
        self.registered = registered
        self.error = error
    }
}

struct ServiceFeedbackModel: Decodable, Equatable {
    let jwt: String?
    let refreshToken: String?
    let error: String?
}
