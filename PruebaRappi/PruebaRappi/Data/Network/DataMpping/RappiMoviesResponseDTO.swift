//
//  RappiMoviesResponseDTO.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation
import SwiftUI

// MARK: - Data Transfer Object

struct RappiMoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case rappiMovies = "results"
    }
    let page: Int
    let totalPages: Int
    let rappiMovies: [RappiMovieDTO]
}

extension RappiMoviesResponseDTO {
    struct RappiMovieDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case genre
            case posterPath = "poster_path"
            case overview
            case releaseDate = "release_date"
            case video
            case voteAverage
            case popularity
            case originalTitle
        }
        enum GenreDTO: String, Decodable {
            case adventure
            case scienceFiction = "science_fiction"
        }
        let id: Int
        let title: String?
        let genre: GenreDTO?
        let posterPath: String?
        let overview: String?
        let releaseDate: String?
        let video: Bool?
        let voteAverage: Double?
        let popularity: Double?
        let originalTitle: String?
    }
}

// MARK: - Mappings to Domain

extension RappiMoviesResponseDTO {
    func toDomain() -> RappiMoviesPage {
        return .init(page: page,
                     totalPages: totalPages,
                     rappiMovies: rappiMovies.map { $0.toDomain() })
    }
}

extension RappiMoviesResponseDTO.RappiMovieDTO {
    func toDomain() -> RappiMovie {
        return .init(id: RappiMovie.Identifier(id),
                     title: title,
                     genre: genre?.toDomain(),
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: dateFormatter.date(from: releaseDate ?? ""),
                     video: video,
                     voteAverage: voteAverage,
                     popularity: popularity,
                     originalTitle: originalTitle)
    }
}

extension RappiMoviesResponseDTO.RappiMovieDTO.GenreDTO {
    func toDomain() -> RappiMovie.Genre {
        switch self {
        case .adventure: return .adventure
        case .scienceFiction: return .scienceFiction
        }
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
