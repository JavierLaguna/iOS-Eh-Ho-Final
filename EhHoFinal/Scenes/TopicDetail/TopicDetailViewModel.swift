//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func addPostButtonTapped(topic: Topic)
    func topicDetailBackButtonTapped()
    func topicDeleted()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopicDetail()
}

final class TopicDetailViewModel {
    
    // MARK: Properties
    private let topicDetailDataManager: TopicDetailDataManager
    private let topicID: Int
    private var chunkSize: Int?
    private var isGettingMorePosts = false
    
    var topic: Topic?
    var posts: Posts?
    var canDeleteTopic = false
    var allPostIds: [Int] = []
    
    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }
    
    func viewDidLoad() {
        fetchTopicDetail()
    }
    
    // MARK: Public Functions
    func refreshPosts() {
        fetchTopicDetail()
    }
    
    func fetchMorePosts() {
        guard !isGettingMorePosts,
              let currentPostCount = posts?.count,
              currentPostCount < allPostIds.count,
              let chunkSize = chunkSize else {
            return
        }
        
        isGettingMorePosts = true
        
        let from = currentPostCount
        let to = currentPostCount + chunkSize < allPostIds.count ? currentPostCount + chunkSize : allPostIds.count
        let nextPostIds = Array(allPostIds[from..<to])
        
        topicDetailDataManager.fetchSpecificPosts(of: topicID, postIds: nextPostIds) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let postsResp):
                guard let newPosts = postsResp?.posts else {
                    return
                }
                
                self.posts?.append(contentsOf: newPosts)
                self.viewDelegate?.topicDetailFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingTopicDetail()
            }
            
            self.isGettingMorePosts = false
        }
    }
    
    func replyTopic() {
        guard let topic = topic else { return }
        
        coordinatorDelegate?.addPostButtonTapped(topic: topic)
    }
    
    func deleteTopic() {
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success:
                self.coordinatorDelegate?.topicDeleted()
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorDeletingTopicDetail()
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
    
    // MARK: Private Functions
    private func fetchTopicDetail() {
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let topicResp):
                guard let topicResp = topicResp else { return }
                
                self.topic = topicResp.topic
                self.posts = topicResp.posts
                self.canDeleteTopic = topicResp.details.canDelete ?? false
                self.chunkSize = topicResp.topic.chunkSize
                self.allPostIds = topicResp.allPostIds
                
                self.viewDelegate?.topicDetailFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }
}
