//
//  RappiMoviesListViewController.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import UIKit

class RappiMoviesListViewController: UIViewController,Alertable {
    
    private var viewModel: RappiMoviesListViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    private var category: String!

    private var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var rappiMovieTableView: UITableView!
    
    
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: RappiMoviesListViewModel, category: String,
                       posterImagesRepository: PosterImagesRepository?) -> RappiMoviesListViewController {
        let view = RappiMoviesListViewController(nibName: "RappiMoviesListViewController", bundle: Bundle.main)
        view.viewModel = viewModel
        view.category = category
        view.posterImagesRepository = posterImagesRepository
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.didSearch(query: category)
        configureTableView()
        // Do any additional setup after loading the view.
    }

    private func bind(to viewModel: RappiMoviesListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.query.observe(on: self) { [weak self] in self?.updateSearchQuery($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func configureTableView(){
        
        let cellNib = UINib(nibName: "RappiMovieViewCell",bundle: nil)
        self.rappiMovieTableView.register(cellNib, forCellReuseIdentifier: "RappiMovieViewCell")
        rappiMovieTableView.estimatedRowHeight = CGFloat(130)
        rappiMovieTableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Response Observable Private

    private func setupViews() {
        title = viewModel.screenTitle
        
    }

    private func setupBehaviours() {
        
    }

    private func updateItems() {
        rappiMovieTableView.reloadData()
    }



    private func updateSearchQuery(_ query: String) {
        searchController.isActive = false
        searchController.searchBar.text = query
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }

}

extension RappiMoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RappiMovieViewCell",
                                                       for: indexPath) as? RappiMovieViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(RappiMovieViewCell.self) with reuseIdentifier: RappiMovieViewCell")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row],
                  posterImagesRepository: posterImagesRepository)

        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
