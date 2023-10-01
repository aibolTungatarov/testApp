//
//  DevicesApi.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

public enum DevicesApi: URLRequestConvertible {
    
    case devices

    var baseURLPath: String {
        return "https://api.fasthome.io"
    }
    
    var method: HTTPMethod {
        switch self {
        // GET
        case .devices:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .devices:
            return "/api/v1/test/devices"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
    
    public func basicParamHeaders(_ request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("ios", forHTTPHeaderField: "client")
        request.setValue("app", forHTTPHeaderField: "channel")
    }
    
    public func urlPath() -> String {
        return self.baseURLPath + path
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try self.baseURLPath.asURL()
        let fullURL = url.appendingPathComponent(path).appending(parameters)
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 60

        basicParamHeaders(&request)

        print("____________REQUEST HEADER: \(String(describing: request.allHTTPHeaderFields))")
        print("------------FULL REQUEST URL:\n\(request)")
        return request

    }
}

