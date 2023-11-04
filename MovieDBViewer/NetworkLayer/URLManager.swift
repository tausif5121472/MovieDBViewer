//
//  URLManager.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation

enum URLManager: String {
    
    case fetchPopularMovieList = "https://api.themoviedb.org/3/movie/popular"
    case seletedMovieDetail = "https://api.themoviedb.org/3/movie/?"
}
