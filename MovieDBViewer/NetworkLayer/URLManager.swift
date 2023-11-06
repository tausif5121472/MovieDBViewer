//
//  URLManager.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation

enum URLManager {
    
    case fetchPopularMovieList(language: String,page: Int)
    case seletedMovieDetail
}
class URLBinder {
    
   static let shared = URLBinder()
    
    private init () {}
    
    func bindURL(urlType: URLManager) -> String {
        switch urlType {
        case .fetchPopularMovieList(language: let language,page: let page):
           return "https://api.themoviedb.org/3/movie/popular?language=\(language)&page=\(page)"
        case .seletedMovieDetail:
            return "https://api.themoviedb.org/3/movie/?"
        }
    }
}
