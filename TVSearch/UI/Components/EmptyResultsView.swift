//
//  EmptyResultsView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct EmptyResultView: View {
    enum Reason {
        case noResults
        case noQuery
    }
    
    let reason: Reason

    var body: some View {
        VStack {
            switch reason {
            case .noResults:
                Text("No results found")
                    .font(.headline)
                    .foregroundColor(.gray)

            case .noQuery:
                Text("Start typing to search for your favorite shows")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

#Preview {
    EmptyResultView(reason: .noQuery)
}
