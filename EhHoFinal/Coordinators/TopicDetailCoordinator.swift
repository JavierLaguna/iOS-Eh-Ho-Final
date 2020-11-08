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
    
    private var addPostNavigationController: UINavigationController?
    private var topicDetailViewModel: TopicDetailViewModel?

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
        self.topicDetailViewModel = topicDetailViewModel
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.coordinatorDelegate = self
        topicDetailViewModel.viewDelegate = topicDetailViewController
        
        presenter.pushViewController(topicDetailViewController, animated: true)
    }
    
    override func finish() {}
    
    private func startAddPost(topic: Topic) {
        let addPostViewModel = AddPostViewModel(topic: topic, dataManager: addPostDataManager)
        let addPostViewController = AddPostViewController(viewModel: addPostViewModel)
        addPostViewModel.coordinatorDelegate = self
        addPostViewModel.viewDelegate = addPostViewController
        
        let navigationController = UINavigationController(rootViewController: addPostViewController)
        addPostNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }
    
    private func finishAddPost() {
        addPostNavigationController?.dismiss(animated: true, completion: nil)
        addPostNavigationController = nil
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
        // TODO:        topicsViewModel?.refreshTopics()
    }
}

// MARK: AddPostCoordinatorDelegate
extension TopicDetailCoordinator: AddPostCoordinatorDelegate {
    func addPostCancelButtonTapped() {
        finishAddPost()
    }
    
    func postSuccessfullyAdded() {
        finishAddPost()
        topicDetailViewModel?.refreshPosts()
    }
}
