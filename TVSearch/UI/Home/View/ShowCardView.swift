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
        } else {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
                
                Text(show.name ?? "")
                    .foregroundColor(.primary)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}


#Preview {
    ShowCardView(show: Show.sampleData(count: 5).first!)
}
