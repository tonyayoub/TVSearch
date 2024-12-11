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
        
        XCTAssertEqual(result.score, 0.909815)
        XCTAssertNotNil(result.show)
        
        let show = result.show!
        XCTAssertEqual(show.id, 139)
        XCTAssertEqual(show.url, "https://www.tvmaze.com/shows/139/girls")
        XCTAssertEqual(show.name, "Girls")
        XCTAssertEqual(show.language, "English")
        XCTAssertEqual(show.runtime, 30)
        XCTAssertEqual(show.officialSite, "http://www.hbo.com/girls")
        XCTAssertNotNil(show.rating)
        XCTAssertNotNil(show.network)
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
        XCTAssertEqual(show.url, "https://www.tvmaze.com/shows/525/gilmore-girls")
        XCTAssertEqual(show.name, "Gilmore Girls")
        XCTAssertEqual(show.language, "English")
        XCTAssertEqual(show.runtime, 60)
        XCTAssertNil(show.officialSite)
        XCTAssertNotNil(show.rating)
        XCTAssertNotNil(show.network)
        XCTAssertNotNil(show.image)
        XCTAssertNotNil(show.summary)
    }
    
    func testDecodeRating() throws {
        let json = """
        {
          "average": 7.2
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let rating = try decoder.decode(Rating.self, from: json)
        
        XCTAssertEqual(rating.average, 7.2)
    }
    
    func testDecodeNetwork() throws {
        let json = """
        {
          "id": 1,
          "name": "NBC",
          "officialSite": "https://www.nbc.com/"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let network = try decoder.decode(Network.self, from: json)
        
        XCTAssertEqual(network.id, 1)
        XCTAssertEqual(network.name, "NBC")
        XCTAssertEqual(network.officialSite, "https://www.nbc.com/")
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
