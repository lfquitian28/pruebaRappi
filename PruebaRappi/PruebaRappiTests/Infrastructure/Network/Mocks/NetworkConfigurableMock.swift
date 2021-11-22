//
//  NetworkConfigurableMock.swift
//  PruebaRappiTests
//
//  Created by luis quitan on 16/11/21.
//

import Foundation

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
