//
//  RappiMoviesResponseStorage.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation

protocol RappiMoviesResponseStorage {
    func getResponse(for request: RappiMoviesRequestDTO, completion: @escaping (Result<RappiMoviesResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: RappiMoviesResponseDTO, for requestDto: RappiMoviesRequestDTO)
}
