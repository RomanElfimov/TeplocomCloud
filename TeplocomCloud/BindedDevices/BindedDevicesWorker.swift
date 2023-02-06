//
//  BindedDevicesWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.02.2022.
//

import Foundation

final class BindedDevicesWorker {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService?

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Public Method

    public func fetchBindedDevices(completion: @escaping([BindedDevicesBackendModel]) -> Void) {
        /*
         networkLayer?.getBindedDevices(completion: { result in
         guard let result = result else { return }
         completion(result)
         })
         */

        // mock data
        let mockData = [
            BindedDevicesBackendModel(clientName: "Teplocom дача", description: "Teplocom", status: true, type: "FF02", uid: "HABXABRRODAzMjUx"),
            BindedDevicesBackendModel(clientName: "Teplocom дом родители", description: "Teplocom", status: false, type: "FF02", uid: "ZEFTWRTERWQERT")]
        completion(mockData)
    }
}
