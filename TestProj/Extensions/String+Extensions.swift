//
//  String+URL.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw APIError.badRequest("") }
        return url
    }
}
