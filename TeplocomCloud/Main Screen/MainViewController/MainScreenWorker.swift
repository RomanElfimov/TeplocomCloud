//
//  MainScreenWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import Foundation

final class MainScreenService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    public func fetchHotData(completion: @escaping(HotDataBackendModel) -> Void) {
        /*
         networkLayer.getDeviceHotData { result in
         guard let result = result else { print("HotDataBackendModel is nil"); return }
         completion(result)
         }
         */

        let mockHotData = HotDataBackendModel(installedFirmwareVersion: "rrrrr",
                                              needUpdateFirmware: false, firmwareReflashingNow: false,
                                              gsmBalance: 15000,
                                              gsmRssi: -60,
                                              powerSupplyVoltage: false,
                                              batteryVoltage: true,
                                              centralHeating: 8700,
                                              domesticHotWater: 2900,
                                              indoor: 2400,
                                              outdoor: "-5",
                                              mode: "relay2",
                                              setPoint: 2400,
                                              boilerState: false)

        completion(mockHotData)
    }

    public func switchBoilerState(statusCodeCompletion: @escaping (Int) -> Void) {
        /*
         networkLayer.switchBoilerState { statusCode in
         guard let statusCode = statusCode else { return }
         statusCodeCompletion(statusCode)
         } completion: { _ in }
         */

        let mockStatusCode = 202
        statusCodeCompletion(mockStatusCode)
    }
}
