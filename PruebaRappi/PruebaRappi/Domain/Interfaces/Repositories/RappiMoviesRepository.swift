//
//  RappiMoviesRepository.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

protocol RappiMoviesRepository {
    @discardableResult
    func fetchRappiMoviesList(query: RappiMovieQuery, page: Int,
                         cached: @escaping (RappiMoviesPage) -> Void,
                         completion: @escaping (Result<RappiMoviesPage, Error>) -> Void) -> Cancellable?
}
