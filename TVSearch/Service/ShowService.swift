//
//  ShowService.swift
//  TVSearch
//
//  Created by Tony Ayoub on 12-12-2024.
//

import Foundation

protocol ShowService {
    func search(query: String) async throws -> [Show]
}
