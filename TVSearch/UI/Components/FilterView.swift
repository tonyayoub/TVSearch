//
//  FilterView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

import SwiftUI

struct FilterView: View {
    let filters: [String]
    @Binding var selected: String?

    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if !filters.isEmpty {
                        Button(action: { selected = nil }) {
                            Text("All")
                                .padding()
                                .background(selected == nil ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selected == nil ? .white : .black)
                                .cornerRadius(8)
                        }
                    }
                    ForEach(filters, id: \.self) { genre in
                        Button(action: { selected = genre }) {
                            Text(genre)
                                .padding()
                                .background(selected == genre ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selected == genre ? .white : .black)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
        }
}

#Preview {
    VStack {
        FilterView(filters: ["Action", "Drama", "Comedy"], selected: .constant("Drama"))
        FilterView(filters: [], selected: .constant("Drama"))
    }
}
