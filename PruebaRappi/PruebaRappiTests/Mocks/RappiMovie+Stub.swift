//
//  Movie+Stub.swift
//  PruebaRappiTests
//
//  Created by luis quitan on 15/11/21.
//

import Foundation

extension RappiMovie {
    static func stub(id: RappiMovie.Identifier = "id1",
                title: String = "title1" ,
                genre: RappiMovie.Genre = .adventure,
                posterPath: String? = "/1",
                overview: String = "overview1",
                releaseDate: Date? = nil,
                     video: Bool = false,
                     voteAverage: Double = 0.0,
                     popularity: Double = 0.0,
                     originalTitle: String = "title1") -> Self {
        RappiMovie(id: id,
              title: title,
              genre: genre,
              posterPath: posterPath,
              overview: overview,
              releaseDate: releaseDate,
                   video: video,
                   voteAverage: voteAverage,
                   popularity: popularity,
                   originalTitle: originalTitle)
    }
}
