//
//  MockService.swift
//  TVSearch
//
//  Created by Tony Ayoub on 13-12-2024.
//

import Foundation

class MockService: ShowService {
    func getSchedule() async throws -> [Show] {
        decode([Show].self, forKey: "showSearchResults") ?? []
    }
    
    func search(query: String) async throws -> [Show] {
        let results = Show.sampleData(count: 5);
        print("will return \(results.count) results")
        return results;
        let searchResults = decode([ShowSearchResult].self, forKey: "showSearchResults")
        let shows = searchResults?.compactMap { $0.show }
        return shows ?? []
    }
    
    func getEpisodes(id: String) async throws -> [Episode] {
        decode([Episode].self, forKey: "episodes") ?? []
    }
    
    private let fileName = "mock-data"
    private var jsonData: Data?
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Could not find \(fileName).json in bundle")
            return
        }
        
        do {
            jsonData = try Data(contentsOf: fileURL)
        } catch {
            print("Error loading mock data: \(error)")
        }
    }
    
    private func decode<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = jsonData else { return nil }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let keyData = try JSONSerialization.data(withJSONObject: json?[key] ?? [])
            return try JSONDecoder().decode(T.self, from: keyData)
        } catch {
            print("Error decoding \(key): \(error)")
            return nil
        }
    }
}
