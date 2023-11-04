//
//  ApiManager.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation
class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    func requestConfiguration(url: URLManager, param: [String: String] = [:], body: [String: String] = [:], method: MethodsType)-> URLRequest? {
        
        let urlconfig = NSURLComponents()
        let queryParameters = param.map({ URLQueryItem(name: $0.key, value: $0.value) }) //for url param
        
        urlconfig.queryItems = queryParameters
        let bodyData = try? JSONSerialization.data( //for bodyParam
            withJSONObject: body,
            options: []
        )
        
        guard let url = urlconfig.url(relativeTo: URL(string: url.rawValue)) else {return nil}
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        if method != .GET {
            urlRequest.httpBody = bodyData
        }
        
        return urlRequest
    }
}
enum MethodsType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case Delete = "DELETE"
}
