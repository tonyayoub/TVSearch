//
//  ShowsGridView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct ShowGridView: View {
    let shows: [Show]
    @Binding var selectedShow: Show?
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3),
                spacing: 16
            ) {
                ForEach(shows) { show in
                    Button(action: { selectedShow = show }) {
                        ShowCardView(show: show)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ShowGridView(shows: Show.sampleData(count: 4), selectedShow: .constant(nil))
}
