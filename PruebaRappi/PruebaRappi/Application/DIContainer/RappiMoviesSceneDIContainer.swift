//
//  RappiMoviesSceneDIContainer.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import UIKit
import SwiftUI

final class RappiMoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var rappiMoviesResponseCache: RappiMoviesResponseStorage = CoreDataRappiMoviesResponseStorage()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchRappiMoviesUseCase() -> SearchRappiMoviesUseCase {
        return DefaultSearchRappiMoviesUseCase(rappiMoviesRepository: makeRappiMoviesRepository())
    }
    
    
    // MARK: - Repositories
    func makeRappiMoviesRepository() -> RappiMoviesRepository {
        return DefaultRappiMoviesRepository(dataTransferService: dependencies.apiDataTransferService, cache: rappiMoviesResponseCache)
    }
    
    func makePosterImagesRepository() -> PosterImagesRepository {
        return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService)
    }
    
    // MARK: - RappiCategory Menu
    func makeRappiCategoryMenuViewController(actions: RappiCategoryViewModelActions) -> MenuRappiCategoryViewController {
        return MenuRappiCategoryViewController.create(with: makeRappiCategoryMenuViewModel(actions: actions))
    }
    
    func makeRappiCategoryMenuViewModel(actions: RappiCategoryViewModelActions) -> RappiMovieCategoryViewModel {
        return DefaultRappiMovieCategoryViewModel(actions: actions)
    }
    
    
    // MARK: - RappiMovies List
    func makeRappiMoviesListViewController(actions: RappiMoviesListViewModelActions, category: String) -> RappiMoviesListViewController {
        return RappiMoviesListViewController.create(with: makeRappiMoviesListViewModel(actions: actions), category: category, 
                                               posterImagesRepository: makePosterImagesRepository())
    }
    
    func makeRappiMoviesListViewModel(actions: RappiMoviesListViewModelActions) -> RappiMoviesListViewModel {
        return DefaultRappiMoviesListViewModel(searchRappiMoviesUseCase: makeSearchRappiMoviesUseCase(),
                                          actions: actions)
    }
    
    // MARK: - RappiMovie Details
    func makeRappiMoviesDetailsViewController(rappiMovie: RappiMovie) -> UIViewController {
        return RappiMovieDetailsViewController.create(with: makeRappiMoviesDetailsViewModel(rappiMovie: rappiMovie))
    }
    
    func makeRappiMoviesDetailsViewModel(rappiMovie: RappiMovie) -> RappiMovieDetailsViewModel {
        return DefaultRappiMovieDetailsViewModel(rappiMovie: rappiMovie,
                                            posterImagesRepository: makePosterImagesRepository())
    }

    // MARK: - Flow Coordinators
    func makeRappiMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> RappiMoviesSearchFlowCoordinator {
        return RappiMoviesSearchFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension RappiMoviesSceneDIContainer: RappiMoviesSearchFlowCoordinatorDependencies {}

