//
//  ResposeParserManager.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation

class ResposeParserManager {
    
    static let shared = ResposeParserManager()
    let decoder = JSONDecoder()
    
    private init () { }
    
    func decodePopularMovies(data: Data?) -> PopularMoviesModel? {
        do {
            guard let data = data else { return nil}
            let model = try decoder.decode(PopularMoviesModel.self, from: data)
            return model
        } catch let error {
            print(error)
            return nil
        }
    }
    func decodeMovieDetail(data: Data?) -> MovieDetailModel? {
        do {
            guard let data = data else { return nil}
            let model = try decoder.decode(MovieDetailModel.self, from: data)
            return model
        } catch let error {
            print(error)
            return nil
        }
    }
}
