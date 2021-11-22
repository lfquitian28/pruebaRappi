//
//  SearchRappiMoviesUseCase.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

protocol SearchRappiMoviesUseCase {
    func execute(requestValue: SearchRappiMoviesUseCaseRequestValue,
                 cached: @escaping (RappiMoviesPage) -> Void,
                 completion: @escaping (Result<RappiMoviesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchRappiMoviesUseCase: SearchRappiMoviesUseCase {

    private let rappiMoviesRepository: RappiMoviesRepository

    init(rappiMoviesRepository: RappiMoviesRepository) {

        self.rappiMoviesRepository = rappiMoviesRepository
    }

    func execute(requestValue: SearchRappiMoviesUseCaseRequestValue,
                 cached: @escaping (RappiMoviesPage) -> Void,
                 completion: @escaping (Result<RappiMoviesPage, Error>) -> Void) -> Cancellable? {

        return rappiMoviesRepository.fetchRappiMoviesList(query: requestValue.query,
                                                page: requestValue.page,
                                                cached: cached,
                                                completion: { result in

            completion(result)
        })
    }
}

struct SearchRappiMoviesUseCaseRequestValue {
    let query: RappiMovieQuery
    let page: Int
}
