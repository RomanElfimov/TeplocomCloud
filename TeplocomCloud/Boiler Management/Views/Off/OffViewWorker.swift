//
//  OffViewWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 05.05.2022.
//

import Foundation

final class OffViewService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Methods

    public func editBoilerSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {

        /*
        networkLayer.editBoilerSettings(parameters: parameters) { statusCode in
            guard let statusCode = statusCode else { return }
            statusCodeCompletion(statusCode)
        } completion: { _ in }
         */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }

}
