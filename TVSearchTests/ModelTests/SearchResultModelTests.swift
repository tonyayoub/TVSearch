//
//  SearchResultModelTests.swift
//  TVSearchTests
//
//  Created by Tony Ayoub on 11-12-2024.
//

import XCTest

@testable import TVSearch

final class ModelDecodingTests: XCTestCase {
    
    func testDecodeShowSearchResult() throws {
        let json = """
        {
          "score": 0.909815,
          "show": {
            "id": 139,
            "url": "https://www.tvmaze.com/shows/139/girls",
            "name": "Girls",
            "language": "English",
            "runtime": 30,
            "officialSite": "http://www.hbo.com/girls",
            "rating": {
                "average": 6.4
            },
            "network": {
                "id": 8,
                "name": "HBO",
                "officialSite": "https://www.hbo.com/"
            },
            "image": {
                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
                "original": "https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
            },
            "summary": "<p>This Emmy winning series is a comic look at the assorted humiliations...</p>"
          }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let result = try decoder.decode(ShowSearchResult.self, from: json)
        
        XCTAssertNotNil(result.show)
        
        let show = result.show!
        XCTAssertEqual(show.id, 139)
        XCTAssertEqual(show.name, "Girls")
        XCTAssertEqual(show.runtime, 30)
        XCTAssertNotNil(show.image)
        XCTAssertNotNil(show.summary)
    }
    
    func testDecodeShow() throws {
        let json = """
        {
          "id": 525,
          "url": "https://www.tvmaze.com/shows/525/gilmore-girls",
          "name": "Gilmore Girls",
          "language": "English",
          "runtime": 60,
          "officialSite": null,
          "rating": {
              "average": 8.1
          },
          "network": {
              "id": 5,
              "name": "The CW",
              "officialSite": "https://www.cwtv.com/"
          },
          "image": {
              "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/4/11308.jpg",
              "original": "https://static.tvmaze.com/uploads/images/original_untouched/4/11308.jpg"
          },
          "summary": "<p><b>Gilmore Girls</b> is a drama centering around...</p>"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let show = try decoder.decode(Show.self, from: json)
        
        XCTAssertEqual(show.id, 525)
        XCTAssertEqual(show.name, "Gilmore Girls")
        XCTAssertEqual(show.runtime, 60)
        XCTAssertNotNil(show.image)
        XCTAssertNotNil(show.summary)
    }
    
    func testDecodeImageInfo() throws {
        let json = """
        {
          "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/297/744253.jpg",
          "original": "https://static.tvmaze.com/uploads/images/original_untouched/297/744253.jpg"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let imageInfo = try decoder.decode(ImageInfo.self, from: json)
        
        XCTAssertEqual(imageInfo.medium, "https://static.tvmaze.com/uploads/images/medium_portrait/297/744253.jpg")
        XCTAssertEqual(imageInfo.original, "https://static.tvmaze.com/uploads/images/original_untouched/297/744253.jpg")
    }
}
