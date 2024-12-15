//
//  HomeViewModelTests.swift
//  TVSearchTests
//
//  Created by Tony Ayoub on 15-12-2024.
//

import XCTest
import Combine
@testable import TVSearch

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    private var mockService: MockShowService!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockService = MockShowService()
        viewModel = HomeViewModel(service: mockService)
        viewModel.objectWillChange
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    override func tearDown() {
        cancellables.removeAll()
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.shows.isEmpty)
        XCTAssertTrue(viewModel.showsByGenre.isEmpty)
        XCTAssertEqual(viewModel.searchQuery, "")
        XCTAssertNil(viewModel.error)
        XCTAssertNil(viewModel.selectedGenre)
        XCTAssertNil(viewModel.selectedShow)
        XCTAssertTrue(viewModel.showEmptyView)
        XCTAssertEqual(viewModel.reasonForEmptyView, .noQuery)
        XCTAssertTrue(viewModel.isConnected)
    }
    
    func testPerformSearchWithEmptyQuery() async {
        await viewModel.performSearch(query: "")
        XCTAssertTrue(viewModel.shows.isEmpty)
        XCTAssertTrue(viewModel.showsByGenre.isEmpty)
    }
    
    func testPerformSearchWithResults() async {
        let expectedShows = [
            Show(id: 1, name: "Friends", genres: ["Comedy"], runtime: 120, image: nil, summary: nil),
            Show(id: 2, name: "Seinfeld", genres: ["Comedy"], runtime: 120, image: nil, summary: nil),
            Show(id: 3, name: "Breaking Bad", genres: ["Drama"], runtime: 120, image: nil, summary: nil)
        ]
        
        mockService.expectedResults = expectedShows
        await viewModel.performSearch(query: "Friends")
        
        XCTAssertEqual(viewModel.shows.count, 3)
        XCTAssertEqual(viewModel.showsByGenre.keys.sorted(), ["Comedy", "Drama"])
        XCTAssertNil(viewModel.error)
    }
    
    func testPerformSearchNoResults() async {
        mockService.expectedResults = []
        await viewModel.performSearch(query: "NonExistentShow")
        
        XCTAssertTrue(viewModel.shows.isEmpty)
        XCTAssertTrue(viewModel.showsByGenre.isEmpty)
    }
    
    func testDebouncedSearchTrigger() throws {
        mockService.expectedResults = [Show(id: 1, name: "Harry", genres: ["Fantasy"], runtime: 120, image: nil, summary: nil)]
        
        let expectation = self.expectation(description: "Search triggered after debounce")
        
        viewModel.searchQuery = "Harry"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            XCTAssertEqual(self.viewModel.shows.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0)
    }
    
    func testGenresDuplicates() {
        viewModel.shows = [
            Show(id: 1, name: "A", genres: ["Drama", "Thriller"], runtime: 120, image: nil, summary: nil),
            Show(id: 2, name: "B", genres: ["Comedy"], runtime: 120, image: nil, summary: nil),
            Show(id: 3, name: "C", genres: ["Drama"], runtime: 120, image: nil, summary: nil)
        ]
        
        let expectedGenres = ["Comedy", "Drama", "Thriller"]
        XCTAssertEqual(viewModel.genres, expectedGenres)
    }
}

// MARK: - Mocks

class MockShowService: ShowService {
    var expectedResults: [Show] = []
    func search(query: String) async throws -> [TVSearch.Show] {
        expectedResults
    }
}
