//
//  BoilerExpertSettingsWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.05.2022.
//

import Foundation

final class BoilerExpertSettingsService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Methods

    // Relay1, Relay2

    public func fetchBoilerExpertSettings(completion: @escaping(BoilerExpertSettingsBackendModel) -> Void) {

        /*
        networkLayer.getBoilerExpertSettings { result in
            guard let result = result else { return }
            completion(result)
        }
         */

        let mockBoilerSettings = BoilerExpertSettingsBackendModel(boilerControlProtocol: "relay2",
                                                                  hysteresis: 200,
                                                                  normalState: "normalClosed",
                                                                  stateOnLeakage: true,
                                                                  switchingOnTheBoilerCirculationPump: 600)
        completion(mockBoilerSettings)
    }

    public func editBoilerExpertSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {

        /*
        networkLayer.editBoilerExpertSettings(parameters: parameters) { statusCode in
            guard let statusCode = statusCode else { return }
            statusCodeCompletion(statusCode)
        } completion: { _ in }
         */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }

    // Open Therm

    public func fetchBoilerOpenThermSettings(completion: @escaping(BoilerOpenThermSettingsBackendModel) -> Void) {

        /*
        networkLayer.getBoilerExpertSettings { result in
            guard let result = result else { return }
            completion(result)
        }
         */

        let mockBoilerSettings = BoilerOpenThermSettingsBackendModel(maxDomesticHotWaterTemperature: 5000,
                                                                     minDomesticHotWaterTemperature: 4000,
                                                                     setPointDomesticHotWater: 4500,
                                                                     maxHeatingMediumTemperature: 7500,
                                                                     minHeatingMediumTemperature: 4500,
                                                                     maximumBurnerModulation: 50,
                                                                     configurationDomesticHotWater: "indirectHeatingBoiler")
        completion(mockBoilerSettings)
    }

    public func editBoilerOpenThermSettings(parameters: [String: Any], statusCodeCompletion: @escaping (Int) -> Void) {

        /*
        networkLayer.editBoilerExpertSettings(parameters: parameters) { statusCode in
            guard let statusCode = statusCode else { return }
            statusCodeCompletion(statusCode)
        } completion: { _ in }
         */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }
}
