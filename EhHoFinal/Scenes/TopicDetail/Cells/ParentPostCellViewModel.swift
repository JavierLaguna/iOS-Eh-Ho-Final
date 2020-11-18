//
//  ParentPostCellViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 07/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

final class ParentPostCellViewModel {
    
    // MARK: Properties
    private let topic: Topic
    private let post: Post
    
    var titleLabelText: String?
    var bodyLabelText: String?
    var postsCount: String?
    var postersCount: String?
    var createPostDate: String?
    
    init(topic: Topic, post: Post) {
        self.topic = topic
        self.post = post
        
        self.titleLabelText = topic.title
        self.bodyLabelText = post.content
        self.postsCount = "\(topic.postsCount)"
        self.postersCount = "\(topic.posters?.count ?? 0)"
        self.createPostDate = ""
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let lastPostDate = formatter.date(from: topic.createdAt) {
            formatter.dateFormat = "MMM d"
            self.createPostDate = formatter.string(from: lastPostDate).capitalized
        }
    }
}
