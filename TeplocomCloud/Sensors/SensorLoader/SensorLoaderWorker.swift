//
//  SensorLoaderWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

final class SensorLoaderWorker {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    public func fetchUnallocatedTempSensor(completion: @escaping(UnallocatedSenorModel) -> Void) {

        /*
        networkLayer.fetchUnallocatedTempSensor { result in
            guard let result = result else { return }
            completion(result)
        }
        */
        
        let mockResult = UnallocatedSenorModel(found: true)
        completion(mockResult)
    }
}
