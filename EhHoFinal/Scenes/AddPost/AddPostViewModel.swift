//
//  AddPostViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 08/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol AddPostViewDelegate: class {
    func loadTopic()
    func errorAddingPost(text: String?)
}

protocol AddPostCoordinatorDelegate: class {
    func addPostCancelButtonTapped()
    func postSuccessfullyAdded()
}

final class AddPostViewModel {
    
    // MARK: Properties
    private let topic: Topic
    private let dataManager: AddPostDataManager
    
    let topicTitleLabelText: String
    
    weak var viewDelegate: AddPostViewDelegate?
    weak var coordinatorDelegate: AddPostCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(topic: Topic, dataManager: AddPostDataManager) {
        self.topic = topic
        self.dataManager = dataManager
        self.topicTitleLabelText = topic.title
    }
    
    func viewDidLoad() {
        viewDelegate?.loadTopic()
    }
    
    // MARK: Public Functions
    func submitButtonTapped(body: String) {
        
        dataManager.addPost(topicId: topic.id, content: body) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.coordinatorDelegate?.postSuccessfullyAdded()()
                
            case .failure(let error):
                Log.error(error)
                
                var errorMsg: String? = nil
                if let sessionApiError = error as? SessionAPIError {
                    errorMsg = sessionApiError.getFirstError()
                }
                
                self.viewDelegate?.errorAddingPost(text: errorMsg)
            }
        }
    }
    
    func cancelButtonTapped() {
        coordinatorDelegate?.addPostCancelButtonTapped()
    }
}
