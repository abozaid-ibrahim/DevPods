//
//  APIClient.swift
//  DevNetwork
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

public enum NetworkError: LocalizedError {
    case badRequest
    case noConnection
    case dataIsNil
    case apiFailure
    case failedToParseData
    public var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
        default:
            return "Check your connectivity, and try again."
        }
    }
}
