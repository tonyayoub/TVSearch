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
                            .background(selected == nil ? Color.accentColor : Color(UIColor.systemGray5))
                            .foregroundColor(selected == nil ? Color(UIColor.systemBackground) : Color(UIColor.label))
                            .cornerRadius(8)
                    }
                }
                ForEach(filters, id: \.self) { genre in
                    Button(action: { selected = genre }) {
                        Text(genre)
                            .padding()
                            .background(selected == genre ? Color.accentColor : Color(UIColor.systemGray5))
                            .foregroundColor(selected == genre ? Color(UIColor.systemBackground) : Color(UIColor.label))
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
