//
//  RappiMovieDetailsViewModelTests.swift
//  PruebaRappiTests
//
//  Created by luis quitan on 16/11/21.
//

import XCTest

class RappiMovieDetailsViewModelTests: XCTestCase {
    
    private enum PosterImageDowloadError: Error {
        case someError
    }
    
    func test_updatePosterImageWithWidthEventReceived_thenImageWithThisWidthIsDownloaded() {
        // given
        let posterImagesRepository = PosterImagesRepositoryMock()
        posterImagesRepository.expectation = self.expectation(description: "Image with download")
        let expectedImage = "image data".data(using: .utf8)!
        posterImagesRepository.image = expectedImage

        let viewModel = DefaultRappiMovieDetailsViewModel(rappiMovie: RappiMovie.stub(posterPath: "posterPath"),
                                                     posterImagesRepository: posterImagesRepository)
        
        posterImagesRepository.validateInput = { (imagePath: String, width: Int) in
            XCTAssertEqual(imagePath, "posterPath")
            XCTAssertEqual(width, 200)
        }
        
        // when
        viewModel.updatePosterImage(width: 200)
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.posterImage.value, expectedImage)
    }
}
