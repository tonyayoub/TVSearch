//
//  ShowDetailsView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 15-12-2024.
//

import SwiftUI

struct ShowDetailsView: View {
    let show: Show

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = show.image?.original {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                }

                Text(show.name ?? "Unknown Title")
                    .font(.largeTitle)
                    .bold()

                if let genres = show.genres, !genres.isEmpty {
                    Text("Genres: \(genres.joined(separator: ", "))")
                        .font(.headline)
                }

                if let runtime = show.runtime {
                    Text("Runtime: \(runtime) minutes")
                        .font(.subheadline)
                }

                if let summary = show.summary {
                    Text("Summary")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    Text(summary)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .navigationTitle(show.name ?? "Details")
    }
}


#Preview {
    ShowDetailsView(show: Show.sampleData(count: 1).first!)
}
