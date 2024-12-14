//
//  GenreHeaderView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct GenreHeaderView: View {
    let genre: String

    var body: some View {
        Text(genre)
            .font(.title2)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
    }
}

#Preview {
    GenreHeaderView(genre: "Action")
}
