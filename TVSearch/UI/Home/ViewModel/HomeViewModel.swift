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
    @Published var selectedGenre: String? = nil
    @Published var selectedShow: Show? = nil
    @Published var showEmptyView: Bool = false
    @Published var reasonForEmptyView = EmptyResultView.Reason.noQuery
    
    var genres: [String] {
        Array(Set(shows.flatMap { $0.genres ?? [] })).sorted()
    }
    
    private let service: ShowService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: ShowService) {
        self.service = service
        setupSearchSignals()
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
                show.genres?.first ?? "Other"
            }
            print("Shows by genre: \(showsByGenre.count)")
        } catch {
            print("Error performing search: \(error)")
            shows = []
            showsByGenre = [:]
        }
    }
    
    private func setupSearchSignals() {
        $shows
            .map { $0.isEmpty }
            .assign(to: &$showEmptyView)
        
        Publishers.CombineLatest($shows, $searchQuery)
            .map { shows, searchQuery -> EmptyResultView.Reason in
                if searchQuery.isEmpty {
                    return .noQuery
                } else if shows.isEmpty {
                    return .noResults
                }
                
                return .noQuery
            }
            .assign(to: &$reasonForEmptyView)
        
        $searchQuery
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
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
