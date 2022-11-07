//
//  PersonalCabinetInteractor.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

// MARK: - Business Logic Protocol

protocol PersonalCabinetBusinessLogic {
    func makeRequest(request: PersonalCabinet.Model.Request.RequestType)
}

// MARK: - Interactor

final class PersonalCabinetInteractor {

    // MARK: - External vars

    var service: PersonalCabinetService?
    var presenter: PersonalCabinetPresentationLogic?
}

// MARK: - Business Logic Extension

extension PersonalCabinetInteractor: PersonalCabinetBusinessLogic {

    func makeRequest(request: PersonalCabinet.Model.Request.RequestType) {
        if service == nil {
            service = PersonalCabinetService()
        }

        switch request {

        case .fetchUserPersonalData:
            service?.fetchPersonalData(completion: { [weak self] personalInfo in
                if let error = personalInfo.error {
                    print("Error in fetchAuthCode: \(error)")
                } else {
                    self?.presenter?.presentData(response: .presentPersonalData(model: personalInfo))
                }
            })

        case .editPersonalData(let parameters):
            service?.editPersonalData(parameters: parameters, completion: { [weak self] personalInfo in
                if let error = personalInfo.error {
                    print("Error in fetchAuthCode: \(error)")
                } else {
                    self?.presenter?.presentData(response: .presentPersonalData(model: personalInfo))
                }
            })

        case .searchCountries(let searchText):
            service?.searchCountries(searchText: searchText, completion: { [weak self] countriesArray in
                self?.presenter?.presentData(response: .presentCountries(response: countriesArray))
            })

        case .searchCities(let searchText):
            service?.searchCities(searchText: searchText, completion: { [weak self] citiesArray in
                self?.presenter?.presentData(response: .presentCities(response: citiesArray))
            })
        }
    }
}
