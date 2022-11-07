//
//  Worker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import Foundation

final class ThreePhoneChangeService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Private Method

    func fetchSMSCode(paramters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        networkLayer.three(parameters: paramters, completion: completion)
    }
}
