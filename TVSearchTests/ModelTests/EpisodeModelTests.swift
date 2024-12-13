//
//  EpisodeModelTests.swift
//  TVSearchTests
//
//  Created by Tony Ayoub on 12-12-2024.
//

import XCTest
@testable import TVSearch

final class EpisodeModelTests: XCTestCase {
    
    func testDecodeEpisodes() throws {
        let json = """
        {
            "id": 10820,
            "url": "https://www.tvmaze.com/episodes/10820/girls-1x01-pilot",
            "name": "Pilot",
            "season": 1,
            "number": 1,
            "runtime": 30,
            "image": {
                "medium": "https://static.tvmaze.com/uploads/images/medium_landscape/15/38639.jpg",
                "original": "https://static.tvmaze.com/uploads/images/original_untouched/15/38639.jpg"
            },
            "summary": "<p>In the premiere of this comedy about twentysomething women navigating their way through life in New York...</p>"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let episode = try decoder.decode(Episode.self, from: json)
        
        XCTAssertEqual(episode.id, 10820)
        XCTAssertEqual(episode.url, "https://www.tvmaze.com/episodes/10820/girls-1x01-pilot")
        XCTAssertEqual(episode.name, "Pilot")
        XCTAssertEqual(episode.season, 1)
        XCTAssertEqual(episode.number, 1)
        XCTAssertEqual(episode.runtime, 30)
        XCTAssertNotNil(episode.image)
        XCTAssertEqual(episode.image.medium, "https://static.tvmaze.com/uploads/images/medium_landscape/15/38639.jpg")
        XCTAssertEqual(episode.image.original, "https://static.tvmaze.com/uploads/images/original_untouched/15/38639.jpg")
        XCTAssertNotNil(episode.summary)
    }
}
