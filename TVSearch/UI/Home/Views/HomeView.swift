//
//  HomeView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init(service: ShowService) {
        _viewModel = StateObject(wrappedValue: .init(service: service))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.showsByGenre.isEmpty && viewModel.searchQuery.isEmpty {
                    EmptyResultsView()
                } else {
                    ShowListView(showsByGenre: viewModel.showsByGenre)
                }
            }
            .navigationTitle("Search Shows")
            .searchable(text: $viewModel.searchQuery, prompt: "Search shows")
        }
    }
}

#Preview {
    HomeView(service: MockService())
}
