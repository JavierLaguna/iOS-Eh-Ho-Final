//
//  LoginViewModel.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    // MARK: Properties
    private let loginDataManager: LoginDataManager
    
    //    weak var viewDelegate: TopicDetailViewDelegate?
    //    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    
    // MARK: Lifecycle
    init(loginDataManager: LoginDataManager) {
        self.loginDataManager = loginDataManager
    }
    
    func viewDidLoad() {
        //        fetchTopicDetail()
    }
    
    // MARK: Public Functions
    func refreshPosts() {
        
    }
}
