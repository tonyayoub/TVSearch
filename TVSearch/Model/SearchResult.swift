//
//  SearchResult.swift
//  TVSearch
//
//  Created by Tony Ayoub on 11-12-2024.
//

import Foundation

struct ShowSearchResult: Codable {
    let score: Double?
    let show: Show?
}

struct Show: Codable {
    let id: Int
    let url: String?
    let name: String?
    let language: String?
    let runtime: Int?
    let officialSite: String?
    let rating: Rating?
    let network: Network?
    let image: ImageInfo?
    let summary: String?
}

struct Rating: Codable {
    let average: Double?
}

struct Network: Codable {
    let id: Int?
    let name: String?
    let officialSite: String?
}


struct ImageInfo: Codable {
    let medium: String?
    let original: String?
}
