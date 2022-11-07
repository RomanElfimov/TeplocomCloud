//
//  SensorsListWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import Foundation

final class SensorsListWorker {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService?

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    public func fetchTemperatureSensorsList(completion: @escaping([TemperatureSensorsListBackendModel]) -> Void) {
        /*
         networkLayer?.getTemperatureSensorsList(completion: { result in
         guard let result = result else { return }
         completion(result)
         })
         */

        let mockData = [TemperatureSensorsListBackendModel(id: "ff03", role: "Коматный", title: "Test 1"),
                        TemperatureSensorsListBackendModel(id: "ff04", role: "ГВС", title: "Test 2")]
        completion(mockData)
    }

}
