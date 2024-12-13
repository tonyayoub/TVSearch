//
//  SearchResult.swift
//  TVSearch
//
//  Created by Tony Ayoub on 11-12-2024.
//

import Foundation

struct ShowSearchResult: Codable {
    let show: Show?
}

struct Show: Codable, Identifiable {
    let id: Int
    let name: String?
    let genres: [String]?
    let runtime: Int?
    let image: ImageInfo?
    let summary: String?
}

struct ImageInfo: Codable {
    let medium: String?
    let original: String?
}
