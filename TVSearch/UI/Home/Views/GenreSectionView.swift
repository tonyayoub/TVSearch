//
//  GenreSectionView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct GenreSectionView: View {
    let genre: String
    let shows: [Show]

    var body: some View {
        Section(header: GenreHeaderView(genre: genre)) {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(shows) { show in
                    ShowCardView(show: show)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GenreSectionView(genre: "Action", shows: Show.sampleData(count: 5))
}
