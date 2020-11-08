//
//  TopicDetailCoordinator.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 08/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class TopicDetailCoordinator: Coordinator {
    
    // MARK: Properties
    private let presenter: UINavigationController
    private let topicDetailDataManager: TopicDetailDataManager
    private let addPostDataManager: AddPostDataManager
    private let topicId: Int
    
    init(presenter: UINavigationController,
         topicDetailDataManager: TopicDetailDataManager,
         addPostDataManager: AddPostDataManager,
         topicId: Int) {
        
        self.presenter = presenter
        self.topicDetailDataManager = topicDetailDataManager
        self.addPostDataManager = addPostDataManager
        self.topicId = topicId
    }
    
    override func start() {
        let topicDetailViewModel = TopicDetailViewModel(topicID: topicId, topicDetailDataManager: topicDetailDataManager)
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.coordinatorDelegate = self
        topicDetailViewModel.viewDelegate = topicDetailViewController
        
        presenter.pushViewController(topicDetailViewController, animated: true)
    }
    
    override func finish() {}
    
    private func startAddPost(topic: Topic) {
        let addPostViewModel = AddPostViewModel(dataManager: addPostDataManager)
        let addPostViewController = AddPostViewController(viewModel: addPostViewModel)
        addPostViewModel.coordinatorDelegate = self
        addPostViewModel.viewDelegate = addPostViewController
        
        presenter.present(addPostViewController, animated: true, completion: nil)
    }
}

// MARK: TopicDetailCoordinatorDelegate
extension TopicDetailCoordinator: TopicDetailCoordinatorDelegate {
    func addPostButtonTapped(topic: Topic) {
        startAddPost(topic: topic)
    }
    
    func topicDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
    }
    
    func topicDeleted() {
        presenter.popViewController(animated: true)
        //        topicsViewModel?.refreshTopics()
    }
}

// MARK: AddPostCoordinatorDelegate
extension TopicDetailCoordinator: AddPostCoordinatorDelegate {
    func addPostCancelButtonTapped() {
     
    }
    
    func postSuccessfullyAdded() {
     
    }
}
