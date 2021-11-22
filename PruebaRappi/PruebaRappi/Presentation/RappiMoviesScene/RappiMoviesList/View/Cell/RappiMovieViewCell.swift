//
//  RappiMovieViewCell.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import UIKit

class RappiMovieViewCell: UITableViewCell {

    @IBOutlet weak var titleRappiMovie: UILabel!
    @IBOutlet weak var imageRappiMovie: UIImageView!
    
    private var viewModel: RappiMoviesListItemViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    func fill(with viewModel: RappiMoviesListItemViewModel, posterImagesRepository: PosterImagesRepository?) {
        self.viewModel = viewModel
        self.posterImagesRepository = posterImagesRepository

        titleRappiMovie.text = viewModel.title
        updatePosterImage(width: Int(imageRappiMovie.imageSizeAfterAspectFit.scaledSize.width))
    }

    private func updatePosterImage(width: Int) {
        imageRappiMovie.image = nil
        guard let posterImagePath = viewModel.posterImagePath else { return }

        imageLoadTask = posterImagesRepository?.fetchImage(with: posterImagePath, width: width) { [weak self] result in
            guard let self = self else { return }
            guard self.viewModel.posterImagePath == posterImagePath else { return }
            if case let .success(data) = result {
                self.imageRappiMovie.image = UIImage(data: data)
            }
            self.imageLoadTask = nil
        }
    }
}
