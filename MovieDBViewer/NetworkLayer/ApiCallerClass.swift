//
//  ApiCallerClass.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation
class ApiCallerClass {
    
    static let shared = ApiCallerClass()
    let session = URLSession.shared
    let parser = ResposeParserManager.shared
    let apiManager = ApiManager.shared
    
    private init() {}
    
    func fetchPopularMoviesApi(successCallBack: @escaping(PopularMoviesModel)->Void, failedCallBack: @escaping(String)->Void) {
        let param: [String : String] = ["language":"en-US","page": "1"]//page will change dynamically but now its static
        var fetchRequest = apiManager.requestConfiguration(url: .fetchPopularMovieList, param: param, method: .GET)
        fetchRequest?.allHTTPHeaderFields = HeaderManager.shared.configHeader(authorizationToken: ConstantsManager.authTokenKey)
        
        guard let serverRequest = fetchRequest else { return }
        
        let _ = session.dataTask(with: serverRequest) { (data, response, error) in
            if error == nil {
                guard let dataValue = data else {return }
                guard let model = self.parser.decodePopularMovies(data: dataValue) else { return }
                successCallBack(model)
            } else {
                failedCallBack(error?.localizedDescription ?? "Error In API calling")
            }
        }.resume()
    }
    
    func fetchMovieDetailApi(id: String,successCallBack: @escaping(MovieDetailModel)->Void, failedCallBack: @escaping(String)->Void) {
        let param: [String : String] = ["language":"en-US"]
        var fetchRequest = apiManager.requestConfiguration(url: .seletedMovieDetail, param: param, method: .GET)
        fetchRequest?.allHTTPHeaderFields = HeaderManager.shared.configHeader(authorizationToken: ConstantsManager.authTokenKey)
        
        guard let serverRequest = fetchRequest else { return }
        
        let _ = session.dataTask(with: serverRequest) { (data, response, error) in
            if error == nil {
                guard let dataValue = data else {return }
                guard let model = self.parser.decodeMovieDetail(data: dataValue) else { return }
                successCallBack(model)
            } else {
                failedCallBack(error?.localizedDescription ?? "Error In API calling")
            }
        }.resume()
    }
}
