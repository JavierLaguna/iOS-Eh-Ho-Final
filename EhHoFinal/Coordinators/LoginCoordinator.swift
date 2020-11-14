//
//  LoginCoordinator.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    // MARK: Properties
    private let presenter: UINavigationController
    private let topicDetailDataManager: TopicDetailDataManager
    
    
    init(presenter: UINavigationController,
         topicDetailDataManager: TopicDetailDataManager) {
        
        self.presenter = presenter
        self.topicDetailDataManager = topicDetailDataManager
    }
    
    override func start() {
//        let topicDetailViewModel = TopicDetailViewModel(topicID: topicId, topicDetailDataManager: topicDetailDataManager)
//        self.topicDetailViewModel = topicDetailViewModel
        let viewController = LoginViewController()
//        topicDetailViewModel.coordinatorDelegate = self
//        topicDetailViewModel.viewDelegate = topicDetailViewController
        
        presenter.setNavigationBarHidden(true, animated: true)
        presenter.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
//        presenter.popViewController(animated: true)
        
    
    }
    
}
