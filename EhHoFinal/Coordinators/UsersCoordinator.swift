//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 01/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

final class UsersCoordinator: Coordinator {
    
    // MARK: Properties
    private let presenter: UINavigationController
    private let usersDataManager: UsersDataManager
    private let userDetailDataManager: UserDetailDataManager
    private var usersViewModel: UsersViewModel?
    
    // MARK: Lifecycle
    init(presenter: UINavigationController, usersDataManager: UsersDataManager,
         userDetailDataManager: UserDetailDataManager) {
        
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        
        self.usersViewModel = usersViewModel
        
        usersViewController.title = "users.title".localized()
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {}
}

// MARK: UsersCoordinatorDelegate
extension UsersCoordinator: UsersCoordinatorDelegate {
    
    func didSelect(user: User) {
        let userDetailViewModel = UserDetailViewModel(username: user.username, userDetailDataManager: userDetailDataManager)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        
        userDetailViewModel.coordinatorDelegate = self
        userDetailViewModel.viewDelegate = userDetailViewController
        
        presenter.present(userDetailViewController, animated: true, completion: nil)
    }
}

// MARK: UserDetailCoordinatorDelegate
extension UsersCoordinator: UserDetailCoordinatorDelegate {
    
    func userDetailBackButtonTapped(needUpdateUsers: Bool = false) {
        presenter.popViewController(animated: true)
        
        if needUpdateUsers {
            usersViewModel?.refreshUsers()
        }
    }
}
