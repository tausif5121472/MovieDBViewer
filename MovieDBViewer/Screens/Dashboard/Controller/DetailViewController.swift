//
//  DetailViewController.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImdb: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    
    //MARK:- Properties
    var model: PopularMoviesList? = nil
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        if let model = model {
            self.renderUI(model: model)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    func renderUI(model: PopularMoviesList) {
        
        let imageURL = (ConstantsManager.imageFolderPath) + (model.posterPath ?? "" )
        movieImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "no-image"), options: nil, completionHandler: nil)
        movieTitle.text = model.title
        movieImdb.text = model.releaseDate
        movieDescription.text = model.overview
        movieLanguage.text = model.originalLanguage
        movieGenres.text = "\(model.voteAverage ?? 0.0)"
    }
    
}
