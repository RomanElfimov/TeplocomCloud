//
//  SMSCodeWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation
import KeychainSwift

final class SMSCodeService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    public func fetchLogin(parameters: [String: String], completion: @escaping(LoginBackendModel) -> Void) {
        networkLayer.login(parameters: parameters) { result in
            guard let result = result else { print("LoginBackendModel is nil"); return }

            let keychain = KeychainSwift(keyPrefix: "Teplocom")

            let token = result.esia?.jwt ?? ""
            let refreshToken = result.esia?.refreshToken ?? ""

            if keychain.set(token, forKey: "token") { print("KEYCHAIN SET token") }
            if keychain.set(refreshToken, forKey: "refreshToken") { print("KEYCHAIN SET refresh token") }

            completion(result)
        }
    }
}
