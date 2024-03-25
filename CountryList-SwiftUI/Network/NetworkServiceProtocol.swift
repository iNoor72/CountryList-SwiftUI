//
//  NetworkServiceProtocol.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(expectedType: T.Type) async throws -> AnyPublisher<T, Error>
}
