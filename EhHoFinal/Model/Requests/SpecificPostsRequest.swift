//
//  SpecificPostsRequest.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct SpecificPostsRequest: APIRequest {
    
    typealias Response = SpecificPostsResponse
    
    private let topicId: Int
    private let postIds: [Int]
    
    init(topicId: Int, postIds: [Int]) {
        self.topicId = topicId
        self.postIds = postIds
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        let base = "/t/\(topicId)/posts.json"
        
        var query = ""
        postIds.forEach { item in
            query = "\(query)post_ids[]=\(item)&"
        }
        
        if query != "" {
            query = String(query.dropLast())
            return "\(base)?\(query))"
        }
        
        return base
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
