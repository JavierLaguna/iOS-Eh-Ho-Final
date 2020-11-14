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
    private let loginDataManager: LoginDataManager
    
    
    init(presenter: UINavigationController,
         loginDataManager: LoginDataManager) {
        
        self.presenter = presenter
        self.loginDataManager = loginDataManager
    }
    
    override func start() {
        let viewModel = LoginViewModel(loginDataManager: loginDataManager)
        let viewController = LoginViewController(viewModel: viewModel)
        //        topicDetailViewModel.coordinatorDelegate = self
        viewModel.viewDelegate = viewController
        
        presenter.setNavigationBarHidden(true, animated: true)
        presenter.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        //        presenter.popViewController(animated: true)
    }
}
