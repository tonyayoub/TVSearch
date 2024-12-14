//
//  EmptyResultsView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct EmptyResultsView: View {
    var body: some View {
        Text("No results found")
            .foregroundColor(.gray)
    }
}

#Preview {
    EmptyResultsView()
}
