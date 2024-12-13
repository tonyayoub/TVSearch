//
//  Episode.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation

struct Episode: Decodable, Identifiable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let runtime: Int
    let image: Image
    let summary: String
    
    struct Image: Decodable {
        let medium: String
        let original: String
    }
}
