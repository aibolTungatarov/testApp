//
//  Networking.swift
//  TestProj
//
//  Created by Айбол on 29.09.2023.
//

import Foundation

protocol Networking {
    func execute<T: Decodable>(_ requestProvider: URLRequestConvertible, completion: @escaping (Swift.Result<T, APIError>) -> Void)
}

extension Networking {
    func execute<T: Decodable>(_ requestProvider: URLRequestConvertible, completion: @escaping (Swift.Result<T, APIError>) -> Void) {
        do {
            let urlRequest = try requestProvider.asURLRequest()
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                do {
                    if let error = error {
                        completion(.failure(APIError.badRequest(error.localizedDescription)))
                        return
                    }
                    
                    guard let data = data,
                          let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200
                    else {
                        completion(.failure(APIError.badRequest("")))
                        return
                    }
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(APIError.badRequest(error.localizedDescription)))
                }
            }.resume()
        } catch {
            completion(.failure(APIError.notFound("")))
        }
    }
}

struct NetworkingInstance: Networking {}

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

