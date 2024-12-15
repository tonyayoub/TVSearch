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
            Group {
                if filteredShows.isEmpty {
                    EmptyResultsView()
                } else {
                    SearchResultView(
                        genres: viewModel.genres,
                        shows: filteredShows,
                        selectedGenre: $viewModel.selectedGenre,
                        selectedShow: $viewModel.selectedShow
                    )
                }
            }
            .navigationTitle("Search Shows")
            .searchable(text: $viewModel.searchQuery, prompt: "Search shows")
            .sheet(item: $viewModel.selectedShow) { ShowDetailsView(show: $0) }
        }
    }
    
    private var filteredShows: [Show] {
        
        var shows = viewModel.shows
        if let selectedGenre = viewModel.selectedGenre {
            shows = shows.filter { $0.genres!.contains(selectedGenre) }
        }
        return shows
    }
}

#Preview {
    HomeView(service: MockService())
}
