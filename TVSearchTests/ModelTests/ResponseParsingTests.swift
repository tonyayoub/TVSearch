//
//  ResponseParsingTests.swift
//  TVSearchTests
//
//  Created by Tony Ayoub on 11-12-2024.
//

import XCTest

@testable import TVSearch  // Replace with your module name

final class JSONFileDecodingTests: XCTestCase {
    
    func testDecodingFromJSONFile() throws {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "SampleResponse", withExtension: "json") else {
            XCTFail("Missing file: SampleResponse.json")
            return
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let results = try decoder.decode([ShowSearchResult].self, from: data)
        
        XCTAssertFalse(results.isEmpty, "Expected to parse at least one result")
        
        if let firstResult = results.first {
            XCTAssertNotNil(firstResult.show, "Show should not be nil")
            
            if let show = firstResult.show {
                XCTAssertNotNil(show.id, "Show 'id' should not be nil")
                XCTAssertNotNil(show.name, "Show 'name' should not be nil")
                
                XCTAssertEqual(show.name, "Girls", "The first show's name does not match expected value")
            }
        }
    }
}
