//
//  Post.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

typealias Posts = [Post]

struct Post: Codable {
    
    let id: Int
    let author: String
    let content: String
    let topicId: Int
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case author = "username"
        case content = "cooked"
        case topicId = "topic_id"
        case updatedAt = "updated_at"
    }
}
