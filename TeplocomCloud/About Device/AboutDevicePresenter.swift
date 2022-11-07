//
//  AboutDevicePresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol AboutDevicePresentationLogic {
    func presentData(event: AboutDevice.Model.Response.ResponseType)
}

// MARK: - Presenter

final class AboutDevicePresenter {

    // MARK: - External vars

    weak var viewController: AboutDeviceDisplayLogic?
}

// MARK: - Presentation Logic Extension

extension AboutDevicePresenter: AboutDevicePresentationLogic {
    func presentData(event: AboutDevice.Model.Response.ResponseType) {
        switch event {

        case .presentNeedUpdateFirmware(let data):
            let viewModel = NeedUpdateFirmwareViewModel(isAvailable: data.need_update_firmware)
            viewController?.displayData(event: .displayNeedUpdateFirmware(data: viewModel))

        case .presentDeviceInfo(let data):
            var availableFirmwareVersion = ""
            if data.availableFirmwareVersion != nil {
                availableFirmwareVersion = "Доступна новая версия прошивки: \(data.availableFirmwareVersion!)"
            } else {
                availableFirmwareVersion = "Установлена актуальная версия прошивки"
            }

            let viewModel = DeviceInfoViewModel(deviceName: data.deviceClientName,
                                                currentFirmwareVersion: "Версия прошивки: " + (data.currentFirmwareVersion ?? "-//-"),
                                                availableFirmwareVersion: availableFirmwareVersion)
            viewController?.displayData(event: .displayDeviceInfo(data: viewModel))

        case .editDeviceInfo(status: let status):
            viewController?.displayData(event: .editDeviceInfo(status: status))

        case .reflashFirmware(status: let status):
            viewController?.displayData(event: .reflashFirmware(status: status))
        }
    }
}
