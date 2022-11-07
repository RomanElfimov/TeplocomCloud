//
//  AboutDeviceWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

final class AboutDeviceService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    public func fetchHotData(completion: @escaping(HotDataBackendModel) -> Void) {

        /*
        networkLayer.getDeviceHotData(deviceUID: deviceUID) { result in
            guard let result = result else { print("HotDataBackendModel is nil"); return }
            completion(result)
        }
        */

        let mockHotData = HotDataBackendModel(installedFirmwareVersion: "mock",
                                              needUpdateFirmware: false, firmwareReflashingNow: false,
                                              gsmBalance: 100,
                                              gsmRssi: -60,
                                              powerSupplyVoltage: true,
                                              batteryVoltage: false,
                                              centralHeating: 90,
                                              domesticHotWater: 60,
                                              indoor: 20,
                                              outdoor: "1",
                                              mode: "rrrrr",
                                              setPoint: nil,
                                              boilerState: false)
        completion(mockHotData)
    }

    public func fetchDeviceInfo(completion: @escaping(DeviceInfoBackendModel) -> Void) {
        /*
        networkLayer.getDeviceInfo { result in in
            guard let result = result else { return }
            completion(result)
        }
         */

        let mockDeviceInfo = DeviceInfoBackendModel(deviceClientName: "Teplocom Cloud Дача",
                                                    currentFirmwareVersion: "0.98.210916_5",
                                                    availableFirmwareVersion: nil)
        completion(mockDeviceInfo)
    }

    public func editDeviceInfo(parameters: [String: String], statusCodeCompletion: @escaping (Int) -> Void) {
        /*
        networkLayer.editDeviceInfo(parameters: parameters) { status in
            guard let statusCode = status else { return }
        } completion: { _ in }
        statusCodeCompletion(statusCode)
        */

        let mockStatus = 200
        statusCodeCompletion(mockStatus)
    }

    public func reflashFirmware(statusCodeCompletion: @escaping (Int) -> Void) {
        /*
        networkLayer.reflashFirmware { status in
            guard let statusCode = status else { return }
        } completion: { _ in }
        statusCodeCompletion(statusCode)
        */

        let mockStatus = 202
        statusCodeCompletion(mockStatus)
    }
}
