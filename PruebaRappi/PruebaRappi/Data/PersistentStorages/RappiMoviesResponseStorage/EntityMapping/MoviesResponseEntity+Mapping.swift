//
//  RappiMoviesResponseEntity+Mapping.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation
import CoreData

extension RappiMoviesResponseEntity {
    func toDTO() -> RappiMoviesResponseDTO {
        return .init(page: Int(page),
                     totalPages: Int(totalPages),
                     rappiMovies: rappiMovies?.allObjects.map { ($0 as! RappiMovieResponseEntity).toDTO() } ?? [])
    }
}

extension RappiMovieResponseEntity {
    func toDTO() -> RappiMoviesResponseDTO.RappiMovieDTO {
        return .init(id: Int(id),
                     title: title,
                     genre: RappiMoviesResponseDTO.RappiMovieDTO.GenreDTO(rawValue: genre ?? ""),
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: releaseDate,
                     video: video,
                     voteAverage: voteAverage,
                     popularity: popularity as! Double ,
                     originalTitle: originalTitle)
    }
}

extension RappiMoviesRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> RappiMoviesRequestEntity {
        let entity: RappiMoviesRequestEntity = .init(context: context)
        entity.query = query
        entity.page = Int32(page)
        return entity
    }
}

extension RappiMoviesResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> RappiMoviesResponseEntity {
        let entity: RappiMoviesResponseEntity = .init(context: context)
        entity.page = Int32(page)
        entity.totalPages = Int32(totalPages)
        rappiMovies.forEach {
            entity.addToRappiMovies($0.toEntity(in: context))
        }
        return entity
    }
}

extension RappiMoviesResponseDTO.RappiMovieDTO {
    func toEntity(in context: NSManagedObjectContext) -> RappiMovieResponseEntity {
        let entity: RappiMovieResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        entity.genre = genre?.rawValue
        entity.posterPath = posterPath
        entity.overview = overview
        entity.releaseDate = releaseDate
        return entity
    }
}
