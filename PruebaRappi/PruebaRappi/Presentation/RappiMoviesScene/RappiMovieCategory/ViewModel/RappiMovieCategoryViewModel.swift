//
//  RappiMovieDCategoryViewModel.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation

struct RappiCategoryViewModelActions {
    let showRappiCategory: (String) -> Void
}

protocol RappiMovieCategoryViewModelInput {
    func searchRappiCategory(width: String)
}


protocol RappiMovieCategoryViewModel: RappiMovieCategoryViewModelInput { }

final class DefaultRappiMovieCategoryViewModel: RappiMovieCategoryViewModel {
    
    func searchRappiCategory(width category: String) {
        showRappiCategory(rappiCategory: category)
    }
    
    
    private let actions: RappiCategoryViewModelActions?
    
    init(actions: RappiCategoryViewModelActions? = nil) {
        self.actions = actions
    }
    
    func showRappiCategory(rappiCategory: String) {
        actions?.showRappiCategory(rappiCategory)
    }
 
}
