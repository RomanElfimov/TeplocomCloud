//
//  PersonalCabinetPresenter.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

// MARK: - Presetation Logic Protocol

protocol PersonalCabinetPresentationLogic {
    func presentData(response: PersonalCabinet.Model.Response.ResponseType)
}

// MARK: - Presenter

final class PersonalCabinetPresenter {

    // MARK: - External vars

    weak var viewController: PersonalCabinetDisplayLogic?

    // MARK: - Private Method

    private func createViewModel(personalData: PersonalInfoBackendModel) -> PersonalInfoViewModel {
        return PersonalInfoViewModel.init(firstName: personalData.firstName ?? "",
                                          lastName: personalData.lastName ?? "",
                                          email: personalData.email ?? "",
                                          isEmailConfirmed: personalData.emailConfirmed ?? false,
                                          phoneNumber: personalData.phoneNumber ?? "",
                                          city: personalData.city ?? "",
                                          country: personalData.country ?? "")
    }
}

// MARK: - Presentation Logic Extension

extension PersonalCabinetPresenter: PersonalCabinetPresentationLogic {
    func presentData(response: PersonalCabinet.Model.Response.ResponseType) {
        switch response {

        case .presentPersonalData(model: let model):
            let personalDataViewModel = createViewModel(personalData: model)
            viewController?.displayData(viewModel: .displayPersonalData(viewModel: personalDataViewModel))

        case .presentCountries(let response):
            viewController?.displayData(viewModel: .displayCountries(response: response))

        case .presentCities(let response):
            viewController?.displayData(viewModel: .displayCities(response: response))
        }
    }
}
