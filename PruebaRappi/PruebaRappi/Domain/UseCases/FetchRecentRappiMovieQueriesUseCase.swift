//
//  FetchRecentRappiMovieQueriesUseCase.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

// This is another option to create Use Case using more generic way
final class FetchRecentRappiMovieQueriesUseCase: UseCase {

    struct RequestValue {
        let maxCount: Int
    }
    typealias ResultValue = (Result<[RappiMovieQuery], Error>)

    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let rappiMoviesQueriesRepository: RappiMoviesQueriesRepository

    init(requestValue: RequestValue,
         completion: @escaping (ResultValue) -> Void,
         rappiMoviesQueriesRepository: RappiMoviesQueriesRepository) {

        self.requestValue = requestValue
        self.completion = completion
        self.rappiMoviesQueriesRepository = rappiMoviesQueriesRepository
    }
    
    func start() -> Cancellable? {

        rappiMoviesQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}
