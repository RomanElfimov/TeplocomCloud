//
//  PersonalCabinetWorker.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

final class PersonalCabinetService {

    // MARK: - Private Property

    private var networkLayer: DataFetcherService

    // MARK: - Init

    init() {
        networkLayer = DataFetcherService()
    }

    // MARK: - Methods

    func fetchPersonalData(completion: @escaping(PersonalInfoBackendModel) -> Void) {
        networkLayer.getPersonalData { personalData in
            guard let personalData = personalData else { return }
            completion(personalData)
        }
    }

    func editPersonalData(parameters: [String: Any], completion: @escaping(PersonalInfoBackendModel) -> Void) {
        networkLayer.editPersonalData(parameters: parameters) { personalData in
            guard let personalData = personalData else { return }
            completion(personalData)
        }
    }

    func searchCountries(searchText: String, completion: @escaping([String]) -> Void) {
        networkLayer.searchCountries(searchText: searchText) { countries in
            if countries != nil {
                completion(countries!)
            }
        }
    }

    func searchCities(searchText: String, completion: @escaping([String]) -> Void) {
        networkLayer.searchCities(searchText: searchText) { cities in
            if cities != nil {
                completion(cities!)
            }
        }
    }
}
