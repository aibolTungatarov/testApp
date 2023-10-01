//
//  NetworkRoute.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

protocol NetworkRoute {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var baseURLPath: String { get }

    func makeURLRequest() throws -> URLRequest
    func asURLRequest() throws -> URLRequest
}

extension NetworkRoute {
    func asURLRequest() -> URLRequest {
        let urlRequest = try? makeURLRequest()
        return urlRequest!
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: "https://api.fasthome.io") else {
            throw APIError.badRequest("host can not be converted to URL")
        }
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 60
        return request
    }
}
