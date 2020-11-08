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
    private let dataManager: AddPostDataManager
    
    weak var viewDelegate: AddPostViewDelegate?
    weak var coordinatorDelegate: AddPostCoordinatorDelegate?
    
    
    // MARK: Lifecycle

    init(dataManager: AddPostDataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: Public Functions
    
}
