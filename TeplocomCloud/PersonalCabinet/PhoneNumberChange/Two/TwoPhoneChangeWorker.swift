//
//  TwoPhoneChangeWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

final class TwoPhoneChangeService {

    // MARK: - Private var

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    func fetchSMSCode(paramters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        networkLayer.two(parameters: paramters, completion: completion)
    }
}
