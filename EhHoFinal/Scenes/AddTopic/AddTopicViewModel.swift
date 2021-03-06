//
//  AddTopicViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddTopicViewDelegate: class {
    func errorAddingTopic(text: String?)
}

final class AddTopicViewModel {
    
    // MARK: Properties
    private let dataManager: AddTopicDataManager
    
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        
        return formatter
    }
    
    // MARK: Lifecycle
    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: Public Functions
    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }
    
    func submitButtonTapped(title: String, body: String) {
        let createdAt = dateFormatter.string(from: Date())
        
        dataManager.addTopic(title: title, raw: body, createdAt: createdAt) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.coordinatorDelegate?.topicSuccessfullyAdded()
                
            case .failure(let error):
                Log.error(error)
                
                var errorMsg: String? = nil
                if let sessionApiError = error as? SessionAPIError {
                    errorMsg = sessionApiError.getFirstError()
                }
                
                self.viewDelegate?.errorAddingTopic(text: errorMsg)
            }
        }
    }
}
