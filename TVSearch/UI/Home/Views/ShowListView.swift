//
//  ShowListView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct ShowListView: View {
    let showsByGenre: [String: [Show]]

    var body: some View {
        ForEach(showsByGenre.keys.sorted(), id: \.self) { genre in
            if let shows = showsByGenre[genre] {
                GenreSectionView(genre: genre, shows: shows)
            }
        }
    }
}
#Preview {
    ShowListView(showsByGenre: [
        "Action": Show.sampleData(count: 3),
        "Comedy": Show.sampleData(count: 2),
        "Drama": Show.sampleData(count: 5),
    ])
}
