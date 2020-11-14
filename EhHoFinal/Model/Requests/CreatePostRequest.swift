//
//  CreatePostRequest.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 08/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CreatePostRequest: APIRequest {
    
    typealias Response = AddNewPostResponse
    
    private let topicId: Int
    private let content: String
    
    init(topicId: Int,
         content: String) {
        self.topicId = topicId
        self.content = content
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "topic_id": topicId,
            "raw": content
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
