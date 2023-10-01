//
//  APIError.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

public enum APIError: Error {
    case badRequest(String)
    case notFound(String)
    case noInternet(description: String)
    case unsupportedAppVersion(description: String)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest(let message), .notFound(let message), .noInternet(let message), .unsupportedAppVersion(let message):
            return message
        }
    }
}

