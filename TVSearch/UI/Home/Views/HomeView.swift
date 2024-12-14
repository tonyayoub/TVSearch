//
//  HomeView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var selectedGenre: String? = nil

    init(service: ShowService) {
        _viewModel = StateObject(wrappedValue: .init(service: service))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if filteredShows.isEmpty {
                    EmptyResultsView()
                } else {
                    FilteredContentView(
                        genres: viewModel.genres,
                        selectedGenre: $selectedGenre,
                        shows: filteredShows
                    )
                }
            }
            .navigationTitle("Search Shows")
            .searchable(text: $viewModel.searchQuery, prompt: "Search shows")
        }
    }
    
    private var filteredShows: [Show] {
        var shows = viewModel.shows
        if let selectedGenre = selectedGenre {
            shows = shows.filter { $0.genres!.contains(selectedGenre) }
        }
        if !viewModel.searchQuery.isEmpty {
            shows = shows.filter { $0.name!.localizedCaseInsensitiveContains(viewModel.searchQuery) }
        }
        return shows
    }
}

#Preview {
    HomeView(service: MockService())
}
