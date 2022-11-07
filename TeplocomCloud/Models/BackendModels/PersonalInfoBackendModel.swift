//
//  PersonalInfoBackendModel.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import Foundation

struct PersonalInfoBackendModel: Decodable {
    let city: String?
    let country: String?
    let email: String?
    let emailConfirmed: Bool?
    let firstName: String?
    let fullProfileData: Bool?
    let isProfessionalUser: Bool?
    let lastName: String?
    let phoneNumber: String?
    let error: String?
}
