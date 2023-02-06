//
//  SensorLoaderModels.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import Foundation

enum SensorLoader {
    enum Model {
        struct Request {
            enum RequestType {
                case fetchUnallocatedSensor
            }
        }

        struct Response {
            enum ResponseType {
                case presentUnallocatedSensor(data: UnallocatedSenorModel)
            }
        }

        struct ViewModel {
            enum ViewModelData {
                case displayUnallocatedSensor(result: UnallocatedSenorModel)
            }
        }

    }
}
