//
//  dashboardMoviesCell.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import UIKit
import Kingfisher
class dashboardMoviesCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(model: PopularMoviesList) {
        
        let imageURL = (ConstantsManager.imageFolderPath) + (model.posterPath ?? "")
        movieImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "no-image"), options: nil, completionHandler: nil)
        movieTitle.text = model.title
    }
    
}
