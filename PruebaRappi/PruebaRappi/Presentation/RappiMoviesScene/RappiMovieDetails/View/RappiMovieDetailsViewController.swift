//
//  RappiMovieDetailsViewController.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import UIKit

class RappiMovieDetailsViewController: UIViewController {

    private var viewModel: RappiMovieDetailsViewModel!
    
    @IBOutlet weak var rappiMovieRaiting: UILabel!
    @IBOutlet weak var rappiMovieDescription: UILabel!
    @IBOutlet weak var rappiMovieImage: UIImageView!
    @IBOutlet weak var rappiMovieTitle: UILabel!
    @IBOutlet weak var rappiMovieRealeseDate: UILabel!
    @IBOutlet weak var rappiMovieTrailer: UIButton!
    
    
    static func create(with viewModel: RappiMovieDetailsViewModel) -> RappiMovieDetailsViewController {
        let view = RappiMovieDetailsViewController(nibName: "RappiMovieDetailsViewController", bundle: Bundle.main)
        view.viewModel = viewModel
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        setUpNavBar()
    }

    private func bind(to viewModel: RappiMovieDetailsViewModel) {
        viewModel.posterImage.observe(on: self) { [weak self] in self?.rappiMovieImage.image = $0.flatMap(UIImage.init) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.updatePosterImage(width: Int(rappiMovieImage.imageSizeAfterAspectFit.scaledSize.width))
    }

    // MARK: - Private

    private func setupViews() {
        title = viewModel.rappiMovie.title ?? ""
        rappiMovieTitle.text = viewModel.rappiMovie.originalTitle ?? ""
        rappiMovieRaiting.text = String(format: "%.1f/10", viewModel.rappiMovie.voteAverage ?? 0.0)
        rappiMovieDescription.text = viewModel.rappiMovie.overview ?? ""
        rappiMovieImage.isHidden = viewModel.isPosterImageHidden
        rappiMovieRealeseDate.text = viewModel.rappiMovie.releaseDate?.description
        view.accessibilityIdentifier = AccessibilityIdentifier.movieDetailsView
    }

    func setUpNavBar(){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.black
        self.navigationController?.view.tintColor = UIColor.blue

        //For back button in navigation bar
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
