//
//  FilteredContentView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct FilteredContentView: View {
    let genres: [String]
    @Binding var selectedGenre: String?
    let shows: [Show]

    var body: some View {
        VStack {
            FilterView(
                filters: genres,
                selected: $selectedGenre
            )
            ShowsGridView(shows: shows)
        }
    }
}

#Preview {
    FilteredContentView(genres: ["Action", "Drama", "Comedy"], selectedGenre: .constant("Comedy"), shows: Show.sampleData(count: 6))
}
