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
                ShowImageView(imageUrl: show.image?.original)

                Text(show.name ?? "Unknown Title")
                    .font(.largeTitle)
                    .bold()

                ShowInformationView(genres: show.genres, runtime: show.runtime)

                ShowSummaryView(summary: show.summary)
            }
            .padding()
        }
        .navigationTitle(show.name ?? "Details")
    }
}

struct ShowImageView: View {
    let imageUrl: String?

    var body: some View {
        if let imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 200)
            }
        }
    }
}

struct ShowInformationView: View {
    let genres: [String]?
    let runtime: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let genres, !genres.isEmpty {
                Text("Genres: \(genres.joined(separator: ", "))")
                    .font(.headline)
            }
            if let runtime {
                Text("Runtime: \(runtime) minutes")
                    .font(.subheadline)
            }
        }
    }
}

struct ShowSummaryView: View {
    let summary: String?

    var body: some View {
        if let summary {
            VStack(alignment: .leading, spacing: 8) {
                Text("Summary")
                    .font(.title2)
                    .bold()
                Text(summary.removingHTMLTags())
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

extension String {
    func removingHTMLTags() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        return attributedString?.string ?? self
    }
}


#Preview {
    ShowDetailsView(show: Show.sampleData(count: 1).first!)
}
