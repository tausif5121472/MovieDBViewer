//
//  HeaderManager.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import Foundation

class HeaderManager {
    
    static let shared = HeaderManager()
    
    private init() {}
    
    func configHeader(authorizationToken: String) -> [String:String] {
        let header = ["accept": "application/json","Authorization":"Bearer \(authorizationToken)"]
        return header
    }
}
