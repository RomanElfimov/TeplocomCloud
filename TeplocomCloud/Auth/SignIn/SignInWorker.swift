//
//  SignInWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.08.2021.
//

import Foundation

final class SignInService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    public func fetchAuthCode(parameters: [String: String], completion: @escaping (AuthCodeBackendModel) -> Void) {
        networkLayer.getAuthCode(parameters: parameters) { result in
            guard let result = result else { print("AuthCodeBackendModel is nil"); return }
            completion(result)
        }
    }

}
