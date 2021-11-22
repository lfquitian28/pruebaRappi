//
//  RappiMoviesRequestDTO.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

struct RappiMoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
