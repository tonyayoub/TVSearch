//
//  MazeShowService.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation

struct MazeShowService: ShowService {
    
    func getSchedule() async throws -> [Show] {
        let url = try url(for: .schedule)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Show].self, from: data)
    }
    
    func search(query: String) async throws -> [Show] {
        let url = try url(for: .searchShows(query: query))
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Show].self, from: data)
    }
    
    func getEpisodes(id: String) async throws -> [Episode] {
        let url = try url(for: .showEpisodes(showID: id))
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Episode].self, from: data)
    }
}

extension MazeShowService {
    enum Endpoint {
        case searchShows(query: String)
        case showEpisodes(showID: String)
        case schedule

        func path() -> String {
            switch self {
            case .searchShows(let query):
                return "/search/shows?q=\(query)"
            case .showEpisodes(let showID):
                return "/shows/\(showID)/episodes"
            case .schedule:
                return "/schedule"
            }
        }
    }
    
    func url(for endpoint: Endpoint) throws -> URL {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            throw ServiceError.missingBaseURL
        }

        let urlString = baseURLString + endpoint.path()

        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidEndpointURL(urlString)
        }

        return url
    }
}

enum ServiceError: Error, LocalizedError {
    case missingBaseURL
    case invalidEndpointURL(String)
    
    var errorDescription: String? {
        switch self {
        case .missingBaseURL:
            return "The BaseURL is missing in the configuration file."
        case .invalidEndpointURL(let urlString):
            return "The URL constructed for the endpoint is invalid: \(urlString)"
        }
    }
}
