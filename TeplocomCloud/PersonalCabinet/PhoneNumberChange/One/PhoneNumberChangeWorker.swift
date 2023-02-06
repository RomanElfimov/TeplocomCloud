//
//  PhoneNumberChangeWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

final class PhoneNumberChangeService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Method

    func fetchPhoneNumberChange(parameters: [String: String], completion: @escaping(AuthCodeBackendModel?) -> Void) {
        networkLayer.phoneNumberChangeRequestCode(parameters: parameters, completion: completion)
    }

}
