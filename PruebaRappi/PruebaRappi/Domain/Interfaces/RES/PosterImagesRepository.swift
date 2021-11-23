//
//  PosterImagesRepository.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation

protocol PosterImagesRepository {
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
