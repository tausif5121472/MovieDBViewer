//
//  PopularMoviesModel.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation

// MARK: - Welcome
struct PopularMoviesModel: Codable {
    let page: Int?
    let results: [PopularMoviesList]
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularMoviesList: Codable {
    let adult: Bool?
    let backdropPath: String?
    
    let id: Int?
    let originalLanguage: Language?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum Language: String, Codable {
    case en = "en"
    case hi = "hi"
    case uk = "uk"
}
