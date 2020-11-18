//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewModel que representa un topic en la lista
final class TopicPostCellViewModel: TopicCellViewModel {
    
    // MARK: Properties
    static let imageSize = 100
    
    private let lastPoster: User
    let topic: Topic
    
    var textLabelText: String?
    var postsCount: String?
    var postersCount: String?
    var lastPostDate: String?
    var lastPosterImageUrl: URL?
        
    // MARK: Lifecycle
    init(topic: Topic, lastPoster: User) {
        self.topic = topic
        self.lastPoster = lastPoster
        
        self.textLabelText = topic.title
        self.postsCount = "\(topic.postsCount)"
        self.postersCount = "\(topic.posters?.count ?? 0)"
        self.lastPostDate = ""
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let lastPostDate = formatter.date(from: topic.lastPostedAt) {
            formatter.dateFormat = "MMM d"
            self.lastPostDate = formatter.string(from: lastPostDate).capitalized
        }
        
        let avatarUrl: String = lastPoster.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(TopicPostCellViewModel.imageSize)")
        self.lastPosterImageUrl = URL(string: "\(apiURL)\(avatarUrl)")
    }
}
