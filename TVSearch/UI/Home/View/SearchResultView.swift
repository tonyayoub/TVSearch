//
//  FilteredContentView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct SearchResultView: View {
    let genres: [String]
    let shows: [Show]
    @Binding var selectedGenre: String?
    @Binding var selectedShow: Show?

    var body: some View {
        VStack {
            FilterView(
                filters: genres,
                selected: $selectedGenre
            )
            ShowGridView(shows: shows, selectedShow: $selectedShow)
        }
    }
}

#Preview {
    SearchResultView(
        genres: ["Action", "Drama", "Comedy"],
        shows: Show.sampleData(count: 6),
        selectedGenre: .constant("Comedy"),
        selectedShow: .constant(nil)
    )
}
