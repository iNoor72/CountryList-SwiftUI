//
//  ContentViewModel.swift
//  CountryList-SwiftUI
//
//  Created by Noor El-Din Walid on 25/03/2024.
//

import Foundation
import Combine

class CountryListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    private let networkManager: NetworkServiceProtocol
    
    private var bag = Set<AnyCancellable>()
    
    init(networkManager: NetworkServiceProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchData() async {
        do {
            try await networkManager.fetch(expectedType: [Country].self)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { error in
                    print(error)
                }, receiveValue: { [weak self] countries in
                    self?.countries = countries
                })
                .store(in: &bag)
        } catch {
            print("Error fetching: \(error)")
        }
    }
}
