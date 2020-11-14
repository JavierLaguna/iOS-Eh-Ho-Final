//
//  LatestTopicsRequest.swift
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation

/// Implementación de la request que obtiene los latest topics
struct LatestTopicsRequest: APIRequest {
    
    typealias Response = LatestTopicsResponse
    
    private let nextPage: String?
    
    init(nextPage: String?) {
        self.nextPage = nextPage
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        guard let nextPage = nextPage else {
            return "/latest.json"
        }
        
        return nextPage
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
