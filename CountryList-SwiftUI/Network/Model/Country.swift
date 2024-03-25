//
//  CountriesResponse.swift
//  CountryList-SwiftUI
//
//  Created by Noor El-Din Walid on 25/03/2024.
//

import Foundation

struct Country: Codable, Hashable, Identifiable {
    var id: Int
    var name: Name
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "population"
    }
}

struct Name: Codable, Hashable {
    var common: String
}
