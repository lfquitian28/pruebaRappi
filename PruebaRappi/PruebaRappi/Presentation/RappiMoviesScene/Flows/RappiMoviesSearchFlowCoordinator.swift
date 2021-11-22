//
//  RappiMoviesSearchFlowCoordinator.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import UIKit

protocol RappiMoviesSearchFlowCoordinatorDependencies  {
    func makeRappiCategoryMenuViewController(actions: RappiCategoryViewModelActions) -> MenuRappiCategoryViewController
    func makeRappiMoviesListViewController(actions: RappiMoviesListViewModelActions,category: String) -> RappiMoviesListViewController
    func makeRappiMoviesDetailsViewController(rappiMovie: RappiMovie) -> UIViewController
}

final class RappiMoviesSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: RappiMoviesSearchFlowCoordinatorDependencies

    private weak var rappiCategoryVC: MenuRappiCategoryViewController?
    private weak var rappiMoviesListVC: RappiMoviesListViewController?

    init(navigationController: UINavigationController,
         dependencies: RappiMoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = RappiCategoryViewModelActions(showRappiCategory: showRappiCategory)
        let vc = dependencies.makeRappiCategoryMenuViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        rappiCategoryVC = vc
    }
    
    private func showRappiCategory(category: String){
        let actions = RappiMoviesListViewModelActions(showRappiMovieDetails: showRappiMovieDetails)
        let vc = dependencies.makeRappiMoviesListViewController(actions: actions, category: category)

        navigationController?.pushViewController(vc, animated: false)
        rappiMoviesListVC = vc
    }

    private func showRappiMovieDetails(rappiMovie: RappiMovie) {
        let vc = dependencies.makeRappiMoviesDetailsViewController(rappiMovie: rappiMovie)
        navigationController?.pushViewController(vc, animated: true)
    }

}
