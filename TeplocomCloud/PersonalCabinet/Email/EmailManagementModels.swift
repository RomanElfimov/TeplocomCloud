//
//  EmailManagementModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import Foundation

enum EmailManagement {

    enum Model {
        struct Request {
            enum RequestType {
                case getEmailData
                case changeEmail(newEmailParameters: [String: String])
                case verifyEmail(emailParameters: [String: String])
            }
        }

        struct Response {
            enum ResponseType {
                case presentEmailInfo(email: String, isVerified: Bool)
                case presentChangeEmail(response: PersonalInfoBackendModel)
                case presentVerifyEmail
                case error(description: String)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayEmailInfo(email: String, isVerified: Bool)
                case displayChangedEmail(viewModel: ChangeEmailViewModel)
                case displayVerifiedEmail
                case error(description: String)
            }
        }
    }

}

struct ChangeEmailViewModel {
    let email: String
}
