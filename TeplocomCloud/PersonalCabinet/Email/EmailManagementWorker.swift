//
//  EmailManagementWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

final class EmailManagementService {

    // MARK: - Private var

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    func changeEmail(parameters: [String: String], completion: @escaping(PersonalInfoBackendModel) -> Void) {
        networkLayer.changeEmail(parameters: parameters) { result in
            guard let result = result else { return }
            completion(result)
        }
    }
}
