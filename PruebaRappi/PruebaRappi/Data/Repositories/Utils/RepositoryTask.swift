//
//  RepositoryTask.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
