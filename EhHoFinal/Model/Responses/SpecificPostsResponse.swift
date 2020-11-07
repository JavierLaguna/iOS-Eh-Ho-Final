//
//  SpecificPostsResponse.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// Puedes echar un vistazo en https://docs.discourse.org

struct SpecificPostsResponse: Decodable {
    
    let posts: Posts
    
    enum CodingKeys: String, CodingKey {
        
        case posts
        case postStream = "post_stream"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let postStreamContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .postStream)
        posts = try postStreamContainer.decode(Posts.self, forKey: .posts)
    }
}
