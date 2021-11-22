//
//  RappiMovie.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

struct RappiMovie: Equatable, Identifiable {
    typealias Identifier = String
    enum Genre {
        case adventure
        case scienceFiction
    }
    let id: Identifier
    let title: String?
    let genre: Genre?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
    let video: Bool?
    let voteAverage: Double?
    let popularity: Double?
    let originalTitle: String?
}

struct RappiMoviesPage: Equatable {
    let page: Int
    let totalPages: Int
    let rappiMovies: [RappiMovie]
}

