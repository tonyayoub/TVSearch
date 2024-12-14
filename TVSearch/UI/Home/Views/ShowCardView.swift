//
//  ShowCardView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct ShowCardView: View {
    let show: Show

    var body: some View {
        if let imageUrl = show.image?.medium {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 150)
            }
        }
    }
}

#Preview {
    ShowCardView(show: Show.sampleData(count: 5).randomElement()!)
}
