//
//  DashboardViewModel.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation

protocol DashboardViewModelDelegate: AnyObject {
    func successfulFetchMovies(moviesList:  PopularMoviesModel)
    func failToFetchMovies(errorMessage: String)
}

class DashboardViewModel {
    let apiCaller = ApiCallerClass.shared
    weak var delegate: DashboardViewModelDelegate? = nil
    
    func fetchPopularMovies() {
        apiCaller.fetchPopularMoviesApi { model in
            self.delegate?.successfulFetchMovies(moviesList: model)
        } failedCallBack: { error in
            self.delegate?.failToFetchMovies(errorMessage: error)
        }
        
    }
}
