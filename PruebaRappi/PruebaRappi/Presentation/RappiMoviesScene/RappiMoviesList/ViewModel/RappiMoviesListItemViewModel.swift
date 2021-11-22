//
//  RappiMoviesListItemViewModel.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//
// **Note**: This item view model is to display data and does not contain any domain model to prevent views accessing it

import Foundation

struct RappiMoviesListItemViewModel: Equatable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
    let video: Bool?
    let voteAverage: Double?
    let popularity: Double?
    let originalTitle: String?
}

extension RappiMoviesListItemViewModel {

    init(rappiMovie: RappiMovie) {
        self.title = rappiMovie.title ?? ""
        self.posterImagePath = rappiMovie.posterPath
        self.overview = rappiMovie.overview ?? ""
        if let releaseDate = rappiMovie.releaseDate {
            self.releaseDate = "\(NSLocalizedString("Release Date", comment: "")): \(dateFormatter.string(from: releaseDate))"
        } else {
            self.releaseDate = NSLocalizedString("To be announced", comment: "")
        }
        self.video = rappiMovie.video
        self.voteAverage = rappiMovie.voteAverage
        self.popularity = rappiMovie.popularity
        self.originalTitle  = rappiMovie.originalTitle
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
