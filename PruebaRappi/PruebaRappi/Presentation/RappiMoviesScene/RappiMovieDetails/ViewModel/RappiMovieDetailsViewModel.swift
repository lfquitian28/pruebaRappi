//
//  RappiMovieDetailsViewModel.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation

protocol RappiMovieDetailsViewModelInput {
    func updatePosterImage(width: Int)
}

protocol RappiMovieDetailsViewModelOutput {
    var rappiMovie: RappiMovie { get }
    var posterImage: Observable<Data?> { get }
    var isPosterImageHidden: Bool { get }
}

protocol RappiMovieDetailsViewModel: RappiMovieDetailsViewModelInput, RappiMovieDetailsViewModelOutput { }

final class DefaultRappiMovieDetailsViewModel: RappiMovieDetailsViewModel {
    
    private let posterImagePath: String?
    private let posterImagesRepository: PosterImagesRepository
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    // MARK: - OUTPUT
    let rappiMovie: RappiMovie
    let posterImage: Observable<Data?> = Observable(nil)
    let isPosterImageHidden: Bool
    
    init(rappiMovie: RappiMovie,
         posterImagesRepository: PosterImagesRepository) {
        self.rappiMovie = rappiMovie
        self.posterImagePath = rappiMovie.posterPath
        self.isPosterImageHidden = rappiMovie.posterPath == nil
        self.posterImagesRepository = posterImagesRepository
    }
}

// MARK: - INPUT. View event methods
extension DefaultRappiMovieDetailsViewModel {
    
    func updatePosterImage(width: Int) {
        guard let posterImagePath = posterImagePath else { return }

        imageLoadTask = posterImagesRepository.fetchImage(with: posterImagePath, width: width) { result in
            guard self.posterImagePath == posterImagePath else { return }
            switch result {
            case .success(let data):
                self.posterImage.value = data
            case .failure: break
            }
            self.imageLoadTask = nil
        }
    }
}
