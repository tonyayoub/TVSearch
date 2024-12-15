//
//  HomeViewModel.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var showsByGenre: [String: [Show]] = [:]
    @Published var searchQuery = ""
    @Published var error: String?
    @Published var selectedGenre: String? = nil
    @Published var selectedShow: Show? = nil
    @Published var showEmptyView: Bool = false
    @Published var reasonForEmptyView = EmptyResultView.Reason.noQuery
    @Published var isConnected = true
    
    var genres: [String] {
        Array(Set(shows.flatMap { $0.genres ?? [] })).sorted()
    }
    
    // var is used to be mocked in tests - should use protocols and be injected like service
    var networkMonitor = NetworkMonitor()
    
    private let service: ShowService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: ShowService) {
        self.service = service
        setupSearchSignals()
        setupNetworkMonitoring()
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
                show.genres?.first ?? "Other"
            }
        } catch {
            print("Error performing search: \(error)")
            shows = []
            showsByGenre = [:]
        }
    }
    
    private func setupSearchSignals() {
        
        // show empty view
        Publishers.CombineLatest($isConnected, $shows)
            .map { isConnected, shows -> Bool in
                !isConnected || shows.isEmpty
            }
            .assign(to: &$showEmptyView)
        
        // reason for empty view
        Publishers.CombineLatest3($shows, $searchQuery, $isConnected)
            .map { shows, searchQuery, isConnected -> EmptyResultView.Reason in
                if !isConnected {
                    return .noConnection
                } else if searchQuery.isEmpty {
                    return .noQuery
                } else if shows.isEmpty {
                    return .noResults
                }
                
                return .noQuery // Fallback (unlikely to occur)
            }
            .assign(to: &$reasonForEmptyView)
        
        // perform search upon typing query
        $searchQuery
            .filter { _ in self.isConnected }
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                Task {
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
        
        // perform search upon restoring connectivity with a non-empty query
        $isConnected
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .filter { isConnected in isConnected && !self.searchQuery.isEmpty }
            .sink { _ in
                Task {
                    await self.performSearch(query: self.searchQuery)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupNetworkMonitoring() {
        networkMonitor.networkStatus
            .receive(on: DispatchQueue.main)
            .assign(to: &$isConnected)
    }
}
