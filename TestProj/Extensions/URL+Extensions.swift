//
//  URL+Extensions.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
    
    func appending(_ queryItems: [String: String]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        var newQueryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        queryItems.forEach {
            let queryItem = URLQueryItem(name: $0.key, value: $0.value)
            newQueryItems.append(queryItem)
        }
        
        urlComponents.queryItems = newQueryItems
        return urlComponents.url!
    }
}
