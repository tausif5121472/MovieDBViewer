//
//  DetailViewModel.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation
protocol DetailViewModelDelegate: AnyObject {
    func successfulFetchMovieDetail(model:  MovieDetailModel)
    func failToFetchMovieDetail(errorMessage: String)
}

class DetailViewModel {
    let apiCaller = ApiCallerClass.shared
    weak var delegate: DetailViewModelDelegate? = nil
    
    func fetchMovieDetails(movieId: String) {
        apiCaller.fetchMovieDetailApi(id: movieId){ model in
            self.delegate?.successfulFetchMovieDetail(model: model)
        } failedCallBack: { error in
            self.delegate?.failToFetchMovieDetail(errorMessage: error)
        }
        
    }
}
