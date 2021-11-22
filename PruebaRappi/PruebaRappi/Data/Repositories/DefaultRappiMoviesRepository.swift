//
//  DefaultRappiMoviesRepository.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//
// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

final class DefaultRappiMoviesRepository {

    private let dataTransferService: DataTransferService
    private let cache: RappiMoviesResponseStorage

    init(dataTransferService: DataTransferService, cache: RappiMoviesResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultRappiMoviesRepository: RappiMoviesRepository {

    public func fetchRappiMoviesList(query: RappiMovieQuery, page: Int,
                                cached: @escaping (RappiMoviesPage) -> Void,
                                completion: @escaping (Result<RappiMoviesPage, Error>) -> Void) -> Cancellable? {

        let requestDTO = RappiMoviesRequestDTO(query: query.query, page: page)
        let task = RepositoryTask()

        cache.getResponse(for: requestDTO) { result in

            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getRappiMovies(with: requestDTO)
            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
                switch result {
                case .success(let responseDTO):
                    self.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}
