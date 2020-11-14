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
    
    typealias UserDidLogged = () -> Void
    var userDidLogged: UserDidLogged?
    
    init(presenter: UINavigationController,
         loginDataManager: LoginDataManager) {
        
        self.presenter = presenter
        self.loginDataManager = loginDataManager
    }
    
    override func start() {
        let viewModel = LoginViewModel(loginDataManager: loginDataManager)
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewModel.coordinatorDelegate = self
        viewModel.viewDelegate = viewController
        
        presenter.setNavigationBarHidden(true, animated: true)
        presenter.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        presenter.popViewController(animated: true)
    }
}

// MARK: LoginCoordinatorDelegate
extension LoginCoordinator: LoginCoordinatorDelegate {
    
    func userIsLogged() {
        userDidLogged?()
        finish()
    }
}
