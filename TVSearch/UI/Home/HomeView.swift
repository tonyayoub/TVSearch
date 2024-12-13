//
//  HomeView.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init(service: ShowService) {
        _viewModel = StateObject(wrappedValue: .init(service: service))
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.shows) { show in
                Text(show.name ?? "Unknown Title")
            }
            .navigationTitle("Shows")
            .task {
                await viewModel.loadSchedule()
            }
        }
    }
}

#Preview {
    HomeView(service: MockService())
}
