//
//  HomeViewModel.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var error: String?
    
    private let service: ShowService
    
    init(service: ShowService) {
        self.service = service
    }
    
    func loadSchedule() async {
        do {
            let shows = try await service.getSchedule()
            self.shows = shows
            
        } catch {
            self.error = "Cannot load service"
        }
    }
}
