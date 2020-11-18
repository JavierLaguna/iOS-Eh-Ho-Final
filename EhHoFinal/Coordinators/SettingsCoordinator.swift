//
//  SettingsCoordinator.swift
//  EhHoFinal
//
//  Created by Javier Laguna on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class SettingsCoordinator: Coordinator {
    
    // MARK: Properties
    private let presenter: UINavigationController
    private let loginDataManager: LoginDataManager
    
    typealias SettingsCoordinatorDidFinish = () -> Void
    var didFinish: SettingsCoordinatorDidFinish?
    
    // MARK: Lifecycle
    init(presenter: UINavigationController, loginDataManager: LoginDataManager) {
        self.presenter = presenter
        self.loginDataManager = loginDataManager
    }
    
    override func start() {
        let viewModel = SettingsViewModel(loginDataManager: loginDataManager)
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.title = "settings.title".localized()
        
        viewModel.coordinatorDelegate = self
        presenter.pushViewController(viewController, animated: false)
    }
    
    override func finish() {
        didFinish?()
    }
}

// MARK: SettingsCoordinatorDelegate
extension SettingsCoordinator: SettingsCoordinatorDelegate {
    
    func logout() {
        finish()
    }
}
