//
//  PostCellViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

final class PostCellViewModel {
    
    // MARK: Properties
    private let post: Post
    
    var bodyLabelText: String?
    var postUpdatedAt: String?
    var author: String?
    
    // MARK: Lifecycle
    init(post: Post) {
        self.post = post
        
        self.author = post.author
        self.bodyLabelText = post.content
        self.postUpdatedAt = ""
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let updatedAt = formatter.date(from: post.updatedAt) {
            formatter.dateFormat = "MMM d"
            self.postUpdatedAt = formatter.string(from: updatedAt).capitalized
        }
    }
}
