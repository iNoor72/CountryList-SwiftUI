//
//  ContentView.swift
//  CountryList-SwiftUI
//
//  Created by Noor El-Din Walid on 25/03/2024.
//

import SwiftUI

struct CountryListView: View {
    @StateObject var viewModel: CountryListViewModel = CountryListViewModel()
    var body: some View {
        List(viewModel.countries) { country in
            Text(country.name.common)
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    CountryListView()
}
