//
//  Show.swift
//  TVSearch
//
//  Created by Tony Ayoub on 14-12-2024.
//

struct ImageInfo: Codable {
    let medium: String?
    let original: String?
}

struct Show: Codable, Identifiable {
    let id: Int
    let name: String?
    let genres: [String]?
    let runtime: Int?
    let image: ImageInfo?
    let summary: String?
}
