//
//  RequestType.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 04.08.2021.
//

import Foundation

/// Request types enumeration, use in NetworkService
enum RequestType {
    case get
    case getWithHeader
    case post
    case postWithHeader
    case putWithHeader
    case delete
}
