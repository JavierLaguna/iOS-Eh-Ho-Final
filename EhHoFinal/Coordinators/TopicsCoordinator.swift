//
//  TopicsCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator que representa la pila de navegación del topics list.
/// Tiene como hijo el AddTopicCoordinator
final class TopicsCoordinator: Coordinator {
    
    // MARK: Properties
    private let presenter: UINavigationController
    private let topicsDataManager: TopicsDataManager
    private let topicDetailDataManager: TopicDetailDataManager
    private let addTopicDataManager: AddTopicDataManager
    private let addPostDataManager: AddPostDataManager
    
    private var topicsViewModel: TopicsViewModel?
    
    // MARK: Lifecycle
    init(presenter: UINavigationController,
         topicsDataManager: TopicsDataManager,
         topicDetailDataManager: TopicDetailDataManager,
         addTopicDataManager: AddTopicDataManager,
         addPostDataManager: AddPostDataManager) {
        
        self.presenter = presenter
        self.topicsDataManager = topicsDataManager
        self.topicDetailDataManager = topicDetailDataManager
        self.addTopicDataManager = addTopicDataManager
        self.addPostDataManager = addPostDataManager
    }
    
    override func start() {
        let topicsViewModel = TopicsViewModel(topicsDataManager: topicsDataManager)
        let topicsViewController = TopicsViewController(viewModel: topicsViewModel)
        
        self.topicsViewModel = topicsViewModel

        topicsViewController.title = "topics.title".localized()
        topicsViewModel.viewDelegate = topicsViewController
        topicsViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(topicsViewController, animated: false)
    }
    
    override func finish() {}
    
    private func startTopicDetail(of topic: Topic) {
        let topicDetailCoordinator = TopicDetailCoordinator(presenter: presenter, topicDetailDataManager: topicDetailDataManager, addPostDataManager: addPostDataManager, topicId: topic.id)
        
        addChildCoordinator(topicDetailCoordinator)
        topicDetailCoordinator.start()
        
        topicDetailCoordinator.topicDetailCoordinatorDidFinish = { [weak self] shouldUpdateTopics in
            guard let self = self, shouldUpdateTopics else { return }
            
            self.topicsViewModel?.refreshTopics()
        }
    }
    
    private func startAddTopic() {
        let addTopicCoordinator = AddTopicCoordinator(presenter: presenter, addTopicDataManager: addTopicDataManager)
        addChildCoordinator(addTopicCoordinator)
        addTopicCoordinator.start()
        
        addTopicCoordinator.onCancelTapped = { [weak self] in
            guard let self = self else { return }
            
            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
        }
        
        addTopicCoordinator.onTopicCreated = { [weak self] in
            guard let self = self else { return }
            
            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
            self.topicsViewModel?.newTopicWasCreated()
        }
    }
}

// MARK: TopicsCoordinatorDelegate
extension TopicsCoordinator: TopicsCoordinatorDelegate {
    func didSelect(topic: Topic) {
        startTopicDetail(of: topic)
    }
    
    func topicsPlusButtonTapped() {
        startAddTopic()
    }
}


