//
//  NetworkManager.swift
//  CountryList-SwiftUI
//
//  Created by Noor El-Din Walid on 25/03/2024.
//

import Foundation
import Combine

enum NetworkErrors: Error {
    case urlConstructionError
    case responseError
    case statusCodeError
    case errorDecodingError
}

class NetworkManager: NetworkServiceProtocol {
    func fetch<T: Decodable>(expectedType: T.Type) async throws -> AnyPublisher<T, Error> {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            return Fail(error: NetworkErrors.urlConstructionError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkErrors.responseError
                }
                
                guard (200 ... 299).contains(httpResponse.statusCode) else {
                    throw NetworkErrors.statusCodeError
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
