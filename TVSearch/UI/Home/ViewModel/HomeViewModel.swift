//
//  HomeViewModel.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var showsByGenre: [String: [Show]] = [:]
    @Published var searchQuery = ""
    @Published var error: String?
    
    private let service: ShowService
    private var cancellables = Set<AnyCancellable>()
    private let debounceInterval: TimeInterval = 1.0
    
    init(service: ShowService) {
        self.service = service
        setupSearch(debounceInterval: debounceInterval)
    }
    
    func loadSchedule() async {
        do {
            self.shows = try await service.getSchedule()
            
        } catch {
            self.error = "Cannot load service"
        }
    }
    
    @MainActor
    func performSearch(query: String) async {
        guard !query.isEmpty else {
            shows = []
            showsByGenre = [:]
            return
        }

        do {
            self.shows = try await service.search(query: query)
            showsByGenre = Dictionary(grouping: shows) { show in
                show.genres?.first ?? "Unknown"
            }
        } catch {
            print("Error performing search: \(error)")
            shows = []
            showsByGenre = [:]
        }
    }
    
    private func setupSearch(debounceInterval: TimeInterval) {
        $searchQuery
            .debounce(for: .seconds(debounceInterval), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                Task {
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
    }
}
