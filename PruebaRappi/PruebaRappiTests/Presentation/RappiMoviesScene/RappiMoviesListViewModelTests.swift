//
//  RappiMoviesListViewModelTests.swift
//  PruebaRappiTests
//
//  Created by luis quitan on 16/11/21.
//

import XCTest

class RappiMoviesListViewModelTests: XCTestCase {
    
    private enum SearchRappiMoviesUseCaseError: Error {
        case someError
    }
    
    let rappiMoviesPages: [RappiMoviesPage] = {
        let page1 = RappiMoviesPage(page: 1, totalPages: 2, rappiMovies: [
            RappiMovie.stub(id: "1", title: "title1", posterPath: "/1", overview: "overview1"),
            RappiMovie.stub(id: "2", title: "title2", posterPath: "/2", overview: "overview2")])
        let page2 = RappiMoviesPage(page: 2, totalPages: 2, rappiMovies: [
            RappiMovie.stub(id: "3", title: "title3", posterPath: "/3", overview: "overview3")])
        return [page1, page2]
    }()
    
    class SearchRappiMoviesUseCaseMock: SearchRappiMoviesUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var page = RappiMoviesPage(page: 0, totalPages: 0, rappiMovies: [])
        
        func execute(requestValue: SearchRappiMoviesUseCaseRequestValue,
                     cached: @escaping (RappiMoviesPage) -> Void,
                     completion: @escaping (Result<RappiMoviesPage, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(page))
            }
            expectation?.fulfill()
            return nil
        }
    }
    
    func test_whenSearchRappiMoviesUseCaseRetrievesFirstPage_thenViewModelContainsOnlyFirstPage() {
        // given
        let searchRappiMoviesUseCaseMock = SearchRappiMoviesUseCaseMock()
        searchRappiMoviesUseCaseMock.expectation = self.expectation(description: "contains only first page")
        searchRappiMoviesUseCaseMock.page = RappiMoviesPage(page: 1, totalPages: 2, rappiMovies: rappiMoviesPages[0].rappiMovies)
        let viewModel = DefaultRappiMoviesListViewModel(searchRappiMoviesUseCase: searchRappiMoviesUseCaseMock)
        // when
        viewModel.didSearch(query: "query")
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMorePages)
    }
    
    func test_whenSearchRappiMoviesUseCaseRetrievesFirstAndSecondPage_thenViewModelContainsTwoPages() {
        // given
        let searchRappiMoviesUseCaseMock = SearchRappiMoviesUseCaseMock()
        searchRappiMoviesUseCaseMock.expectation = self.expectation(description: "First page loaded")
        searchRappiMoviesUseCaseMock.page = RappiMoviesPage(page: 1, totalPages: 2, rappiMovies: rappiMoviesPages[0].rappiMovies)
        let viewModel = DefaultRappiMoviesListViewModel(searchRappiMoviesUseCase: searchRappiMoviesUseCaseMock)
        // when
        viewModel.didSearch(query: "query")
        waitForExpectations(timeout: 5, handler: nil)
        
        searchRappiMoviesUseCaseMock.expectation = self.expectation(description: "Second page loaded")
        searchRappiMoviesUseCaseMock.page = RappiMoviesPage(page: 2, totalPages: 2, rappiMovies: rappiMoviesPages[1].rappiMovies)
        
        viewModel.didLoadNextPage()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertFalse(viewModel.hasMorePages)
    }
    
    func test_whenSearchRappiMoviesUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let searchRappiMoviesUseCaseMock = SearchRappiMoviesUseCaseMock()
        searchRappiMoviesUseCaseMock.expectation = self.expectation(description: "contain errors")
        searchRappiMoviesUseCaseMock.error = SearchRappiMoviesUseCaseError.someError
        let viewModel = DefaultRappiMoviesListViewModel(searchRappiMoviesUseCase: searchRappiMoviesUseCaseMock)
        // when
        viewModel.didSearch(query: "query")
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_whenLastPage_thenHasNoPageIsTrue() {
        // given
        let searchRappiMoviesUseCaseMock = SearchRappiMoviesUseCaseMock()
        searchRappiMoviesUseCaseMock.expectation = self.expectation(description: "First page loaded")
        searchRappiMoviesUseCaseMock.page = RappiMoviesPage(page: 1, totalPages: 2, rappiMovies: rappiMoviesPages[0].rappiMovies)
        let viewModel = DefaultRappiMoviesListViewModel(searchRappiMoviesUseCase: searchRappiMoviesUseCaseMock)
        // when
        viewModel.didSearch(query: "query")
        waitForExpectations(timeout: 5, handler: nil)
        
        searchRappiMoviesUseCaseMock.expectation = self.expectation(description: "Second page loaded")
        searchRappiMoviesUseCaseMock.page = RappiMoviesPage(page: 2, totalPages: 2, rappiMovies: rappiMoviesPages[1].rappiMovies)

        viewModel.didLoadNextPage()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertFalse(viewModel.hasMorePages)
    }
}
