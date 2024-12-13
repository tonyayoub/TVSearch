//
//  ShowService.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation

protocol ShowService {
    func getSchedule() async throws -> [Show]
    func search(query: String) async throws -> [Show]
    func getEpisodes(id: String) async throws -> [Episode]
}
