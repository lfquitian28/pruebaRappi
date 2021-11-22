//
//  RappiMoviesListViewModel.swift
//  PruebaRappi
//
//  Created by luis quitan on 14/11/21.
//

import Foundation

struct RappiMoviesListViewModelActions {
    let showRappiMovieDetails: (RappiMovie) -> Void
}

enum RappiMoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol RappiMoviesListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}

protocol RappiMoviesListViewModelOutput {
    var items: Observable<[RappiMoviesListItemViewModel]> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol RappiMoviesListViewModel: RappiMoviesListViewModelInput, RappiMoviesListViewModelOutput {}

final class DefaultRappiMoviesListViewModel: RappiMoviesListViewModel {

    private let searchRappiMoviesUseCase: SearchRappiMoviesUseCase
    private let actions: RappiMoviesListViewModelActions?

    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    private var pages: [RappiMoviesPage] = []
    private var rappiMoviesLoadTask: Cancellable? { willSet { rappiMoviesLoadTask?.cancel() } }

    // MARK: - OUTPUT

    let items: Observable<[RappiMoviesListItemViewModel]> = Observable([])
    let loading: Observable<RappiMoviesListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("RappiMovies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search RappiMovies", comment: "")

    // MARK: - Init

    init(searchRappiMoviesUseCase: SearchRappiMoviesUseCase,
         actions: RappiMoviesListViewModelActions? = nil) {
        self.searchRappiMoviesUseCase = searchRappiMoviesUseCase
        self.actions = actions
    }

    // MARK: - Private

    private func appendPage(_ rappiMoviesPage: RappiMoviesPage) {
        currentPage = rappiMoviesPage.page
        totalPageCount = rappiMoviesPage.totalPages

        pages = pages
            .filter { $0.page != rappiMoviesPage.page }
            + [rappiMoviesPage]

        items.value = pages.rappiMovies.map(RappiMoviesListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }

    private func load(rappiMovieQuery: RappiMovieQuery, loading: RappiMoviesListViewModelLoading) {
        self.loading.value = loading
        query.value = rappiMovieQuery.query

        rappiMoviesLoadTask = searchRappiMoviesUseCase.execute(
            requestValue: .init(query: rappiMovieQuery, page: nextPage),
            cached: appendPage,
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendPage(page)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }

    private func handle(error: Error) {
        self.error.value =  NSLocalizedString("No internet connection", comment: "")
    }

    private func update(rappiMovieQuery: RappiMovieQuery) {
        resetPages()
        load(rappiMovieQuery: rappiMovieQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultRappiMoviesListViewModel {

    func viewDidLoad() { }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(rappiMovieQuery: .init(query: query.value),
             loading: .nextPage)
    }

    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(rappiMovieQuery: RappiMovieQuery(query: query))
    }

    func didCancelSearch() {
        rappiMoviesLoadTask?.cancel()
    }

    func didSelectItem(at index: Int) {
        actions?.showRappiMovieDetails(pages.rappiMovies[index])
    }
}

// MARK: - Private

private extension Array where Element == RappiMoviesPage {
    var rappiMovies: [RappiMovie] { flatMap { $0.rappiMovies } }
}
