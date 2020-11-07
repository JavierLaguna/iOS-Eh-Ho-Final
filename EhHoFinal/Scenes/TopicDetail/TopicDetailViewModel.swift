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
    func topicDetailBackButtonTapped()
    func topicDeleted()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopicDetail()
}

class TopicDetailViewModel {
    
    // MARK: Properties
    private let topicDetailDataManager: TopicDetailDataManager
    private let topicID: Int
    
    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    
    var topic: Topic?
    var posts: Posts?
    var canDeleteTopic = false
    
    
    // MARK: Lifecycle
    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }
    
    func viewDidLoad() {
        fetchTopicDetail()
    }
    
    // MARK: Public Functions
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
                self.topic = topicResp?.topic
                self.posts = topicResp?.posts
                self.canDeleteTopic = topicResp?.details.canDelete ?? false
                
                self.viewDelegate?.topicDetailFetched()
                
            case .failure(let error):
                Log.error(error)
                self.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }
}
