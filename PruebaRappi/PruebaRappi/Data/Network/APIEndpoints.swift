//
//  APIEndpoints.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

struct APIEndpoints {
    
    static func getRappiMovies(with rappiMoviesRequestDTO: RappiMoviesRequestDTO) -> Endpoint<RappiMoviesResponseDTO> {
        let path = "3/movie/\(rappiMoviesRequestDTO.query)"
        return Endpoint(path: path,
                        method: .get,
                        queryParametersEncodable: rappiMoviesRequestDTO)
    }

    
    static func getRappiMoviePoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!
        
        return Endpoint(path: "t/p/w\(closestWidth)\(path)",
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}
