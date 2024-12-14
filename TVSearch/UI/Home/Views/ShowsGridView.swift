//
//  ShowsGridView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct ShowsGridView: View {
    let shows: [Show]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(shows) { show in
                    ShowCardView(show: show)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ShowsGridView(shows: Show.sampleData(count: 4))
}
